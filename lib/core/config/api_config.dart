/// API Configuration and Integration Contracts for Recipe Recommendation System.
///
/// Teammates working on the backend (FastAPI / PostgreSQL) can refer to these
/// endpoints and data contracts to integrate with this Flutter frontend.
abstract final class ApiConfig {
  /// Base URL of the backend API server.
  /// Can be overridden during build or runtime using `--dart-define=API_BASE_URL=https://api.example.com`.
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );

  /// Authentication endpoints
  static const String authLogin = '/api/auth/login';
  static const String authSignUp = '/api/auth/signup';
  static const String authResetPassword = '/api/auth/forgot-password';
  static const String authCurrentUser = '/api/auth/me';

  /// Ingredient endpoints
  static const String getIngredients = '/api/ingredients';
  static const String searchIngredients = '/api/ingredients/search';

  /// Recipe endpoints
  static const String getRecipes = '/api/recipes';
  static const String getPopularRecipes = '/api/recipes/popular';
  static const String getRecommendedRecipes = '/api/recipes/recommend';
  static String getRecipeById(String id) => '/api/recipes/$id';

  /// Video endpoints
  static String getVideoByRecipeId(String recipeId) =>
      '/api/recipes/$recipeId/video';
}
