import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recipe_app/app/app.dart';
import 'package:recipe_app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('shows login screen after splash', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RecipeApp()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.loginButton), findsOneWidget);
  });
}
