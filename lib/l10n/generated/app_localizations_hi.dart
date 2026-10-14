// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'रेसिपी गाइड';

  @override
  String get login => 'लॉग इन';

  @override
  String get signup => 'साइन अप';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get confirmPassword => 'पासवर्ड दोबारा लिखें';

  @override
  String get name => 'नाम';

  @override
  String get loginButton => 'लॉग इन करें';

  @override
  String get signupButton => 'खाता बनाएँ';

  @override
  String get sendResetLink => 'रीसेट लिंक भेजें';

  @override
  String get continueWithGoogle => 'Google से जारी रखें';

  @override
  String get orContinueWith => 'या इससे जारी रखें';

  @override
  String get noAccount => 'नए हैं? साइन अप करें';

  @override
  String get haveAccount => 'खाता है? लॉग इन करें';

  @override
  String get backToLogin => 'लॉग इन पर वापस जाएँ';

  @override
  String get home => 'होम';

  @override
  String get favorites => 'पसंदीदा';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String welcomeUser(String name) {
    return 'नमस्ते, $name';
  }

  @override
  String get homeSubtitle => 'घर में मौजूद सामग्री से स्वादिष्ट खाना बनाएँ।';

  @override
  String get findRecipes => 'रेसिपी खोजें';

  @override
  String get selectIngredients => 'सामग्री चुनें';

  @override
  String get selectIngredientsHint =>
      'रसोई में जो चीज़ें हैं, उन पर टैप करें। फिर हम रेसिपी सुझाएँगे।';

  @override
  String get searchIngredients => 'सामग्री खोजें';

  @override
  String get getRecommendations => 'रेसिपी दिखाएँ';

  @override
  String selectedCount(int count) {
    return '$count चुनी गई';
  }

  @override
  String get recommendedRecipes => 'सुझाई गई रेसिपी';

  @override
  String get recipeDetails => 'रेसिपी';

  @override
  String get ingredients => 'सामग्री';

  @override
  String get steps => 'चरण';

  @override
  String get video => 'पकाने का वीडियो';

  @override
  String get watchVideo => 'वीडियो देखें';

  @override
  String get videoUnavailable => 'इस रेसिपी का वीडियो अभी नहीं है।';

  @override
  String cookTime(int minutes) {
    return '$minutes मिनट';
  }

  @override
  String servingsLabel(int count) {
    return '$count सर्विंग';
  }

  @override
  String get difficulty => 'स्तर';

  @override
  String get addToFavorites => 'सेव करें';

  @override
  String get removeFromFavorites => 'सेव हो गया';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get language => 'भाषा';

  @override
  String get english => 'अंग्रेज़ी';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get marathi => 'मराठी';

  @override
  String get noRecipes => 'कोई रेसिपी नहीं मिली';

  @override
  String get noRecipesHint => 'रसोई से और सामग्री चुनकर देखें।';

  @override
  String get noFavorites => 'अभी कोई सेव की गई रेसिपी नहीं है';

  @override
  String get noFavoritesHint => 'रेसिपी खोलें और सेव पर टैप करें।';

  @override
  String get noIngredients => 'इस खोज से कोई सामग्री नहीं मिली।';

  @override
  String get loading => 'कृपया प्रतीक्षा करें…';

  @override
  String get errorTitle => 'कुछ गड़बड़ हो गई';

  @override
  String get tryAgain => 'फिर कोशिश करें';

  @override
  String get resetPasswordHint => 'अपना ईमेल लिखें। हम रीसेट लिंक भेजेंगे।';

  @override
  String get resetEmailSent =>
      'अगर यह ईमेल पंजीकृत है, तो रीसेट लिंक भेज दिया गया है।';

  @override
  String get invalidEmail => 'सही ईमेल पता लिखें।';

  @override
  String get passwordTooShort => 'पासवर्ड कम से कम 6 अक्षर का होना चाहिए।';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड मेल नहीं खाते।';

  @override
  String get nameRequired => 'कृपया अपना नाम लिखें।';

  @override
  String get emailRequired => 'कृपया अपना ईमेल लिखें।';

  @override
  String get passwordRequired => 'कृपया पासवर्ड लिखें।';

  @override
  String get selectAtLeastOne => 'कृपया कम से कम एक सामग्री चुनें।';

  @override
  String get demoHint => 'डेमो मोड: कोई भी सही ईमेल और पासवर्ड चल जाएगा।';

  @override
  String get popularRecipes => 'लोकप्रिय रेसिपी';

  @override
  String stepLabel(int number) {
    return 'चरण $number';
  }

  @override
  String get googleSignInSoon => 'Google साइन-इन बाद में जोड़ा जाएगा।';

  @override
  String get account => 'खाता';

  @override
  String get signedInAs => 'इस नाम से लॉग इन हैं';

  @override
  String get appInfo =>
      'यह छात्र फ्रंटएंड है। यहाँ दिखाई गई रेसिपी नमूना डेटा हैं।';

  @override
  String get clearAll => 'सभी हटाएं';

  @override
  String get addCustomIngredient => 'अलग सामग्री जोड़ें';

  @override
  String get enterIngredientName => 'सामग्री का नाम दर्ज करें';

  @override
  String get add => 'जोड़ें';

  @override
  String selectedIngredientsTitle(int count) {
    return 'चुनी गई सामग्री ($count)';
  }

  @override
  String inKitchen(int matched, int total) {
    return 'रसोई में $matched/$total';
  }

  @override
  String missingCount(int count) {
    return '$count सामग्री बाकी';
  }

  @override
  String get filterAll => 'सभी';

  @override
  String get filterByCategory => 'श्रेणियाँ';

  @override
  String get customCategory => 'कस्टम';

  @override
  String get kitchenShortcut => 'आपकी रसोई में क्या है?';

  @override
  String get searchHintHome => 'सामग्री या रेसिपी खोजें...';

  @override
  String get viewAll => 'सभी देखें';

  @override
  String get allRecipesTitle => 'सभी रेसिपी';

  @override
  String get startCooking => 'पकाना शुरू करें';

  @override
  String get cookingMode => 'कुकिंग मोड';

  @override
  String stepOf(int current, int total) {
    return 'चरण $current / $total';
  }

  @override
  String get timerStart => 'टाइमर शुरू करें';

  @override
  String get timerPause => 'रोकें';

  @override
  String get timerResume => 'फिर से शुरू करें';

  @override
  String get timerReset => 'रीसेट करें';

  @override
  String get addOneMinute => '+1 मिनट';

  @override
  String get timerDone => 'टाइमर पूरा हुआ!';

  @override
  String get untimedStep => 'समय रहित चरण';

  @override
  String get finishCooking => 'पकाना समाप्त करें';

  @override
  String get previousStep => 'पिछला';

  @override
  String get nextStep => 'अगला चरण';

  @override
  String get cookingComplete => 'शाबाश! रेसिपी तैयार है!';

  @override
  String get cookingCompleteSubtitle =>
      'आपने यह व्यंजन सफलतापूर्वक बना लिया है। भोजन का आनंद लें!';

  @override
  String get backToRecipe => 'रेसिपी पर वापस जाएँ';

  @override
  String get returnHome => 'होम पर वापस जाएँ';

  @override
  String get sortBy => 'क्रमबद्ध करें';

  @override
  String get sortBestMatch => 'सर्वश्रेष्ठ मिलान';

  @override
  String get sortQuickest => 'सबसे जल्दी';

  @override
  String get sortFewestMissing => 'सबसे कम अनुपलब्ध';

  @override
  String get filterDifficulty => 'कठिनाई';

  @override
  String get filterMaxTime => 'अधिकतम समय';

  @override
  String get anyTime => 'कोई भी समय';

  @override
  String get under30Min => '≤ 30 मिनट';

  @override
  String get under45Min => '≤ 45 मिनट';

  @override
  String get logoutConfirmTitle => 'लॉग आउट करें?';

  @override
  String get logoutConfirmMessage =>
      'क्या आप वाकई अपना सत्र समाप्त करना चाहते हैं?';

  @override
  String get logoutSuccess => 'आप लॉग आउट हो चुके हैं।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get backendMode => 'फ़्रंटएंड मोड: ऑफ़लाइन मॉक (API के लिए तैयार)';

  @override
  String get googleSignInNotice =>
      'इस डेमो में Google साइन-इन कॉन्फ़िगर नहीं है। कृपया किसी भी डेमो ईमेल और पासवर्ड से लॉग इन करें।';
}
