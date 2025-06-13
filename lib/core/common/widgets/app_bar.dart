import 'package:flutter/material.dart';
import 'package:notes_app/config/routes.dart';
import 'package:notes_app/core/common/constants/constans.dart';
import 'package:notes_app/core/common/constants/constans.dart';
import 'package:notes_app/core/common/themes/theme_viewmodel.dart';
import 'package:notes_app/features/hidden_notes/widgets/bottom_sheet.dart';
import 'package:notes_app/features/notes/view_model/ui_view_model.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class NotesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotesAppBar({
    super.key,
    required this.appBarTitle,
    this.canPop = false,
  });
  final String appBarTitle;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthServices>();
    final provider = context.read<UiViewModel>();
    return SliverAppBar.large(
      automaticallyImplyLeading: false,
      leading:
          context.watch<UiViewModel>().isSelectedMode
              ? IconButton(
                onPressed: () => context.read<UiViewModel>().clearSelection(),
                icon: const Icon(Icons.close),
              )
              : null,
      actions: [
        IconButton(
          onPressed: () async {
            if (authProvider.getSwitch(enableAuth)) {
              authProvider.message = 'Enter privacy Protection Password';
              navigation.push(Routes.authenticateUser);
              await authProvider.authenticateWithBiometrics();
            } else {
              showBottomAlertDialog(context);
            }
          },
          icon: const Icon(Icons.folder_outlined),
        ),
        IconButton(
          onPressed: () {
            context.read<ThemeViewmodel>().toggleTheme();
          },
          icon: const Icon(Icons.dark_mode_rounded),
        ),
      ],
      title: Text(
        provider.isSelectedMode
            ? '${provider.selectedItems.length.toString()} item selected'
            : appBarTitle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
