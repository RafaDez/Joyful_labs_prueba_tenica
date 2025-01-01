import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/entities/note.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/repositories/note_repository.dart';

class EditNoteUseCase {
  final NoteRepository repository;

  EditNoteUseCase(this.repository);

  Future<void> edit(Note note) async {
    await repository.editNote(note);
  }
}