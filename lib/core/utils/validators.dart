import 'package:recipe_app/core/constants/app_constants.dart';
import 'package:recipe_app/l10n/generated/app_localizations.dart';

abstract final class Validators {
  static String? email(String? value, AppLocalizations l10n) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return l10n.emailRequired;
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(text)) return l10n.invalidEmail;
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    final text = value ?? '';
    if (text.isEmpty) return l10n.passwordRequired;
    if (text.length < AppConstants.minPasswordLength) {
      return l10n.passwordTooShort;
    }
    return null;
  }

  static String? name(String? value, AppLocalizations l10n) {
    if ((value ?? '').trim().isEmpty) return l10n.nameRequired;
    return null;
  }

  static String? confirmPassword(
    String? value,
    String password,
    AppLocalizations l10n,
  ) {
    if (value != password) return l10n.passwordsDoNotMatch;
    return null;
  }
}
