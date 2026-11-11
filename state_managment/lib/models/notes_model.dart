class NotesModel {
  String id;
  String title;
  String desc;
  DateTime createdAt;
  NotesModel({
    required this.title,
    required this.desc,
    required this.createdAt,
    required this.id
  });
}
