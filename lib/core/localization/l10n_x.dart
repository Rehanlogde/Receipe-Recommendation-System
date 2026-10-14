import 'package:flutter/widgets.dart';

import 'package:recipe_app/l10n/generated/app_localizations.dart';

extension LocalizationX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
