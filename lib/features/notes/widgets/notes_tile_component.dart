import 'package:flutter/material.dart';

class NotesTileComponent extends StatelessWidget {
  const NotesTileComponent({
    super.key,
    required this.title,
    required this.description,
    required this.createdAt,
  });
  final String title, description, createdAt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
