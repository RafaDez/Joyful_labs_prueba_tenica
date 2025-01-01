import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/entities/note.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/repositories/note_repository.dart';

class CreateNoteUseCase {
  final NoteRepository repository;

  CreateNoteUseCase(this.repository);

  Future<void> create(Note note) async {
    await repository.createNote(note);
  }
}