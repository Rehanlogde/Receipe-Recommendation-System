// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'रेसिपी गाइड';

  @override
  String get login => 'लॉग इन';

  @override
  String get signup => 'साइन अप';

  @override
  String get forgotPassword => 'पासवर्ड विसरलात?';

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get confirmPassword => 'पासवर्ड पुन्हा लिहा';

  @override
  String get name => 'नाव';

  @override
  String get loginButton => 'लॉग इन करा';

  @override
  String get signupButton => 'खाते तयार करा';

  @override
  String get sendResetLink => 'रीसेट लिंक पाठवा';

  @override
  String get continueWithGoogle => 'Google ने सुरू ठेवा';

  @override
  String get orContinueWith => 'किंवा यासह सुरू ठेवा';

  @override
  String get noAccount => 'नवीन आहात? साइन अप करा';

  @override
  String get haveAccount => 'खाते आहे? लॉग इन करा';

  @override
  String get backToLogin => 'लॉग इनवर परत जा';

  @override
  String get home => 'होम';

  @override
  String get favorites => 'आवडते';

  @override
  String get profile => 'प्रोफाइल';

  @override
  String welcomeUser(String name) {
    return 'नमस्कार, $name';
  }

  @override
  String get homeSubtitle => 'घरात असलेल्या साहित्यापासून चविष्ट जेवण बनवा.';

  @override
  String get findRecipes => 'रेसिपी शोधा';

  @override
  String get selectIngredients => 'साहित्य निवडा';

  @override
  String get selectIngredientsHint =>
      'तुमच्या स्वयंपाकघरातील गोष्टींवर टॅप करा. मग आम्ही रेसिपी सुचवू.';

  @override
  String get searchIngredients => 'साहित्य शोधा';

  @override
  String get getRecommendations => 'रेसिपी दाखवा';

  @override
  String selectedCount(int count) {
    return '$count निवडले';
  }

  @override
  String get recommendedRecipes => 'सुचवलेल्या रेसिपी';

  @override
  String get recipeDetails => 'रेसिपी';

  @override
  String get ingredients => 'साहित्य';

  @override
  String get steps => 'पायऱ्या';

  @override
  String get video => 'स्वयंपाकाचा व्हिडिओ';

  @override
  String get watchVideo => 'व्हिडिओ पहा';

  @override
  String get videoUnavailable => 'या रेसिपीसाठी व्हिडिओ अद्याप नाही.';

  @override
  String cookTime(int minutes) {
    return '$minutes मिनिटे';
  }

  @override
  String servingsLabel(int count) {
    return '$count सर्व्हिंग';
  }

  @override
  String get difficulty => 'पातळी';

  @override
  String get addToFavorites => 'सेव्ह करा';

  @override
  String get removeFromFavorites => 'सेव्ह झाले';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get language => 'भाषा';

  @override
  String get english => 'इंग्रजी';

  @override
  String get hindi => 'हिंदी';

  @override
  String get marathi => 'मराठी';

  @override
  String get noRecipes => 'रेसिपी सापडल्या नाहीत';

  @override
  String get noRecipesHint => 'अधिक साहित्य निवडून पुन्हा पहा.';

  @override
  String get noFavorites => 'अजून सेव्ह केलेल्या रेसिपी नाहीत';

  @override
  String get noFavoritesHint => 'रेसिपी उघडा आणि सेव्ह वर टॅप करा.';

  @override
  String get noIngredients => 'या शोधाशी जुळणारे साहित्य नाही.';

  @override
  String get loading => 'कृपया थांबा…';

  @override
  String get errorTitle => 'काहीतरी चुकले';

  @override
  String get tryAgain => 'पुन्हा प्रयत्न करा';

  @override
  String get resetPasswordHint => 'तुमचा ईमेल लिहा. आम्ही रीसेट लिंक पाठवू.';

  @override
  String get resetEmailSent =>
      'हा ईमेल नोंदणीकृत असेल तर रीसेट लिंक पाठवली आहे.';

  @override
  String get invalidEmail => 'योग्य ईमेल पत्ता लिहा.';

  @override
  String get passwordTooShort => 'पासवर्ड किमान 6 अक्षरांचा असावा.';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड जुळत नाहीत.';

  @override
  String get nameRequired => 'कृपया तुमचे नाव लिहा.';

  @override
  String get emailRequired => 'कृपया ईमेल लिहा.';

  @override
  String get passwordRequired => 'कृपया पासवर्ड लिहा.';

  @override
  String get selectAtLeastOne => 'कृपया किमान एक साहित्य निवडा.';

  @override
  String get demoHint => 'डेमो मोड: कोणताही योग्य ईमेल आणि पासवर्ड चालेल.';

  @override
  String get popularRecipes => 'लोकप्रिय रेसिपी';

  @override
  String stepLabel(int number) {
    return 'पायरी $number';
  }

  @override
  String get googleSignInSoon => 'Google साइन-इन नंतर जोडले जाईल.';

  @override
  String get account => 'खाते';

  @override
  String get signedInAs => 'या नावाने लॉग इन आहात';

  @override
  String get appInfo =>
      'हे विद्यार्थी फ्रंटएंड आहे. येथे दिसणाऱ्या रेसिपी नमुना डेटा आहेत।';

  @override
  String get clearAll => 'सर्व हटवा';

  @override
  String get addCustomIngredient => 'वेगळे साहित्य जोडा';

  @override
  String get enterIngredientName => 'साहित्याचे नाव टाका';

  @override
  String get add => 'जोडा';

  @override
  String selectedIngredientsTitle(int count) {
    return 'निवडलेले साहित्य ($count)';
  }

  @override
  String inKitchen(int matched, int total) {
    return 'स्वयंपाकघरात $matched/$total';
  }

  @override
  String missingCount(int count) {
    return '$count साहित्य हवे';
  }

  @override
  String get filterAll => 'सर्व';

  @override
  String get filterByCategory => 'श्रेणी';

  @override
  String get customCategory => 'कस्टम';

  @override
  String get kitchenShortcut => 'तुमच्या स्वयंपाकघरात काय आहे?';

  @override
  String get searchHintHome => 'साहित्य किंवा रेसिपी शोधा...';

  @override
  String get viewAll => 'सर्व पहा';

  @override
  String get allRecipesTitle => 'सर्व रेसिपी';

  @override
  String get startCooking => 'स्वयंपाक सुरू करा';

  @override
  String get cookingMode => 'कुकिंग मोड';

  @override
  String stepOf(int current, int total) {
    return 'पायरी $current / $total';
  }

  @override
  String get timerStart => 'टायमर सुरू करा';

  @override
  String get timerPause => 'थांबवा';

  @override
  String get timerResume => 'पुन्हा सुरू करा';

  @override
  String get timerReset => 'रीसेट करा';

  @override
  String get addOneMinute => '+1 मिनिट';

  @override
  String get timerDone => 'टायमर पूर्ण झाला!';

  @override
  String get untimedStep => 'वेळ नसलेली पायरी';

  @override
  String get finishCooking => 'स्वयंपाक पूर्ण करा';

  @override
  String get previousStep => 'मागील';

  @override
  String get nextStep => 'पुढील पायरी';

  @override
  String get cookingComplete => 'छान! रेसिपी तयार झाली!';

  @override
  String get cookingCompleteSubtitle =>
      'तुम्ही हा पदार्थ यशस्वीपणे बनवला आहे. जेवणाचा आनंद घ्या!';

  @override
  String get backToRecipe => 'रेसिपीवर परत जा';

  @override
  String get returnHome => 'होमवर परत जा';

  @override
  String get sortBy => 'क्रमवारी लावा';

  @override
  String get sortBestMatch => 'सर्वोत्कृष्ट जुळणी';

  @override
  String get sortQuickest => 'सर्वात जलद';

  @override
  String get sortFewestMissing => 'कमीत कमी अनुपलब्ध';

  @override
  String get filterDifficulty => 'काठिण्यपातळी';

  @override
  String get filterMaxTime => 'कमाल वेळ';

  @override
  String get anyTime => 'कोणतीही वेळ';

  @override
  String get under30Min => '≤ 30 मिनिटे';

  @override
  String get under45Min => '≤ 45 मिनिटे';

  @override
  String get logoutConfirmTitle => 'लॉग आउट करायचे?';

  @override
  String get logoutConfirmMessage =>
      'तुम्हाला खात्री आहे की सत्र समाप्त करायचे आहे?';

  @override
  String get logoutSuccess => 'तुम्ही लॉग आउट झाला आहात.';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get backendMode => 'फ्रंटएंड मोड: ऑफलाइन मॉक (API साठी तयार)';

  @override
  String get googleSignInNotice =>
      'या डेमोमध्ये Google साइन-इन कॉन्फिगर केलेले नाही. कृपया कोणत्याही डेमो ईमेल आणि पासवर्डने लॉग इन करा.';
}
