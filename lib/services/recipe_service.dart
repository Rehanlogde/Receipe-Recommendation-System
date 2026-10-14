import 'package:recipe_app/models/recipe.dart';

abstract class RecipeService {
  Future<List<Recipe>> getPopularRecipes();

  Future<List<Recipe>> getRecommendedRecipes(List<String> ingredientIds);

  Future<Recipe> getRecipeById(String id);

  Future<List<Recipe>> getRecipesByIds(List<String> ids);
}
