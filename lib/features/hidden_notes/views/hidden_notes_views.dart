import 'package:flutter/material.dart';
import 'package:notes_app/features/hidden_notes/view_model/hidden_notes_view_model.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/services/move_notes_view_model.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/features/hidden_notes/view_model/hidden_notes_view_model.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/services/move_notes_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/common/widgets/secondary_app_bar.dart';
import '../../notes/widgets/bottom_navigation_bar_item.dart';
import '../../notes/widgets/notes_tile_component.dart';
import '../view_model/hidden_notes_ui_view_model.dart';
import '../../notes/widgets/bottom_navigation_bar_item.dart';
import '../../notes/widgets/notes_tile_component.dart';
import '../view_model/hidden_notes_ui_view_model.dart';

class HiddenNotesViews extends StatefulWidget {
  const HiddenNotesViews({super.key});

  @override
  State<HiddenNotesViews> createState() => _HiddenNotesViewsState();
}

class _HiddenNotesViewsState extends State<HiddenNotesViews> {
  @override
  Widget build(BuildContext context) {
    final hiddenNotesVm = context.read<HiddenNotesViewModel>();
    final notesVm = context.read<MoveNotesViewModel>();
    final textTheme = Theme.of(context).textTheme;
    final hiddenNotesVm = context.read<HiddenNotesViewModel>();
    final notesVm = context.read<MoveNotesViewModel>();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: NotesSecondaryAppBar(
        canPop: true,
        appBarTitle: 'Hidden Notes',
        onBack: () {
          navigation.pop();
          navigation.pop();
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: Consumer<HiddenNotesViewModel>(
              builder: (_, value, __) {
                if (value.hiddenNotes.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No Notes Found',
                        style: textTheme.headlineMedium,
                      ),
                    ),
                  );
                }
                return SliverList.separated(
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  itemCount: value.hiddenNotes.length,
                  itemBuilder: (_, index) {
                    final note = value.hiddenNotes[index];
                    return NotesTileComponent<HiddenNotesUiViewModel>(
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
      bottomNavigationBar: Consumer<HiddenNotesUiViewModel>(
        builder: (_, provider, __) {
          return AnimatedSlide(
            duration: const Duration(milliseconds: 300),
            offset:
                provider.isSelectedMode
                    ? const Offset(0, 0)
                    : const Offset(0, 1),
            child:
                provider.isSelectedMode
                    ? BottomAppBar(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BottomNavigationItem(
                            title: 'Move to',
                            onTap: () => notesVm.moveNotes(),
                            icon: Icons.folder,
                          ),
                          BottomNavigationItem(
                            title: 'Delete',
                            icon: Icons.delete,
                            onTap: () => hiddenNotesVm.deleteNotesByIndex(),
                          ),
                        ],
                      ),
                    )
                    : null,
          );
        },
      ), // Add your floating action button here

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigation.push('/addHiddenNotes');
        },

        tooltip: 'Add Notes',
        child: const Icon(Icons.add), // Replace with your icon
      ),
    );
  }
}
