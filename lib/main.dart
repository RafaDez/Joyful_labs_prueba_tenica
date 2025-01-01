import 'package:app_notas_prueba_tenica_rafael_tobon/src/data/repositories/note_repository_impl.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/data/services/isar_service.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/usecases/create_note.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/usecases/delete_note.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/usecases/get_notes.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/ui/blocs/note_bloc/note_bloc.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

import 'src/domain/usecases/edit_note.dart';

// en C:\Users\rtobo\OneDrive\Documents\pruebas tecnicas\2024\Joyful labs\app_notas_prueba_tenica_rafael_tobon\android\settings.gradle,     │
//│ in the 'plugins' closure (by the number following "com.android.application").
// se cambio la version porque la anterior genera error con hive_flutter

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await IsarService.init();
  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  final Isar isar;
  const MyApp({super.key, required this.isar});

  @override
  Widget build(BuildContext context) {
    final noteRepository = NoteRepositoryImpl(isar);

    final createNoteUseCase = CreateNoteUseCase(noteRepository);
    final editNoteUseCase = EditNoteUseCase(noteRepository);
    final deleteNoteUseCase = DeleteNoteUseCase(noteRepository);
    final getNoteUseCase = GetNoteUseCase(noteRepository);

    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => NoteBloc(createNoteUseCase, editNoteUseCase, deleteNoteUseCase, getNoteUseCase)), ], 
        child: MaterialApp(
      theme: ThemeData.light(),
      home:  const SplashScreen(),
    ),
    );
  }
}
