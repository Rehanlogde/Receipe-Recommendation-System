import 'package:recipe_app/core/constants/app_constants.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/services/ingredient_service.dart';
import 'package:recipe_app/services/mock/mock_data.dart';

class MockIngredientService implements IngredientService {
  @override
  Future<List<Ingredient>> getIngredients() async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    return List<Ingredient>.from(MockData.ingredients);
  }

  @override
  Future<List<Ingredient>> searchIngredients(String query) async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) {
      return List<Ingredient>.from(MockData.ingredients);
    }
    return MockData.ingredients
        .where(
          (ingredient) =>
              ingredient.name.toLowerCase().contains(needle) ||
              ingredient.category.toLowerCase().contains(needle),
        )
        .toList();
  }
}
