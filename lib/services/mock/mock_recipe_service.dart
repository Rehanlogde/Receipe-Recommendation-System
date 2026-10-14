import 'package:recipe_app/core/constants/app_constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/mock/mock_data.dart';
import 'package:recipe_app/services/recipe_service.dart';

class MockRecipeService implements RecipeService {
  @override
  Future<List<Recipe>> getPopularRecipes() async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    return MockData.recipes.take(4).toList();
  }

  @override
  Future<List<Recipe>> getRecommendedRecipes(List<String> ingredientIds) async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    if (ingredientIds.isEmpty) return const [];

    final selected = ingredientIds.toSet();
    final scored =
        MockData.recipes
            .map((recipe) {
              final matchInfo = recipe.getMatchInfo(selected);
              return (recipe, matchInfo.matchedCount);
            })
            .where((entry) => entry.$2 > 0)
            .toList()
          ..sort((a, b) => b.$2.compareTo(a.$2));

    return scored.map((entry) => entry.$1).toList();
  }

  @override
  Future<Recipe> getRecipeById(String id) async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    return MockData.recipes.firstWhere(
      (recipe) => recipe.id == id,
      orElse: () => throw StateError('Recipe not found: $id'),
    );
  }

  @override
  Future<List<Recipe>> getRecipesByIds(List<String> ids) async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    final idSet = ids.toSet();
    return MockData.recipes
        .where((recipe) => idSet.contains(recipe.id))
        .toList();
  }
}
