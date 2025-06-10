import 'package:flutter/material.dart';
import 'package:notes_app/core/common/constants/constans.dart';
import 'package:notes_app/core/common/widgets/secondary_app_bar.dart';
import 'package:notes_app/features/hidden_notes/models/settings_tile.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/services/auth_services.dart';
import 'package:provider/provider.dart';

import '../../../config/routes.dart';

class HiddenNotesSettingsView extends StatelessWidget {
  HiddenNotesSettingsView({super.key});
  final List<SettingsTile> settingsTiles = [
    SettingsTile(
      title: 'Enable Privacy Protection',
      subtitle: 'Require Pattern everytime private notes are accessed',
      hiveKey: enableAuth,
    ),
    SettingsTile(title: 'Change Pattern'),
    SettingsTile(
      title: 'Show Pattern',
      subtitle: 'Whether to Show Pattern or not',
      hiveKey: showPattern,
    ),
    SettingsTile(
      title: 'Unlock With Fingerprint',
      subtitle: 'Can be unlocked using fingerprint',
      hiveKey: enableBiometrics,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: NotesSecondaryAppBar(
        canPop: true,
        onBack: () => navigation.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Protection\nSettings',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Enable privacy protection to hide your notes from prying eyes.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: settingsTiles.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return ListTile(
                    contentPadding: EdgeInsetsDirectional.zero,
                    title: Text(
                      settingsTiles[index].title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle:
                        settingsTiles[index].subtitle != null
                            ? Text(
                              settingsTiles[index].subtitle!,
                              style: theme.textTheme.bodySmall,
                            )
                            : null,
                    trailing:
                        settingsTiles[index].subtitle == null
                            ? Consumer<AuthServices>(
                              builder: (context, provider, child) {
                                return IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios),
                                  onPressed: () {
                                    navigation.push(Routes.authenticateUser, {
                                      "isChange": true,
                                    });
                                  },
                                );
                              },
                            )
                            : Consumer<AuthServices>(
                              builder:
                                  (_, provider, _) => Switch.adaptive(
                                    value: provider.getSwitch(
                                      settingsTiles[index].hiveKey ?? '',
                                    ),
                                    onChanged: (value) {
                                      provider.setSwitch(
                                        settingsTiles[index].hiveKey ?? '',
                                        value,
                                      );
                                      if (settingsTiles[index].hiveKey ==
                                              enableAuth &&
                                          value == false) {
                                        navigation.go(Routes.notes);
                                      }
                                    },
                                  ),
                            ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
