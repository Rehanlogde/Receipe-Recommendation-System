import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe_app/app/router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/constants/app_spacing.dart';
import 'package:recipe_app/core/localization/l10n_x.dart';
import 'package:recipe_app/core/utils/max_width.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/favorite_provider.dart';
import 'package:recipe_app/providers/ingredient_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/video_provider.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/widgets/error_state.dart';
import 'package:recipe_app/widgets/loading_widget.dart';

class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeAsync = ref.watch(recipeByIdProvider(recipeId));
    final saved = ref.watch(favoriteProvider).contains(recipeId);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.recipeDetails),
        actions: [
          IconButton(
            tooltip: saved ? l10n.removeFromFavorites : l10n.addToFavorites,
            onPressed: () =>
                ref.read(favoriteProvider.notifier).toggle(recipeId),
            icon: Icon(
              saved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: saved ? Colors.redAccent : null,
            ),
          ),
        ],
      ),
      body: recipeAsync.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => ErrorState(
          message: error.toString(),
          onRetry: () => ref.invalidate(recipeByIdProvider(recipeId)),
        ),
        data: (recipe) => _RecipeBody(recipe: recipe),
      ),
      bottomNavigationBar: recipeAsync.maybeWhen(
        data: (recipe) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: MaxWidth(
              child: AppButton(
                label: l10n.startCooking,
                icon: Icons.soup_kitchen_rounded,
                onPressed: () =>
                    context.push('${AppRoutes.recipes}/$recipeId/cooking'),
              ),
            ),
          ),
        ),
        orElse: () => null,
      ),
    );
  }
}

class _RecipeBody extends ConsumerWidget {
  const _RecipeBody({required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final videoAsync = ref.watch(recipeVideoProvider(recipe.id));
    final selectedIngredients = ref.watch(selectedIngredientsProvider);
    final theme = Theme.of(context);
    final matchInfo = recipe.getMatchInfo(selectedIngredients);

    return MaxWidth(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Banner Image with Fallback
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: (recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty)
                ? Image.network(
                    recipe.imageUrl!,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => _fallbackBanner(),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 220,
                        color: AppColors.primarySoft,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  )
                : _fallbackBanner(),
          ),
          const SizedBox(height: 16),

          Text(
            recipe.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            recipe.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),

          // Meta Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoChip(
                icon: Icons.schedule_rounded,
                label: l10n.cookTime(recipe.cookTimeMinutes),
              ),
              _InfoChip(
                icon: Icons.people_alt_outlined,
                label: l10n.servingsLabel(recipe.servings),
              ),
              _InfoChip(
                icon: Icons.bar_chart_rounded,
                label: recipe.difficulty,
              ),
              if (selectedIngredients.isNotEmpty)
                _InfoChip(
                  icon: matchInfo.isComplete
                      ? Icons.check_circle_rounded
                      : Icons.kitchen_rounded,
                  label: l10n.inKitchen(
                    matchInfo.matchedCount,
                    matchInfo.totalCount,
                  ),
                  backgroundColor: matchInfo.isComplete
                      ? Colors.green.shade50
                      : AppColors.primarySoft,
                  textColor: matchInfo.isComplete
                      ? Colors.green.shade800
                      : AppColors.primary,
                  iconColor: matchInfo.isComplete
                      ? Colors.green.shade700
                      : AppColors.primary,
                ),
            ],
          ),

          const SizedBox(height: 24),

          // Ingredients Section with Match Checkmarks
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.ingredients, style: theme.textTheme.titleLarge),
              if (selectedIngredients.isNotEmpty && matchInfo.hasMissing)
                Text(
                  l10n.missingCount(matchInfo.missingIngredients.length),
                  style: TextStyle(
                    color: Colors.orange.shade800,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  for (final item in recipe.ingredients) ...[
                    _IngredientRow(
                      item: item,
                      isInKitchen:
                          selectedIngredients.isNotEmpty &&
                          matchInfo.matchedIngredients.any(
                            (m) => m.ingredientId == item.ingredientId,
                          ),
                      hasSelectedItems: selectedIngredients.isNotEmpty,
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Steps Section
          Text(l10n.steps, style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          for (final step in recipe.steps)
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primarySoft,
                  foregroundColor: AppColors.primary,
                  child: Text('${step.order}'),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.stepLabel(step.order),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    if (step.durationMinutes != null)
                      Text(
                        '${step.durationMinutes} min',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(step.instruction),
                ),
              ),
            ),

          const SizedBox(height: 16),

          // Video Section
          Text(l10n.video, style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          videoAsync.when(
            loading: () => Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Loading tutorial...',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            error: (error, _) => Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.videocam_off_outlined,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tutorial not available',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Please check again later.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            data: (video) {
              if (video == null) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.videocam_off_outlined,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No video tutorial yet',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Follow the written steps above for now.',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Opening video: ${video.title}',
                          maxLines: 2,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.primarySoft,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.play_circle_fill_rounded,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Watch the recipe video',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                video.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                video.channelName ?? 'Recipe tutorial',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _fallbackBanner() {
    return Container(
      height: 220,
      width: double.infinity,
      color: AppColors.primarySoft,
      child: const Center(
        child: Icon(
          Icons.restaurant_rounded,
          color: AppColors.primary,
          size: 56,
        ),
      ),
    );
  }
}

class _IngredientRow extends StatelessWidget {
  const _IngredientRow({
    required this.item,
    required this.isInKitchen,
    required this.hasSelectedItems,
  });

  final dynamic item;
  final bool isInKitchen;
  final bool hasSelectedItems;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(
        hasSelectedItems
            ? (isInKitchen
                  ? Icons.check_circle_rounded
                  : Icons.remove_circle_outline_rounded)
            : Icons.circle_outlined,
        size: 20,
        color: hasSelectedItems
            ? (isInKitchen ? Colors.green.shade600 : Colors.orange.shade700)
            : AppColors.primary,
      ),
      title: Text(
        item.name,
        style: TextStyle(
          fontWeight: isInKitchen ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(item.displayQuantity),
          if (hasSelectedItems) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isInKitchen
                    ? Colors.green.shade50
                    : Colors.orange.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isInKitchen ? 'In kitchen' : 'Needed',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: isInKitchen
                      ? Colors.green.shade800
                      : Colors.orange.shade800,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18, color: iconColor ?? AppColors.primary),
      label: Text(
        label,
        style: TextStyle(
          color: textColor ?? AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: backgroundColor ?? AppColors.primarySoft,
      side: BorderSide.none,
    );
  }
}
