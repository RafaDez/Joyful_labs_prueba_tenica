class Note {
  final int? id;
  final String title;
  final String content;
  final List<String>? tags;
  final String? date;

  Note({
    this.id,
    required this.title,
    required this.content,
    this.tags,
    this.date,
  });
}