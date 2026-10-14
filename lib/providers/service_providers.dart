import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_app/services/auth_service.dart';
import 'package:recipe_app/services/ingredient_service.dart';
import 'package:recipe_app/services/mock/mock_auth_service.dart';
import 'package:recipe_app/services/mock/mock_ingredient_service.dart';
import 'package:recipe_app/services/mock/mock_recipe_service.dart';
import 'package:recipe_app/services/mock/mock_video_service.dart';
import 'package:recipe_app/services/recipe_service.dart';
import 'package:recipe_app/services/video_service.dart';

/// Swap mock implementations here when the FastAPI backend is ready.
/// Example:
/// `authServiceProvider` -> `ApiAuthService(client)`
final authServiceProvider = Provider<AuthService>((ref) {
  return MockAuthService();
});

final ingredientServiceProvider = Provider<IngredientService>((ref) {
  return MockIngredientService();
});

final recipeServiceProvider = Provider<RecipeService>((ref) {
  return MockRecipeService();
});

final videoServiceProvider = Provider<VideoService>((ref) {
  return MockVideoService();
});
