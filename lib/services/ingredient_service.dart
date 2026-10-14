import 'package:recipe_app/models/ingredient.dart';

abstract class IngredientService {
  Future<List<Ingredient>> getIngredients();

  Future<List<Ingredient>> searchIngredients(String query);
}
