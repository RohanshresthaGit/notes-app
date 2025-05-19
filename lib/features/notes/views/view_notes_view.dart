import 'package:flutter/material.dart';
import 'package:notes_app/config/routes.dart';
import 'package:notes_app/core/common/widgets/app_bar.dart';
import 'package:notes_app/features/notes/view_model/delete_notes_view_model.dart';
import 'package:notes_app/features/notes/view_model/view_notes_view_model.dart';
import 'package:notes_app/features/notes/widgets/notes_tile_component.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_navigation_bar_item.dart';

class ViewNotesView extends StatelessWidget {
  const ViewNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final deleteNotesViewModel =
        context.watch<DeleteNotesViewModel>().isSelectedMode;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          NotesAppBar(appBarTitle: 'Notes'),
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: Consumer<ViewNotesViewModel>(
              builder: (context, value, child) {
                if (value.notes.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No Notes Found',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  );
                }
                return SliverList.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  itemCount: value.notes.length,
                  itemBuilder: (context, index) {
                    final note = value.notes[index];
                    return NotesTileComponent(
                      index: index,
                      title: note.title,
                      description: note.description,
                      createdAt: note.formattedDate,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedSlide(
        duration: Duration(milliseconds: 300),
        offset: deleteNotesViewModel ? Offset(0, 0) : Offset(0, 1),
        child:
            deleteNotesViewModel
                ? BottomAppBar(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BottomNavigationItem(
                        title: 'Hide',
                        onTap: () {},
                        icon: Icons.lock_sharp,
                      ),
                      BottomNavigationItem(
                        title: 'Move to',
                        onTap: () {},
                        icon: Icons.folder,
                      ),
                      BottomNavigationItem(
                        title: 'Delete',
                        icon: Icons.delete,
                        onTap:
                            () =>
                                context
                                    .read<DeleteNotesViewModel>()
                                    .deleteNotes(),
                      ),
                    ],
                  ),
                )
                : null,
      ),
      floatingActionButton:
          deleteNotesViewModel
              ? null
              : FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, Routes.addNotes),
                child: Icon(Icons.add_outlined, size: 30),
              ),
    );
  }
}
