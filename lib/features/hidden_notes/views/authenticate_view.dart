import 'package:flutter/material.dart';
import 'package:notes_app/core/common/widgets/secondary_app_bar.dart';
import 'package:notes_app/services/auth_services.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:provider/provider.dart';

import '../../../core/common/constants/app_colors.dart';

class AuthenticateView extends StatelessWidget {
  const AuthenticateView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthServices>();
    return Scaffold(
      appBar: NotesSecondaryAppBar(
        hasActions: true,
        canPop: true,
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Notes',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(context.watch<AuthServices>().message),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: PatternLock(
                pointRadius: 1,
                relativePadding: 0.5,
                onInputComplete:
                    (input) => provider.getPatternCallBack(input, context),
                notSelectedColor: Theme.of(context).colorScheme.onPrimary,
                selectedColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
              ),
              child: Text(
                'Forget Pattern?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.unHighlightedColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
