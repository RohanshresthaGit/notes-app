import 'package:flutter/material.dart';
import 'package:notes_app/core/common/widgets/secondary_app_bar.dart';

class AddNotesViews extends StatefulWidget {
  const AddNotesViews({super.key});

  @override
  State<AddNotesViews> createState() => _AddNotesViewsState();
}

class _AddNotesViewsState extends State<AddNotesViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotesSecondaryAppBar(appBarTitle: 'Add Notes', canPop: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            TextFormField(decoration: InputDecoration(hintText: 'Title')),
          ],
        ),
      ),
    );
  }
}
