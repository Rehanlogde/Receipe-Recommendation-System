import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe_app/app/router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/constants/app_spacing.dart';
import 'package:recipe_app/core/localization/l10n_x.dart';
import 'package:recipe_app/core/utils/max_width.dart';
import 'package:recipe_app/models/cooking_step.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/widgets/error_state.dart';
import 'package:recipe_app/widgets/loading_widget.dart';

class CookingScreen extends ConsumerStatefulWidget {
  const CookingScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  ConsumerState<CookingScreen> createState() => _CookingScreenState();
}

class _CookingScreenState extends ConsumerState<CookingScreen> {
  int _currentStepIndex = 0;

  // Local step timer state
  Timer? _timer;
  int _remainingSeconds = 0;
  int _totalStepSeconds = 0;
  bool _isRunning = false;
  bool _isTimerComplete = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initTimerForStep(CookingStep step) {
    _timer?.cancel();
    final minutes = step.durationMinutes ?? 0;
    _totalStepSeconds = minutes * 60;
    _remainingSeconds = _totalStepSeconds;
    _isRunning = false;
    _isTimerComplete = false;
  }

  void _startTimer() {
    if (_remainingSeconds <= 0) return;
    _timer?.cancel();
    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remainingSeconds > 1) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        setState(() {
          _remainingSeconds = 0;
          _isRunning = false;
          _isTimerComplete = true;
        });
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer(CookingStep step) {
    _timer?.cancel();
    final minutes = step.durationMinutes ?? 0;
    setState(() {
      _totalStepSeconds = minutes * 60;
      _remainingSeconds = _totalStepSeconds;
      _isRunning = false;
      _isTimerComplete = false;
    });
  }

  void _addMinute() {
    setState(() {
      _remainingSeconds += 60;
      _totalStepSeconds += 60;
      _isTimerComplete = false;
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final minStr = minutes.toString().padLeft(2, '0');
    final secStr = seconds.toString().padLeft(2, '0');
    return '$minStr:$secStr';
  }

  void _goToNextStep(int totalSteps, List<CookingStep> steps) {
    if (_currentStepIndex < totalSteps - 1) {
      setState(() {
        _currentStepIndex++;
        _initTimerForStep(steps[_currentStepIndex]);
      });
    } else {
      // Completed all steps -> Navigate to Cooking Complete
      context.go('${AppRoutes.recipes}/${widget.recipeId}/complete');
    }
  }

  void _goToPreviousStep(List<CookingStep> steps) {
    if (_currentStepIndex > 0) {
      setState(() {
        _currentStepIndex--;
        _initTimerForStep(steps[_currentStepIndex]);
      });
    }
  }

  Future<bool> _confirmExit() async {
    final l10n = context.l10n;
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave Cooking Mode?'),
        content: const Text(
          'Your current cooking step progress will be discarded.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final recipeAsync = ref.watch(recipeByIdProvider(widget.recipeId));
    final l10n = context.l10n;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldExit = await _confirmExit();
        if (shouldExit && context.mounted) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.cookingMode),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            tooltip: 'Exit cooking',
            onPressed: () async {
              final shouldExit = await _confirmExit();
              if (shouldExit && context.mounted) {
                context.pop();
              }
            },
          ),
        ),
        body: recipeAsync.when(
          loading: () => const LoadingWidget(),
          error: (error, _) => ErrorState(
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(recipeByIdProvider(widget.recipeId)),
          ),
          data: (recipe) => _buildCookingBody(context, recipe),
        ),
        bottomNavigationBar: recipeAsync.maybeWhen(
          data: (recipe) {
            final steps = recipe.steps;
            if (steps.isEmpty) return null;
            final totalSteps = steps.length;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: MaxWidth(
                  child: Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: _currentStepIndex > 0
                            ? () => _goToPreviousStep(steps)
                            : null,
                        icon: const Icon(Icons.arrow_back_rounded, size: 18),
                        label: Text(l10n.previousStep),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                _currentStepIndex == totalSteps - 1
                                    ? Colors.green.shade700
                                    : AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () => _goToNextStep(totalSteps, steps),
                          icon: Icon(
                            _currentStepIndex == totalSteps - 1
                                ? Icons.check_circle_rounded
                                : Icons.arrow_forward_rounded,
                            size: 20,
                          ),
                          label: Text(
                            _currentStepIndex == totalSteps - 1
                                ? l10n.finishCooking
                                : l10n.nextStep,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          orElse: () => null,
        ),
      ),
    );
  }

  Widget _buildCookingBody(BuildContext context, Recipe recipe) {
    final l10n = context.l10n;
    final steps = recipe.steps;

    if (steps.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'No instructions required for ${recipe.title}.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              AppButton(
                label: l10n.finishCooking,
                onPressed: () => context.go(
                  '${AppRoutes.recipes}/${widget.recipeId}/complete',
                ),
              ),
            ],
          ),
        ),
      );
    }

    final totalSteps = steps.length;
    final currentStep = steps[_currentStepIndex];
    final progress = (_currentStepIndex + 1) / totalSteps;
    final hasDuration =
        currentStep.durationMinutes != null &&
        currentStep.durationMinutes! > 0;

    return MaxWidth(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Linear Progress Indicator
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.outline.withValues(alpha: 0.4),
            color: AppColors.primary,
            minHeight: 6,
          ),
          const SizedBox(height: 16),

          // Recipe Name & Step Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  recipe.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  l10n.stepOf(_currentStepIndex + 1, totalSteps),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Step Card
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.outline),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        child: Text(
                          '${currentStep.order}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.stepLabel(currentStep.order),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      if (hasDuration)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 14,
                                color: Colors.blue.shade800,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${currentStep.durationMinutes} min',
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentStep.instruction,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      height: 1.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Timer Section (when step has duration)
          if (hasDuration) ...[
            _buildTimerCard(context, currentStep),
          ] else ...[
            // Untimed Step Notice
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outline),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.schedule_outlined,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.untimedStep,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTimerCard(BuildContext context, CookingStep step) {
    final l10n = context.l10n;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: _isTimerComplete
              ? Colors.green.shade400
              : _isRunning
                  ? AppColors.primary
                  : AppColors.outline,
          width: _isRunning || _isTimerComplete ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isTimerComplete
                      ? Icons.check_circle_rounded
                      : Icons.timer_rounded,
                  color: _isTimerComplete
                      ? Colors.green.shade600
                      : AppColors.primary,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  _isTimerComplete
                      ? l10n.timerDone
                      : _formatTime(_remainingSeconds),
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    color: _isTimerComplete
                        ? Colors.green.shade700
                        : _isRunning
                            ? AppColors.primary
                            : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Timer Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isRunning) ...[
                  FilledButton.icon(
                    onPressed: _startTimer,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: Text(
                      _remainingSeconds < _totalStepSeconds
                          ? l10n.timerResume
                          : l10n.timerStart,
                    ),
                  ),
                ] else ...[
                  FilledButton.tonalIcon(
                    onPressed: _pauseTimer,
                    icon: const Icon(Icons.pause_rounded),
                    label: Text(l10n.timerPause),
                  ),
                ],
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => _resetTimer(step),
                  icon: const Icon(Icons.replay_rounded, size: 18),
                  label: Text(l10n.timerReset),
                ),
                const SizedBox(width: 8),
                IconButton.outlined(
                  tooltip: l10n.addOneMinute,
                  onPressed: _addMinute,
                  icon: const Icon(Icons.more_time_rounded, size: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
