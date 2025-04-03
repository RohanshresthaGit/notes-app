import 'package:flutter/material.dart';

class NotesSecondaryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NotesSecondaryAppBar({
    super.key,
    required this.appBarTitle,
    this.canPop = false,
  });
  final String appBarTitle;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading:
          canPop
              ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
              )
              : null,
      title: Text(appBarTitle),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
