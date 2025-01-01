import 'package:app_notas_prueba_tenica_rafael_tobon/src/data/models/note_data_model.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/entities/note.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/repositories/note_repository.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class NoteRepositoryImpl extends NoteRepository {
  final Isar isar;

  NoteRepositoryImpl(this.isar);

  List<Note> _mapToDomain(List<NoteDataModel> noteDataModel) {
    return noteDataModel.map((note) => Note(
        id: note.id, 
        title: note.title!, 
        content: note.content!,
        tags: note.tags,
        date: note.date)
    ).toList();
  }

  NoteDataModel _mapToData(Note noteModel, {int? id}) {
    if (id != null) {
      return NoteDataModel()
      ..id = id
      ..title = noteModel.title
      ..content = noteModel.content
      ..date =  DateFormat('dd-MM-yyyy').format(DateTime.now());
    } 
    return NoteDataModel()
      ..title = noteModel.title
      ..content = noteModel.content
      ..date =  DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  @override
  Future<void> createNote(Note noteModel) async {
    final noteDataModel = _mapToData(noteModel);

    await isar.writeTxn(() async {
      await isar.noteDataModels.put(noteDataModel);
    });    
  }

   @override
  Future<void> editNote(Note noteModel) async {
    final noteDataModel = _mapToData(noteModel, id: noteModel.id);
    
    await isar.writeTxn(() async {
      await isar.noteDataModels.put(noteDataModel);
    });    
  }

  @override
  Future<void> deleteNote(int noteId) async {
    try {
      
      await isar.writeTxn(() async {
        await isar.noteDataModels.delete(noteId);
      }); 
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Future<List<Note>> getAllNotes() async {
    final noteDomain = _mapToDomain(await isar.noteDataModels.where().findAll());
    return noteDomain;
  }
}