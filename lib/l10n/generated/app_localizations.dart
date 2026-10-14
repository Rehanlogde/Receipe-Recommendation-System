import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Recipe Guide'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @signupButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signupButton;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get sendResetLink;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'New here? Sign up'**
  String get noAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log in'**
  String get haveAccount;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to log in'**
  String get backToLogin;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String welcomeUser(String name);

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cook tasty meals with the ingredients you already have.'**
  String get homeSubtitle;

  /// No description provided for @findRecipes.
  ///
  /// In en, this message translates to:
  /// **'Find recipes'**
  String get findRecipes;

  /// No description provided for @selectIngredients.
  ///
  /// In en, this message translates to:
  /// **'Select ingredients'**
  String get selectIngredients;

  /// No description provided for @selectIngredientsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the items in your kitchen. Then we will suggest recipes.'**
  String get selectIngredientsHint;

  /// No description provided for @searchIngredients.
  ///
  /// In en, this message translates to:
  /// **'Search ingredients'**
  String get searchIngredients;

  /// No description provided for @getRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Show recipes'**
  String get getRecommendations;

  /// No description provided for @selectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedCount(int count);

  /// No description provided for @recommendedRecipes.
  ///
  /// In en, this message translates to:
  /// **'Suggested recipes'**
  String get recommendedRecipes;

  /// No description provided for @recipeDetails.
  ///
  /// In en, this message translates to:
  /// **'Recipe'**
  String get recipeDetails;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Cooking video'**
  String get video;

  /// No description provided for @watchVideo.
  ///
  /// In en, this message translates to:
  /// **'Watch video'**
  String get watchVideo;

  /// No description provided for @videoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No video yet for this recipe.'**
  String get videoUnavailable;

  /// No description provided for @cookTime.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String cookTime(int minutes);

  /// No description provided for @servingsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} servings'**
  String servingsLabel(int count);

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get difficulty;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get addToFavorites;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get removeFromFavorites;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @marathi.
  ///
  /// In en, this message translates to:
  /// **'Marathi'**
  String get marathi;

  /// No description provided for @noRecipes.
  ///
  /// In en, this message translates to:
  /// **'No recipes found'**
  String get noRecipes;

  /// No description provided for @noRecipesHint.
  ///
  /// In en, this message translates to:
  /// **'Try selecting more ingredients from your kitchen.'**
  String get noRecipesHint;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No saved recipes yet'**
  String get noFavorites;

  /// No description provided for @noFavoritesHint.
  ///
  /// In en, this message translates to:
  /// **'Open a recipe and tap Save to keep it here.'**
  String get noFavoritesHint;

  /// No description provided for @noIngredients.
  ///
  /// In en, this message translates to:
  /// **'No ingredients match your search.'**
  String get noIngredients;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Please wait…'**
  String get loading;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @resetPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email. We will send a reset link.'**
  String get resetPasswordHint;

  /// No description provided for @resetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'If this email is registered, a reset link has been sent.'**
  String get resetEmailSent;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name.'**
  String get nameRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get passwordRequired;

  /// No description provided for @selectAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one ingredient.'**
  String get selectAtLeastOne;

  /// No description provided for @demoHint.
  ///
  /// In en, this message translates to:
  /// **'Demo mode: any valid email and password will work.'**
  String get demoHint;

  /// No description provided for @popularRecipes.
  ///
  /// In en, this message translates to:
  /// **'Popular recipes'**
  String get popularRecipes;

  /// No description provided for @stepLabel.
  ///
  /// In en, this message translates to:
  /// **'Step {number}'**
  String stepLabel(int number);

  /// No description provided for @googleSignInSoon.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In will be connected later.'**
  String get googleSignInSoon;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @signedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as'**
  String get signedInAs;

  /// No description provided for @appInfo.
  ///
  /// In en, this message translates to:
  /// **'This is the student frontend. Recipes shown here are sample data.'**
  String get appInfo;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @addCustomIngredient.
  ///
  /// In en, this message translates to:
  /// **'Add custom ingredient'**
  String get addCustomIngredient;

  /// No description provided for @enterIngredientName.
  ///
  /// In en, this message translates to:
  /// **'Enter ingredient name'**
  String get enterIngredientName;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @selectedIngredientsTitle.
  ///
  /// In en, this message translates to:
  /// **'Selected ({count})'**
  String selectedIngredientsTitle(int count);

  /// No description provided for @inKitchen.
  ///
  /// In en, this message translates to:
  /// **'{matched}/{total} in kitchen'**
  String inKitchen(int matched, int total);

  /// No description provided for @missingCount.
  ///
  /// In en, this message translates to:
  /// **'Missing {count}'**
  String missingCount(int count);

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterByCategory.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get filterByCategory;

  /// No description provided for @customCategory.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customCategory;

  /// No description provided for @kitchenShortcut.
  ///
  /// In en, this message translates to:
  /// **'What\'s in your kitchen?'**
  String get kitchenShortcut;

  /// No description provided for @searchHintHome.
  ///
  /// In en, this message translates to:
  /// **'Search ingredients or recipes...'**
  String get searchHintHome;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @allRecipesTitle.
  ///
  /// In en, this message translates to:
  /// **'All Recipes'**
  String get allRecipesTitle;

  /// No description provided for @startCooking.
  ///
  /// In en, this message translates to:
  /// **'Start Cooking'**
  String get startCooking;

  /// No description provided for @cookingMode.
  ///
  /// In en, this message translates to:
  /// **'Cooking Mode'**
  String get cookingMode;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepOf(int current, int total);

  /// No description provided for @timerStart.
  ///
  /// In en, this message translates to:
  /// **'Start timer'**
  String get timerStart;

  /// No description provided for @timerPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get timerPause;

  /// No description provided for @timerResume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get timerResume;

  /// No description provided for @timerReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get timerReset;

  /// No description provided for @addOneMinute.
  ///
  /// In en, this message translates to:
  /// **'+1 min'**
  String get addOneMinute;

  /// No description provided for @timerDone.
  ///
  /// In en, this message translates to:
  /// **'Timer completed!'**
  String get timerDone;

  /// No description provided for @untimedStep.
  ///
  /// In en, this message translates to:
  /// **'Untimed step'**
  String get untimedStep;

  /// No description provided for @finishCooking.
  ///
  /// In en, this message translates to:
  /// **'Finish Cooking'**
  String get finishCooking;

  /// No description provided for @previousStep.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previousStep;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStep;

  /// No description provided for @cookingComplete.
  ///
  /// In en, this message translates to:
  /// **'Well Done! Recipe Completed!'**
  String get cookingComplete;

  /// No description provided for @cookingCompleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You\'ve successfully prepared this dish. Enjoy your meal!'**
  String get cookingCompleteSubtitle;

  /// No description provided for @backToRecipe.
  ///
  /// In en, this message translates to:
  /// **'Back to Recipe'**
  String get backToRecipe;

  /// No description provided for @returnHome.
  ///
  /// In en, this message translates to:
  /// **'Return to Home'**
  String get returnHome;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @sortBestMatch.
  ///
  /// In en, this message translates to:
  /// **'Best match'**
  String get sortBestMatch;

  /// No description provided for @sortQuickest.
  ///
  /// In en, this message translates to:
  /// **'Quickest'**
  String get sortQuickest;

  /// No description provided for @sortFewestMissing.
  ///
  /// In en, this message translates to:
  /// **'Fewest missing'**
  String get sortFewestMissing;

  /// No description provided for @filterDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get filterDifficulty;

  /// No description provided for @filterMaxTime.
  ///
  /// In en, this message translates to:
  /// **'Max cook time'**
  String get filterMaxTime;

  /// No description provided for @anyTime.
  ///
  /// In en, this message translates to:
  /// **'Any time'**
  String get anyTime;

  /// No description provided for @under30Min.
  ///
  /// In en, this message translates to:
  /// **'≤ 30 min'**
  String get under30Min;

  /// No description provided for @under45Min.
  ///
  /// In en, this message translates to:
  /// **'≤ 45 min'**
  String get under45Min;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to end your current session?'**
  String get logoutConfirmMessage;

  /// No description provided for @logoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have been logged out.'**
  String get logoutSuccess;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @backendMode.
  ///
  /// In en, this message translates to:
  /// **'Frontend Mode: Offline Mock (Ready for API)'**
  String get backendMode;

  /// No description provided for @googleSignInNotice.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in is not configured in this frontend demo. Please log in with any demo email and password.'**
  String get googleSignInNotice;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'mr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
