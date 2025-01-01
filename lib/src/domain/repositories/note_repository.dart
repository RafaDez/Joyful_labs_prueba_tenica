import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/entities/note.dart';

abstract class NoteRepository {
  Future<void> createNote(Note noteModel);
  Future<void> deleteNote(int noteId);
  Future<List<Note>> getAllNotes();
  Future<void> editNote(Note noteModel);
}