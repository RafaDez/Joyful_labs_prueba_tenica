import 'package:isar/isar.dart';

// Try with isar

part 'note_data_model.g.dart';

@Collection()
class NoteDataModel {
  Id id = Isar.autoIncrement;
  String? title;
  String? content;
  List<String>? tags;
  String? date;
}
