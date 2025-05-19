import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'generated/notes_model.g.dart'; 
@HiveType(typeId: 0)
class Notes extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime createdAt;

  Notes({
    required this.title,
    required this.description,
    required this.createdAt,
  });
  String get formattedDate =>
      DateFormat('dd MMM yyyy, hh:mm a').format(createdAt);
}
