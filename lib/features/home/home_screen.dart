import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe_app/app/router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/constants/app_spacing.dart';
import 'package:recipe_app/core/localization/l10n_x.dart';
import 'package:recipe_app/core/utils/max_width.dart';
import 'package:recipe_app/providers/auth_provider.dart';
import 'package:recipe_app/providers/favorite_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/widgets/error_state.dart';
import 'package:recipe_app/widgets/loading_widget.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const _quickCategories = [
    ('Vegetable', Icons.eco_rounded),
    ('Grain', Icons.grain_rounded),
    ('Lentil', Icons.spa_rounded),
    ('Dairy', Icons.egg_alt_rounded),
    ('Spice', Icons.local_fire_department_rounded),
    ('Staple', Icons.inventory_2_rounded),
    ('Fruit', Icons.apple_rounded),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(authProvider).user;
    final popular = ref.watch(popularRecipesProvider);
    final favorites = ref.watch(favoriteProvider);
    final name = user?.name ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.restaurant_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              l10n.appTitle,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: l10n.favorites,
            onPressed: () => context.go(AppRoutes.favorites),
            icon: Badge(
              isLabelVisible: favorites.isNotEmpty,
              label: Text('${favorites.length}'),
              child: const Icon(
                Icons.favorite_rounded,
                color: Colors.redAccent,
              ),
            ),
          ),
          IconButton(
            tooltip: l10n.profile,
            onPressed: () => context.go(AppRoutes.profile),
            icon: CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.primarySoft,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: MaxWidth(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            children: [
              const SizedBox(height: 12),
              Text(
                l10n.welcomeUser(name),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.homeSubtitle,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 18),
              // Search Shortcut Action
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => context.push(AppRoutes.ingredients),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.outline),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.searchHintHome,
                          style: TextStyle(
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.8,
                            ),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.tune_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Kitchen Entry Point Card
              Card(
                color: AppColors.primarySoft,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: AppColors.outline),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.kitchen_rounded,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.kitchenShortcut,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  l10n.selectIngredientsHint,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppButton(
                        label: l10n.findRecipes,
                        icon: Icons.auto_awesome_rounded,
                        onPressed: () => context.push(AppRoutes.ingredients),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Quick Categories Section
              Text(
                l10n.filterByCategory,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _quickCategories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final item = _quickCategories[index];
                    return ActionChip(
                      avatar: Icon(item.$2, size: 16, color: AppColors.primary),
                      label: Text(item.$1),
                      backgroundColor: AppColors.surface,
                      side: const BorderSide(color: AppColors.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () => context.push(AppRoutes.ingredients),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              // Popular Recipes Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.popularRecipes,
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () => context.push(AppRoutes.recipes),
                    child: Text(l10n.viewAll),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              popular.when(
                data: (recipes) => Column(
                  children: [
                    for (final recipe in recipes) ...[
                      RecipeCard(
                        recipe: recipe,
                        isFavorite: favorites.contains(recipe.id),
                        onFavoriteToggle: () => ref
                            .read(favoriteProvider.notifier)
                            .toggle(recipe.id),
                        onTap: () =>
                            context.push('${AppRoutes.recipes}/${recipe.id}'),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: LoadingWidget(),
                ),
                error: (error, _) => ErrorState(
                  message: error.toString(),
                  onRetry: () => ref.invalidate(popularRecipesProvider),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
