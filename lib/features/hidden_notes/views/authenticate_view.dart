import 'package:flutter/material.dart';
import 'package:notes_app/core/common/constants/constans.dart';
import 'package:notes_app/core/common/constants/constans.dart';
import 'package:notes_app/core/common/widgets/secondary_app_bar.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/services/auth_services.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:provider/provider.dart';

import '../../../config/routes.dart';
import '../../../config/routes.dart';
import '../../../core/common/constants/app_colors.dart';

class AuthenticateView extends StatefulWidget {
  const AuthenticateView({
    super.key,
    required this.isChangePattern,
    required this.isForgotPattern,
  });
  final bool isChangePattern, isForgotPattern;

  @override
  State<AuthenticateView> createState() => _AuthenticateViewState();
}

class _AuthenticateViewState extends State<AuthenticateView> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthServices>();
    final watchAuthService = context.watch<AuthServices>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: NotesSecondaryAppBar(
        hasActions: true,
        canPop: true,
        onBack: () {
          provider.clearFlags();
          navigation.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Notes',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(watchAuthService.message),
            Consumer<AuthServices>(
              builder: (_, value, __) => Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: PatternLock(
                      showInput: provider.getSwitch(showPattern),
                      fillPoints: true,
                      pointRadius: 3,
                      relativePadding: 0.5,
                      onInputComplete: (input) async => widget.isForgotPattern
                          ? await provider.forgotPattern(input)
                          : widget.isChangePattern
                              ? await provider.changePattern(
                                  input,
                                  widget.isChangePattern,
                                )
                              : provider.getPatternCallBack(
                                  input,
                                  context,
                                  widget.isChangePattern,
                                ),
                      notSelectedColor: theme.colorScheme.onPrimary,
                      selectedColor: theme.colorScheme.onPrimary,
                    ),
                  ),
                  if (provider.isConfirmPattern)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: theme.elevatedButtonTheme.style?.copyWith(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          onPressed: () {
                            provider.resetPattern(context);
                          },
                          child: Text(
                            'Reset',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        ElevatedButton(
                          style: theme.elevatedButtonTheme.style?.copyWith(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (value.showButton) {
                              value.patternMatched(context);
                            }
                          },
                          child: Text(
                            'Confirm',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: value.showButton
                                  ? theme.colorScheme.onPrimary
                                  : AppColors.unHighlightedColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                navigation.go(Routes.authenticateUser, {
                  'isForgot': true,
                });
                provider.message = 'Enter new pattern to reset';
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
              ),
              child: const Text(
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
