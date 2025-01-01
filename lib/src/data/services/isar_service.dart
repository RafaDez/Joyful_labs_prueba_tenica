import 'package:app_notas_prueba_tenica_rafael_tobon/src/data/models/note_data_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static Future<Isar> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return await Isar.open([NoteDataModelSchema], directory: appDocDir.path);
  }
}