import 'package:flutter/material.dart';
import 'package:notes_app/config/routes.dart';

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
                    Navigator.pushNamed(context, Routes.hiddenNotesSettings);
                  },
                  icon: Icon(Icons.settings),
                ),
              ]
              : null,
      automaticallyImplyLeading: false,
      leading:
          canPop
              ? IconButton(
                onPressed: onBack ?? () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
              )
              : null,
      title: appBarTitle != null ? Text(appBarTitle!) : null,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
