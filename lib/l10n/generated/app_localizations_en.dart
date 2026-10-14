// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Recipe Guide';

  @override
  String get login => 'Log in';

  @override
  String get signup => 'Sign up';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get name => 'Name';

  @override
  String get loginButton => 'Log in';

  @override
  String get signupButton => 'Create account';

  @override
  String get sendResetLink => 'Send reset link';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get orContinueWith => 'or continue with';

  @override
  String get noAccount => 'New here? Sign up';

  @override
  String get haveAccount => 'Already have an account? Log in';

  @override
  String get backToLogin => 'Back to log in';

  @override
  String get home => 'Home';

  @override
  String get favorites => 'Favorites';

  @override
  String get profile => 'Profile';

  @override
  String welcomeUser(String name) {
    return 'Hello, $name';
  }

  @override
  String get homeSubtitle =>
      'Cook tasty meals with the ingredients you already have.';

  @override
  String get findRecipes => 'Find recipes';

  @override
  String get selectIngredients => 'Select ingredients';

  @override
  String get selectIngredientsHint =>
      'Tap the items in your kitchen. Then we will suggest recipes.';

  @override
  String get searchIngredients => 'Search ingredients';

  @override
  String get getRecommendations => 'Show recipes';

  @override
  String selectedCount(int count) {
    return '$count selected';
  }

  @override
  String get recommendedRecipes => 'Suggested recipes';

  @override
  String get recipeDetails => 'Recipe';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get steps => 'Steps';

  @override
  String get video => 'Cooking video';

  @override
  String get watchVideo => 'Watch video';

  @override
  String get videoUnavailable => 'No video yet for this recipe.';

  @override
  String cookTime(int minutes) {
    return '$minutes min';
  }

  @override
  String servingsLabel(int count) {
    return '$count servings';
  }

  @override
  String get difficulty => 'Level';

  @override
  String get addToFavorites => 'Save';

  @override
  String get removeFromFavorites => 'Saved';

  @override
  String get logout => 'Log out';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get hindi => 'Hindi';

  @override
  String get marathi => 'Marathi';

  @override
  String get noRecipes => 'No recipes found';

  @override
  String get noRecipesHint =>
      'Try selecting more ingredients from your kitchen.';

  @override
  String get noFavorites => 'No saved recipes yet';

  @override
  String get noFavoritesHint => 'Open a recipe and tap Save to keep it here.';

  @override
  String get noIngredients => 'No ingredients match your search.';

  @override
  String get loading => 'Please wait…';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get tryAgain => 'Try again';

  @override
  String get resetPasswordHint =>
      'Enter your email. We will send a reset link.';

  @override
  String get resetEmailSent =>
      'If this email is registered, a reset link has been sent.';

  @override
  String get invalidEmail => 'Enter a valid email address.';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters.';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match.';

  @override
  String get nameRequired => 'Please enter your name.';

  @override
  String get emailRequired => 'Please enter your email.';

  @override
  String get passwordRequired => 'Please enter your password.';

  @override
  String get selectAtLeastOne => 'Please select at least one ingredient.';

  @override
  String get demoHint => 'Demo mode: any valid email and password will work.';

  @override
  String get popularRecipes => 'Popular recipes';

  @override
  String stepLabel(int number) {
    return 'Step $number';
  }

  @override
  String get googleSignInSoon => 'Google Sign-In will be connected later.';

  @override
  String get account => 'Account';

  @override
  String get signedInAs => 'Signed in as';

  @override
  String get appInfo =>
      'This is the student frontend. Recipes shown here are sample data.';

  @override
  String get clearAll => 'Clear all';

  @override
  String get addCustomIngredient => 'Add custom ingredient';

  @override
  String get enterIngredientName => 'Enter ingredient name';

  @override
  String get add => 'Add';

  @override
  String selectedIngredientsTitle(int count) {
    return 'Selected ($count)';
  }

  @override
  String inKitchen(int matched, int total) {
    return '$matched/$total in kitchen';
  }

  @override
  String missingCount(int count) {
    return 'Missing $count';
  }

  @override
  String get filterAll => 'All';

  @override
  String get filterByCategory => 'Categories';

  @override
  String get customCategory => 'Custom';

  @override
  String get kitchenShortcut => 'What\'s in your kitchen?';

  @override
  String get searchHintHome => 'Search ingredients or recipes...';

  @override
  String get viewAll => 'View all';

  @override
  String get allRecipesTitle => 'All Recipes';

  @override
  String get startCooking => 'Start Cooking';

  @override
  String get cookingMode => 'Cooking Mode';

  @override
  String stepOf(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get timerStart => 'Start timer';

  @override
  String get timerPause => 'Pause';

  @override
  String get timerResume => 'Resume';

  @override
  String get timerReset => 'Reset';

  @override
  String get addOneMinute => '+1 min';

  @override
  String get timerDone => 'Timer completed!';

  @override
  String get untimedStep => 'Untimed step';

  @override
  String get finishCooking => 'Finish Cooking';

  @override
  String get previousStep => 'Previous';

  @override
  String get nextStep => 'Next Step';

  @override
  String get cookingComplete => 'Well Done! Recipe Completed!';

  @override
  String get cookingCompleteSubtitle =>
      'You\'ve successfully prepared this dish. Enjoy your meal!';

  @override
  String get backToRecipe => 'Back to Recipe';

  @override
  String get returnHome => 'Return to Home';

  @override
  String get sortBy => 'Sort by';

  @override
  String get sortBestMatch => 'Best match';

  @override
  String get sortQuickest => 'Quickest';

  @override
  String get sortFewestMissing => 'Fewest missing';

  @override
  String get filterDifficulty => 'Difficulty';

  @override
  String get filterMaxTime => 'Max cook time';

  @override
  String get anyTime => 'Any time';

  @override
  String get under30Min => '≤ 30 min';

  @override
  String get under45Min => '≤ 45 min';

  @override
  String get logoutConfirmTitle => 'Log out?';

  @override
  String get logoutConfirmMessage =>
      'Are you sure you want to end your current session?';

  @override
  String get logoutSuccess => 'You have been logged out.';

  @override
  String get cancel => 'Cancel';

  @override
  String get backendMode => 'Frontend Mode: Offline Mock (Ready for API)';

  @override
  String get googleSignInNotice =>
      'Google sign-in is not configured in this frontend demo. Please log in with any demo email and password.';
}
