import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/usecases/create_note.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/usecases/get_notes.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/ui/blocs/note_bloc/note_event.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/ui/blocs/note_bloc/note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/delete_note.dart';
import '../../../domain/usecases/edit_note.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final CreateNoteUseCase createNoteUseCase;
  final EditNoteUseCase editNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNoteUseCase getNoteUseCase;

  NoteBloc(this.createNoteUseCase, this.editNoteUseCase, this.deleteNoteUseCase, this.getNoteUseCase): super(NoteInitialState()) {
    on<CreateNoteEvent>((event, emit) async {
      emit(NoteLoadingState());
      try {
        await createNoteUseCase.create(event.note);
        emit(NoteCreatedState(event.note));
      } catch (e) {
        emit(NoteErrorState('Error al crear la nota.'));
      }
    });

    on<EditNoteEvent>((event, emit) async {
      emit(NoteLoadingState());
      try {
        await editNoteUseCase.edit(event.note);
        emit(NoteEditedState(event.note));
      } catch (e) {
        emit(NoteErrorState('Error al editar la nota.'));
      }
    });

    on<DeleteNoteEvent>((event, emit) async {
      emit(NoteLoadingState());
      try {
        await deleteNoteUseCase.delete(event.noteId);
        emit(NoteDeleted());
      } catch (e) {
        emit(NoteErrorState('Error al borrar la nota.'));
      }
    });

    on<GetNotesEvent>((event, emit) async {
      emit(NoteLoadingState());
      try {
        final notes = await getNoteUseCase.getAll();
        emit(NotesLoadedState(notes));
      } catch (e) {
        emit(NoteErrorState('Error al cargar las nota.'));
      }
    });
  }
}