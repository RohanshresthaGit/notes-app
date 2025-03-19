import 'package:hive/hive.dart';
part 'generated/notes_model.g.dart'; 
@HiveType(typeId: 0)
class Notes extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String createdAt;

  Notes({
    required this.title,
    required this.description,
    required this.createdAt,
  });
}
