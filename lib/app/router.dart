import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe_app/features/auth/forgot_password_screen.dart';
import 'package:recipe_app/features/auth/login_screen.dart';
import 'package:recipe_app/features/auth/signup_screen.dart';
import 'package:recipe_app/features/cooking/cooking_complete_screen.dart';
import 'package:recipe_app/features/cooking/cooking_screen.dart';
import 'package:recipe_app/features/favorites/favorites_screen.dart';
import 'package:recipe_app/features/home/home_screen.dart';
import 'package:recipe_app/features/ingredients/ingredient_selection_screen.dart';
import 'package:recipe_app/features/profile/profile_screen.dart';
import 'package:recipe_app/features/recipes/recipe_detail_screen.dart';
import 'package:recipe_app/features/recipes/recipe_list_screen.dart';
import 'package:recipe_app/features/shell/main_shell.dart';
import 'package:recipe_app/features/splash/splash_screen.dart';
import 'package:recipe_app/providers/auth_provider.dart';

abstract final class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const favorites = '/favorites';
  static const profile = '/profile';
  static const ingredients = '/ingredients';
  static const recipes = '/recipes';
}

final _rootKey = GlobalKey<NavigatorState>();

class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(Ref ref) {
    _subscription = ref.listen<AuthState>(authProvider, (previous, next) {
      notifyListeners();
    });
  }

  late final ProviderSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authProvider);
      final location = state.matchedLocation;
      final isAuthRoute =
          location == AppRoutes.login ||
          location == AppRoutes.signup ||
          location == AppRoutes.forgotPassword;
      final isSplash = location == AppRoutes.splash;

      if (auth.status == AuthStatus.unknown) {
        return isSplash ? null : AppRoutes.splash;
      }

      if (auth.status == AuthStatus.unauthenticated) {
        if (isAuthRoute) return null;
        return AppRoutes.login;
      }

      if (isAuthRoute || isSplash) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favorites,
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: AppRoutes.ingredients,
        builder: (context, state) => const IngredientSelectionScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: AppRoutes.recipes,
        builder: (context, state) => const RecipeListScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: '${AppRoutes.recipes}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return RecipeDetailScreen(recipeId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: '${AppRoutes.recipes}/:id/cooking',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CookingScreen(recipeId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: '${AppRoutes.recipes}/:id/complete',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CookingCompleteScreen(recipeId: id);
        },
      ),
    ],
  );
});
