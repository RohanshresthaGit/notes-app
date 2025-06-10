import 'package:flutter/material.dart';
import 'package:notes_app/core/common/widgets/android_button.dart';
import 'package:notes_app/main.dart';

import '../../../config/routes.dart';

void showBottomAlertDialog(BuildContext context) {
  final theme = Theme.of(context);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false, // Disable tap outside
    enableDrag: false, // Disable swipe down to dismiss
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (context) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                'Secure Notes with Pattern',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AndroidButton(
                    onPressed: () {
                      navigation.pop();
                      navigation.push(Routes.hiddenNotes);
                    },
                    title: 'Skip',
                  ),
                  AndroidButton(
                    onPressed: () {
                      navigation.pop();
                      navigation.push(Routes.authenticateUser);
                    },
                    title: 'Set Pattern',
                    isHighlight: true,
                  ),
                ],
              ),
            ],
          ),
        ),
  );
}
