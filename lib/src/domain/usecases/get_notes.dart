import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/entities/note.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/repositories/note_repository.dart';

class GetNoteUseCase {
  final NoteRepository repository;

  GetNoteUseCase(this.repository);

  Future<List<Note>> getAll() async {
    return await repository.getAllNotes();
  }
}