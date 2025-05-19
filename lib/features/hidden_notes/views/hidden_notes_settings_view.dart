import 'package:flutter/material.dart';
import 'package:notes_app/core/common/widgets/secondary_app_bar.dart';

class HiddenNotesSettingsView extends StatelessWidget {
  const HiddenNotesSettingsView({super.key});
  static const List<String> titles = [
    'Enable Privacy Protection',
    'Change Password',
    'Show Pattern',
    'Unlock With Fingerprint',
  ];
  static const List<String?> subtitles = [
    'Enable Privacy Protection',
    null,
    'Show Pattern',
    'Unloack With Fingerprint',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotesSecondaryAppBar(
        canPop: true,
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Protection\nSettings',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Enable privacy protection to hide your notes from prying eyes.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: titles.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsetsDirectional.zero,
                    title: Text(
                      titles[index],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle:
                        subtitles[index] != null
                            ? Text(
                              subtitles[index]!,
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                            : null,
                    trailing:
                        subtitles[index] == null
                            ? const Icon(Icons.arrow_forward_ios)
                            : Switch.adaptive(
                              value: false,
                              onChanged: (vlaue) {},
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
