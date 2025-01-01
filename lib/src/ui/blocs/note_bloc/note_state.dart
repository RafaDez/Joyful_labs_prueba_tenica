import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/entities/note.dart';


abstract class NoteState {}

class NoteInitialState extends NoteState {}

class NoteLoadingState extends NoteState {}

class NoteCreatedState extends NoteState{
  final Note note;

  NoteCreatedState(this.note);
}

class NoteEditedState extends NoteState{
  final Note note;

  NoteEditedState(this.note);
}

class NotesLoadedState extends NoteState {
  final List<Note> notes;
  NotesLoadedState(this.notes);
}

class NoteDeleted extends NoteState {}

class NoteErrorState extends NoteState {
  final String message;

  NoteErrorState(this.message);
}