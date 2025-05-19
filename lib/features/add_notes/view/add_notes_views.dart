import 'package:flutter/material.dart';
import 'package:notes_app/core/common/widgets/secondary_app_bar.dart';
import 'package:notes_app/core/common/widgets/text_field_component.dart';
import 'package:notes_app/features/add_notes/view_model/add_notes_vire_model.dart';
import 'package:provider/provider.dart';

import '../../notes/view_model/view_notes_view_model.dart';

class AddNotesViews extends StatefulWidget {
  final bool isUpdate;
  final int index;
  const AddNotesViews({super.key, this.isUpdate = false, this.index = 0});

  @override
  State<AddNotesViews> createState() => _AddNotesViewsState();
}

class _AddNotesViewsState extends State<AddNotesViews> {
  AddNotesViewModel? provider;
  ViewNotesViewModel? veiwNotes;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<AddNotesViewModel>();
      if (widget.isUpdate) {
        final viewNotes = context.read<ViewNotesViewModel>();
        final note = viewNotes.notes[widget.index];
        provider.loadNoteForUpdate(note);
      } else {
        provider.titleController.clear();
        provider.descriptionController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddNotesViewModel>();
    return Scaffold(
      appBar: NotesSecondaryAppBar(
        appBarTitle: ' ${widget.isUpdate ? "Update" : "Add"} Notes',
        canPop: true,
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldComponent(
              controller: provider.titleController,
              hintText: 'Title',
              onChanged:
                  (value) => provider.onTextChanged(
                    widget.isUpdate ? widget.index : null,
                  ),
            ),
            Text(
              '   ${provider.formattedDate()}  |  ${provider.currentCharectersCount} charecters',
            ),
            TextFieldComponent(
              controller: provider.descriptionController,
              hintText: 'Description',
              maxLines: 5,
              onChanged:
                  (value) => provider.onTextChanged(
                    widget.isUpdate ? widget.index : null,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
