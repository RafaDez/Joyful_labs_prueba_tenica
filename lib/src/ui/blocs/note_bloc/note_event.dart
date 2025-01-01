import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/entities/note.dart';

abstract class NoteEvent {}

class CreateNoteEvent extends NoteEvent {
  final Note note;

  CreateNoteEvent(this.note);
}

class EditNoteEvent extends NoteEvent {
  final Note note;

  EditNoteEvent(this.note);
}

class DeleteNoteEvent extends NoteEvent {
  final int noteId;
  DeleteNoteEvent(this.noteId);
}

class GetNotesEvent extends NoteEvent {}