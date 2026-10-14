import 'package:flutter/material.dart';

import 'package:recipe_app/core/localization/l10n_x.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(message ?? context.l10n.loading),
        ],
      ),
    );
  }
}
