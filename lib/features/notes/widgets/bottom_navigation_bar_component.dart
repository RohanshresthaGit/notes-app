import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/move_notes_view_model.dart';
import '../view_model/ui_view_model.dart';
import '../view_model/view_notes_view_model.dart';
import 'bottom_navigation_bar_item.dart';

class BottomNavigationBarComponent extends StatelessWidget {
  const BottomNavigationBarComponent({
    super.key,
    required this.notesViewModel,
  });

  final NotesViewModel notesViewModel;

  @override
  Widget build(BuildContext context) {
    return Selector<UiViewModel, bool>(
        builder: (context, value, child) {
          return AnimatedSlide(
            duration: const Duration(milliseconds: 300),
            offset: value ? const Offset(0, 0) : const Offset(0, 1),
            child: value
                ? BottomAppBar(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BottomNavigationItem(
                          title: 'Move to',
                          onTap: () => context
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
          );
        },
        selector: (_, vm) => vm.isSelectedMode);
  }
}
