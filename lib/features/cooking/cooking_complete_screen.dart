import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe_app/app/router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/constants/app_spacing.dart';
import 'package:recipe_app/core/localization/l10n_x.dart';
import 'package:recipe_app/core/utils/max_width.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/widgets/loading_widget.dart';

class CookingCompleteScreen extends ConsumerWidget {
  const CookingCompleteScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeAsync = ref.watch(recipeByIdProvider(recipeId));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        // Navigate back to the recipe details safely
        context.go('${AppRoutes.recipes}/$recipeId');
      },
      child: Scaffold(
        body: SafeArea(
          child: MaxWidth(
            child: recipeAsync.when(
              loading: () => const LoadingWidget(),
              error: (_, _) => _buildFallbackContent(context),
              data: (recipe) => _buildSuccessContent(context, recipe),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessContent(BuildContext context, Recipe recipe) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          // Festive Celebratory Visual
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.soup_kitchen_rounded,
                    size: 56,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Congratulatory Header
          Text(
            l10n.cookingComplete,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.cookingCompleteSubtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // Recipe Highlight Card
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.outline),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: recipe.imageUrl != null &&
                              recipe.imageUrl!.isNotEmpty
                          ? Image.network(
                              recipe.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => _fallbackThumbnail(),
                            )
                          : _fallbackThumbnail(),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule_rounded,
                              size: 14,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              l10n.cookTime(recipe.cookTimeMinutes),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.checklist_rounded,
                              size: 14,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${recipe.steps.length} steps',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 36),

          // Primary Actions
          AppButton(
            label: l10n.returnHome,
            icon: Icons.home_rounded,
            onPressed: () => context.go(AppRoutes.home),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => context.go('${AppRoutes.recipes}/$recipeId'),
            icon: const Icon(Icons.arrow_back_rounded, size: 18),
            label: Text(l10n.backToRecipe),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFallbackContent(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              size: 64,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.cookingComplete,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: l10n.returnHome,
              icon: Icons.home_rounded,
              onPressed: () => context.go(AppRoutes.home),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.go('${AppRoutes.recipes}/$recipeId'),
              child: Text(l10n.backToRecipe),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fallbackThumbnail() {
    return Container(
      color: AppColors.primarySoft,
      child: const Center(
        child: Icon(
          Icons.restaurant_rounded,
          color: AppColors.primary,
          size: 24,
        ),
      ),
    );
  }
}
