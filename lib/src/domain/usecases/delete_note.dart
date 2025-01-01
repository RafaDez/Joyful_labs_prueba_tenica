import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/repositories/note_repository.dart';

class DeleteNoteUseCase {
  final NoteRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<void> delete(int noteId) async {
    await repository.deleteNote(noteId);
  }
}