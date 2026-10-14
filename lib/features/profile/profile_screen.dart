import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_app/core/config/api_config.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/constants/app_spacing.dart';
import 'package:recipe_app/core/localization/l10n_x.dart';
import 'package:recipe_app/core/utils/max_width.dart';
import 'package:recipe_app/providers/auth_provider.dart';
import 'package:recipe_app/providers/locale_provider.dart';
import 'package:recipe_app/widgets/app_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(authProvider).user;
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profile)),
      body: MaxWidth(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primarySoft,
                  child: Icon(Icons.person_rounded, color: AppColors.primary),
                ),
                title: Text(user?.name ?? l10n.account),
                subtitle: Text('${l10n.signedInAs}\n${user?.email ?? ''}'),
                isThreeLine: true,
              ),
            ),
            const SizedBox(height: 24),
            Text(l10n.language, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: Text(l10n.english),
                  selected: locale.languageCode == 'en',
                  onSelected: (_) {
                    ref.read(localeProvider.notifier).state = const Locale(
                      'en',
                    );
                  },
                ),
                ChoiceChip(
                  label: Text(l10n.hindi),
                  selected: locale.languageCode == 'hi',
                  onSelected: (_) {
                    ref.read(localeProvider.notifier).state = const Locale(
                      'hi',
                    );
                  },
                ),
                ChoiceChip(
                  label: Text(l10n.marathi),
                  selected: locale.languageCode == 'mr',
                  onSelected: (_) {
                    ref.read(localeProvider.notifier).state = const Locale(
                      'mr',
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Settings & Integration',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.cloud_outlined,
                      color: AppColors.primary,
                    ),
                    title: const Text('Backend Mode'),
                    subtitle: Text(
                      'Local Mock Services (FastAPI ready)\nTarget: ${ApiConfig.baseUrl}',
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.textSecondary,
                    ),
                    title: const Text('App Information'),
                    subtitle: Text(l10n.appInfo),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              label: l10n.logout,
              onPressed: () => _confirmLogout(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.logoutConfirmTitle),
        content: Text(l10n.logoutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade700,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(authProvider.notifier).logout();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.logoutSuccess),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
