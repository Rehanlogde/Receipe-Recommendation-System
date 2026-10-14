import 'package:flutter/material.dart';

import 'package:recipe_app/core/localization/l10n_x.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/widgets/empty_state.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, this.message, this.onRetry});

  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return EmptyState(
      icon: Icons.error_outline_rounded,
      title: l10n.errorTitle,
      message: message ?? l10n.errorTitle,
      action: onRetry == null
          ? null
          : AppButton(label: l10n.tryAgain, onPressed: onRetry),
    );
  }
}
