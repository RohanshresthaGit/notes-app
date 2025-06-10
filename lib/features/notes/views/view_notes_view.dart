import 'package:flutter/material.dart';
import 'package:notes_app/core/common/widgets/app_bar.dart';
import 'package:notes_app/features/notes/view_model/ui_view_model.dart';
import 'package:notes_app/features/notes/view_model/view_notes_view_model.dart';
import 'package:notes_app/features/notes/widgets/notes_tile_component.dart';
import 'package:notes_app/services/move_notes_view_model.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_navigation_bar_item.dart';

class ViewNotesView extends StatelessWidget {
  const ViewNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final deleteNotesViewModel = context.watch<UiViewModel>().isSelectedMode;
    final dVm = context.read<UiViewModel>();
    final notesViewModel = context.read<NotesViewModel>();
    final theme = Theme.of(context).textTheme.headlineMedium;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const NotesAppBar(appBarTitle: 'Notes'),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: Consumer<NotesViewModel>(
              builder: (_, value, _) {
                if (value.notes.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('No Notes Found', style: theme)),
                  );
                }
                return SliverList.separated(
                  separatorBuilder: (_, _) => const SizedBox(height: 15),
                  itemCount: value.notes.length,
                  itemBuilder: (_, index) {
                    final note = value.notes[index];
                    return NotesTileComponent<UiViewModel>(
                      note: note,
                      index: index,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: deleteNotesViewModel ? const Offset(0, 0) : const Offset(0, 1),
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
                        onTap:
                            () =>
                                context
                                    .read<MoveNotesViewModel>()
                                    .moveNotesToHidden(),
                        icon: Icons.folder,
                      ),
                      BottomNavigationItem(
                        title: 'Delete',
                        icon: Icons.delete,
                        onTap: () => notesViewModel.deleteNotesByIndex(),
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
                onPressed: () => dVm.navigateToAdd(),
                child: const Icon(Icons.add_outlined, size: 30),
              ),
    );
  }
}
