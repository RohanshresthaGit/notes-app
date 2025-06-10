import 'package:flutter/material.dart';
import 'package:notes_app/core/common/Model/notes_model.dart';
import 'package:provider/provider.dart';

import 'base_class.dart';

class NotesTileComponent<T extends BaseUiViewModel> extends StatelessWidget {
  const NotesTileComponent({
    super.key,
    required this.index,
    required this.note,
  });
  final int index;
  final Notes note;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = context.read<T>();
    return ListTile(
      onLongPress: () => viewModel.onLongPress(index),
      onTap: () => viewModel.onTap(index),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isThreeLine: true,
      tileColor: theme.primaryColor,
      title: Text(note.title, style: theme.textTheme.headlineMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.description,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium,
          ),
          Text(note.formattedDate, style: theme.textTheme.bodySmall),
        ],
      ),
      trailing: Consumer<T>(
        builder:
            (context, provider, child) =>
                provider.isSelectedMode
                    ? Checkbox(
                      value: provider.selectedItems.contains(index),
                      onChanged: (value) => provider.onTap(index),
                    )
                    : const SizedBox.shrink(),
      ),
    );
  }
}
