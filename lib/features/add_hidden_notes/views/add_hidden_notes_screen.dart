import 'package:flutter/material.dart';
import 'package:notes_app/core/common/widgets/secondary_app_bar.dart';
import 'package:notes_app/core/common/widgets/text_field_component.dart';
import 'package:notes_app/main.dart';
import 'package:provider/provider.dart';

import '../../hidden_notes/view_model/hidden_notes_view_model.dart';
import '../view_model/add_hidden_notes_view_model.dart';

class AddHiddenNotesViews extends StatefulWidget {
  final bool isUpdate;
  final int index;
  const AddHiddenNotesViews({super.key, this.isUpdate = false, this.index = 0});

  @override
  State<AddHiddenNotesViews> createState() => _AddNotesHiddenViewsState();
}

class _AddNotesHiddenViewsState extends State<AddHiddenNotesViews> {
  late AddHiddenNotesViewModel provider;
  late HiddenNotesViewModel hiddenNotesViewModel;

  @override
  void initState() {
    super.initState();

    provider = context.read<AddHiddenNotesViewModel>();
    hiddenNotesViewModel = context.read<HiddenNotesViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isUpdate) {
        final note = hiddenNotesViewModel.hiddenNotes[widget.index];
        provider.loadNoteForUpdate(note);
      } else {
        hiddenNotesViewModel.titleController.clear();
        hiddenNotesViewModel.descriptionController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddHiddenNotesViewModel>();
    final date = provider.formattedDate();
    return Scaffold(
      appBar: NotesSecondaryAppBar(
        appBarTitle: ' ${widget.isUpdate ? "Update" : "Add"} Hidden Notes',
        canPop: true,
        onBack: () => navigation.pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldComponent(
              controller: hiddenNotesViewModel.titleController,
              hintText: 'Title',
              onChanged:
                  (value) => provider.onTextChanged(
                    widget.isUpdate ? widget.index : null,
                  ),
            ),
            Text('   $date  |  ${provider.currentCharectersCount} charecters'),
            TextFieldComponent(
              controller: hiddenNotesViewModel.descriptionController,
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
