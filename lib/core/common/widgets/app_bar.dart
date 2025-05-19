import 'package:flutter/material.dart';
import 'package:notes_app/config/routes.dart';
import 'package:notes_app/core/common/themes/theme_viewmodel.dart';
import 'package:notes_app/features/notes/view_model/delete_notes_view_model.dart';
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
    final provider = context.read<DeleteNotesViewModel>();
    return SliverAppBar.large(
      leading:
          context.watch<DeleteNotesViewModel>().isSelectedMode
              ? IconButton(
                onPressed:
                    () => context.read<DeleteNotesViewModel>().clearSelection(),
                icon: Icon(Icons.close),
              )
              : null,
      actions: [
        IconButton(
          onPressed: () {
            context.read<AuthServices>().message =
                'Enter privacy Protection Password';
            Navigator.pushNamed(context, Routes.authenticateUser);
          },
          icon: Icon(Icons.folder_outlined),
        ),
        IconButton(
          onPressed: () {
            context.read<ThemeViewmodel>().toggleTheme();
          },
          icon: Icon(Icons.dark_mode_rounded),
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
