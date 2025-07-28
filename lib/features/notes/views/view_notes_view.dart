import 'package:flutter/material.dart';
import 'package:notes_app/core/common/widgets/app_bar.dart';
import 'package:notes_app/features/notes/view_model/ui_view_model.dart';
import 'package:notes_app/features/notes/view_model/view_notes_view_model.dart';
import 'package:notes_app/features/notes/widgets/bottom_navigation_bar_component.dart';
import 'package:provider/provider.dart';

import '../widgets/floating_action_button.dart';
import '../widgets/view_notes_view_content.dart';

class ViewNotesView extends StatelessWidget {
  const ViewNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final dVm = context.read<UiViewModel>();
    final notesViewModel = context.read<NotesViewModel>();

    return Scaffold(
      body: CustomScrollView(
        physics: context.select<NotesViewModel, ScrollPhysics>((notes) =>
            notes.notes.isEmpty
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics()),
        slivers: const [
          NotesAppBar(appBarTitle: 'Notes'),
          ViewNotesContent(),
        ],
      ),
      bottomNavigationBar:
          BottomNavigationBarComponent(notesViewModel: notesViewModel),
      floatingActionButton: FloatingActionButtonComponent(dVm: dVm),
    );
  }
}
