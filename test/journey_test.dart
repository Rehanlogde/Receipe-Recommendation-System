import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recipe_app/app/app.dart';
import 'package:recipe_app/features/ingredients/ingredient_selection_screen.dart';
import 'package:recipe_app/l10n/generated/app_localizations.dart';
import 'package:recipe_app/models/cooking_step.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/models/recipe_ingredient.dart';
import 'package:recipe_app/providers/favorite_provider.dart';
import 'package:recipe_app/providers/ingredient_provider.dart';
import 'package:recipe_app/services/mock/mock_recipe_service.dart';

void main() {
  testWidgets('full user journey: login to home to cooking and complete',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const ProviderScope(child: RecipeApp()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    // 1. Verify Login Screen
    expect(find.text(l10n.loginButton), findsOneWidget);

    // Enter login details
    final emailField = find.widgetWithText(TextField, l10n.email);
    final passwordField = find.widgetWithText(TextFormField, l10n.password);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);

    await tester.enterText(emailField, 'student@college.edu');
    await tester.enterText(passwordField, 'secret123');
    await tester.pump();

    // Tap Login
    await tester.tap(find.text(l10n.loginButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    // 2. Verify Home Screen loaded
    expect(find.text(l10n.findRecipes), findsOneWidget);
    expect(find.text(l10n.kitchenShortcut), findsOneWidget);

    // 3. Tap Kitchen / Find Recipes to go to Ingredient Selection
    await tester.tap(find.text(l10n.findRecipes));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text(l10n.selectIngredients), findsOneWidget);

    // Select ingredient "ing-onion"
    final container = ProviderScope.containerOf(tester.element(find.byType(IngredientSelectionScreen)));
    container.read(selectedIngredientsProvider.notifier).toggle('ing-onion');
    await tester.pump();
    await tester.pumpAndSettle();

    // Verify recommendations action is active
    final getRecsButton = find.widgetWithText(
      FilledButton,
      '${l10n.getRecommendations} (1)',
    );
    expect(getRecsButton, findsOneWidget);

    // Tap to go to Recipe List / Recommendations
    await tester.tap(getRecsButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    // 4. Verify Recipe List Screen
    expect(find.text(l10n.recommendedRecipes), findsOneWidget);
    expect(find.text(l10n.sortBestMatch), findsOneWidget);

    // Find first recipe card and tap it
    final dalTadka = find.text('Dal Tadka');
    expect(dalTadka, findsOneWidget);
    await tester.tap(dalTadka);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    // 5. Verify Recipe Detail Screen
    expect(find.text(l10n.recipeDetails), findsOneWidget);
    // Allow video provider to resolve
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    expect(find.text(l10n.startCooking), findsOneWidget);

    // Tap Start Cooking
    await tester.tap(find.text(l10n.startCooking));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    // 6. Verify Step-by-Step Cooking Screen
    expect(find.text(l10n.cookingMode), findsOneWidget);
    expect(find.text(l10n.stepOf(1, 3)), findsOneWidget);
    expect(find.text(l10n.nextStep), findsOneWidget);

    // Advance to Step 2
    await tester.tap(find.text(l10n.nextStep));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text(l10n.stepOf(2, 3)), findsOneWidget);

    // Advance to Step 3 (final step)
    await tester.tap(find.text(l10n.nextStep));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text(l10n.stepOf(3, 3)), findsOneWidget);
    expect(find.text(l10n.finishCooking), findsOneWidget);

    // Tap Finish Cooking
    await tester.tap(find.text(l10n.finishCooking));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    // 7. Verify Cooking Complete Screen
    expect(find.text(l10n.cookingComplete), findsOneWidget);
    expect(find.text(l10n.returnHome), findsOneWidget);
    expect(find.text(l10n.backToRecipe), findsOneWidget);

    // Tap Return to Home
    await tester.tap(find.text(l10n.returnHome));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    // Back on Home Screen
    expect(find.text(l10n.findRecipes), findsOneWidget);
  });

  test('MockRecipeService scoring with custom ingredient matches', () async {
    final service = MockRecipeService();
    // Test that passing custom onion matches dal tadka (which uses Onion)
    final recipes = await service.getRecommendedRecipes(['custom-onion']);
    expect(recipes.isNotEmpty, isTrue);
    expect(recipes.any((r) => r.id == 'recipe-dal-tadka'), isTrue);
  });

  test('RecipeMatchInfo calculates complete and missing ingredients safely',
      () {
    const testRecipe = Recipe(
      id: 'test-1',
      title: 'Quick Dish',
      description: 'Test recipe',
      category: 'Dinner',
      cookTimeMinutes: 20,
      servings: 2,
      difficulty: 'Easy',
      ingredients: [
        RecipeIngredient(ingredientId: 'ing-salt', name: 'Salt', quantity: '1 tsp'),
        RecipeIngredient(ingredientId: 'ing-rice', name: 'Rice', quantity: '1 cup'),
      ],
      steps: [
        CookingStep(order: 1, instruction: 'Boil rice with salt', durationMinutes: 15),
      ],
    );

    // Only Salt selected
    final partialMatch = testRecipe.getMatchInfo({'ing-salt'});
    expect(partialMatch.matchedCount, equals(1));
    expect(partialMatch.totalCount, equals(2));
    expect(partialMatch.isComplete, isFalse);
    expect(partialMatch.hasMatch, isTrue);
    expect(partialMatch.hasMissing, isTrue);
    expect(partialMatch.missingIngredients.first.name, equals('Rice'));

    // Both selected
    final fullMatch = testRecipe.getMatchInfo({'ing-salt', 'ing-rice'});
    expect(fullMatch.matchedCount, equals(2));
    expect(fullMatch.isComplete, isTrue);
    expect(fullMatch.hasMissing, isFalse);
  });

  test('FavoriteNotifier toggles and checks consistency', () {
    final notifier = FavoriteNotifier();
    expect(notifier.contains('recipe-1'), isFalse);
    notifier.toggle('recipe-1');
    expect(notifier.contains('recipe-1'), isTrue);
    notifier.toggle('recipe-1');
    expect(notifier.contains('recipe-1'), isFalse);
  });

  test('CustomIngredientsNotifier avoids duplicates', () {
    final notifier = CustomIngredientsNotifier();
    final item1 = notifier.addCustom('Coriander');
    final item2 = notifier.addCustom('Coriander');
    expect(item1.id, equals(item2.id));
    expect(notifier.state.length, equals(1));
  });
}
