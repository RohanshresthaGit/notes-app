import 'package:flutter/material.dart';

import '../../../core/common/widgets/secondary_app_bar.dart';

class HiddenNotesViews extends StatefulWidget {
  const HiddenNotesViews({super.key});

  @override
  State<HiddenNotesViews> createState() => _HiddenNotesViewsState();
}

class _HiddenNotesViewsState extends State<HiddenNotesViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotesSecondaryAppBar(
        canPop: true,
        appBarTitle: 'Hidden Notes',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Text(
          'No Hidden Notes Found',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},

        tooltip: 'Add Notes',
        child: Icon(Icons.add), // Replace with your icon
      ), // Add your floating action button here
    );
  }
}
