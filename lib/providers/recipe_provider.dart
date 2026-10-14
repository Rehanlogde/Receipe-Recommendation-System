import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/favorite_provider.dart';
import 'package:recipe_app/providers/ingredient_provider.dart';
import 'package:recipe_app/providers/service_providers.dart';

final popularRecipesProvider = FutureProvider<List<Recipe>>((ref) {
  return ref.watch(recipeServiceProvider).getPopularRecipes();
});

final recommendedRecipesProvider = FutureProvider<List<Recipe>>((ref) {
  final selected = ref.watch(selectedIngredientsProvider).toList();
  return ref.watch(recipeServiceProvider).getRecommendedRecipes(selected);
});

final recipeByIdProvider = FutureProvider.family<Recipe, String>((ref, id) {
  return ref.watch(recipeServiceProvider).getRecipeById(id);
});

final favoriteRecipesProvider = FutureProvider<List<Recipe>>((ref) {
  final ids = ref.watch(favoriteProvider).toList();
  return ref.watch(recipeServiceProvider).getRecipesByIds(ids);
});
