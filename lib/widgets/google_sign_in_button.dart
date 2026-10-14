import 'package:flutter/material.dart';

import 'package:recipe_app/core/localization/l10n_x.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.g_mobiledata_rounded, size: 28),
          const SizedBox(width: 8),
          Text(context.l10n.continueWithGoogle),
        ],
      ),
    );
  }
}
