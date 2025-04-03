import 'package:flutter/material.dart';
import 'package:notes_app/core/common/themes/theme_viewmodel.dart';
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
    return SliverAppBar.large(
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.folder_outlined)),
        IconButton(
          onPressed: () {
            context.read<ThemeViewmodel>().toggleTheme();
          },
          icon: Icon(Icons.dark_mode_rounded),
        ),
      ],
      title: Text(appBarTitle),
      // leading:
      //     canPop
      //         ? IconButton(
      //           onPressed: () => Navigator.pop(context),
      //           icon: Icon(Icons.arrow_back_ios),
      //         )
      //         : null,
      // flexibleSpace: FlexibleSpaceBar(
      //   // titlePadding: EdgeInsets.only(left: 16),
      //   centerTitle: true,
      //   title: Text(appBatTitle),
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
