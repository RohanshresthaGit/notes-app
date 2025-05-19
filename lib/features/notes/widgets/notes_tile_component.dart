import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/view_model/delete_notes_view_model.dart';
import 'package:provider/provider.dart';

class NotesTileComponent extends StatelessWidget {
  const NotesTileComponent({
    super.key,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.index,
  });
  final String title, description, createdAt;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress:
          () => context.read<DeleteNotesViewModel>().onLongPress(index),
      onTap: () => context.read<DeleteNotesViewModel>().onTap(index, context),
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isThreeLine: true,
      tileColor: Theme.of(context).primaryColor,
      title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(createdAt, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      trailing:
          context.read<DeleteNotesViewModel>().isSelectedMode
              ? Consumer<DeleteNotesViewModel>(
                builder:
                    (context, value, child) => Checkbox(
                      value: context
                          .read<DeleteNotesViewModel>()
                          .selectedItems
                          .contains(index),
                      onChanged:
                          (value) => context.read<DeleteNotesViewModel>().onTap(
                            index,
                            context,
                          ),
                    ),
              )
              : null,
    );
  }
}
