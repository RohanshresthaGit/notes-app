import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/common/Model/notes_model.dart';
import '../view_model/ui_view_model.dart';
import '../view_model/view_notes_view_model.dart';
import 'notes_tile_component.dart';

class ViewNotesContent extends StatelessWidget {
  const ViewNotesContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.headlineMedium;

    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: Selector<NotesViewModel, List<Notes>>(
        selector: (_, viewModel) => viewModel.notes,
        builder: (_, notes, __) {
          if (notes.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'No Notes Found',
                  style: theme,
                ),
              ),
            );
          }
          return SliverList.separated(
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemCount: notes.length,
            itemBuilder: (_, index) {
              final note = notes[index];
              return NotesTileComponent<UiViewModel>(
                note: note,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
