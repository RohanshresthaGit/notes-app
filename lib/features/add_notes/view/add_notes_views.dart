import 'package:flutter/material.dart';
import 'package:notes_app/core/common/widgets/secondary_app_bar.dart';
import 'package:notes_app/core/common/widgets/text_field_component.dart';
import 'package:notes_app/features/add_notes/view_model/add_notes_view_model.dart';
import 'package:notes_app/main.dart';
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
  late AddNotesViewModel provider;
  late NotesViewModel viewNotes;

  @override
  void initState() {
    super.initState();

    provider = context.read<AddNotesViewModel>();
    viewNotes = context.read<NotesViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isUpdate) {
        final note = viewNotes.notes[widget.index];
        provider.loadNoteForUpdate(note);
      } else {
        viewNotes.titleController.clear();
        viewNotes.descriptionController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final date = provider.formattedDate();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && provider.currentCharectersCount > 0) {
          provider.dontSave();
        }
      },
      child: Scaffold(
        appBar: NotesSecondaryAppBar(
          appBarTitle: ' ${widget.isUpdate ? "Update" : "Add"} Notes',
          canPop: true,
          onBack: () => navigation.pop(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldComponent(
                controller: viewNotes.titleController,
                hintText: 'Title',
                onChanged: (value) => provider.onTextChanged(
                  widget.isUpdate ? widget.index : null,
                ),
              ),
              Selector<AddNotesViewModel, int>(
                selector: (_, provider) => provider.currentCharectersCount,
                builder: (context, value, child) {
                  return Text(
                      '   $date  |  ${provider.currentCharectersCount} charecters');
                },
              ),
              TextFieldComponent(
                controller: viewNotes.descriptionController,
                hintText: 'Description',
                maxLines: 5,
                onChanged: (value) => provider.onTextChanged(
                  widget.isUpdate ? widget.index : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
