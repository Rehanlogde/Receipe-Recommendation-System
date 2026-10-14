import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe_app/app/router.dart';
import 'package:recipe_app/core/constants/app_spacing.dart';
import 'package:recipe_app/core/localization/l10n_x.dart';
import 'package:recipe_app/core/utils/max_width.dart';
import 'package:recipe_app/providers/favorite_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/widgets/empty_state.dart';
import 'package:recipe_app/widgets/error_state.dart';
import 'package:recipe_app/widgets/loading_widget.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final favoritesAsync = ref.watch(favoriteRecipesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.favorites)),
      body: favoritesAsync.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => ErrorState(
          message: error.toString(),
          onRetry: () => ref.invalidate(favoriteRecipesProvider),
        ),
        data: (recipes) {
          if (recipes.isEmpty) {
            return EmptyState(
              title: l10n.noFavorites,
              message: l10n.noFavoritesHint,
              icon: Icons.favorite_outline_rounded,
            );
          }

          return MaxWidth(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: recipes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return RecipeCard(
                  recipe: recipe,
                  isFavorite: true,
                  onFavoriteToggle: () =>
                      ref.read(favoriteProvider.notifier).toggle(recipe.id),
                  onTap: () =>
                      context.push('${AppRoutes.recipes}/${recipe.id}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
