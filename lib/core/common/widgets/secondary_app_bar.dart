import 'package:flutter/material.dart';
import 'package:notes_app/config/routes.dart';
import 'package:notes_app/features/hidden_notes/view_model/hidden_notes_ui_view_model.dart';
import 'package:notes_app/main.dart';
import 'package:provider/provider.dart';

class NotesSecondaryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NotesSecondaryAppBar({
    super.key,
    this.appBarTitle,
    this.canPop = false,
    this.hasActions = false,
    this.onBack,
  });
  final String? appBarTitle;
  final bool canPop, hasActions;
  final void Function()? onBack;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions:
          hasActions
              ? [
                IconButton(
                  onPressed: () {
                    navigation.push(Routes.hiddenNotesSettings);
                  },
                  icon: const Icon(Icons.settings),
                ),
              ]
              : null,
      automaticallyImplyLeading: false,
      leading:
          canPop
              ? Consumer<HiddenNotesUiViewModel>(
                builder: (_, viewModel, _) {
                  return IconButton(
                    onPressed:
                        viewModel.isSelectedMode
                            ? viewModel.clearSelection
                            : onBack ?? () => navigation.pop(),
                    icon: Icon(
                      viewModel.isSelectedMode
                          ? Icons.close
                          : Icons.arrow_back_ios,
                    ),
                  );
                },
              )
              : null,
      title: appBarTitle != null ? Text(appBarTitle!) : null,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
