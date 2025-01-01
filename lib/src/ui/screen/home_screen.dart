import 'package:app_notas_prueba_tenica_rafael_tobon/src/ui/screen/notes_screen.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/ui/widgets/note_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/note_bloc/note_bloc.dart';
import '../blocs/note_bloc/note_event.dart';
import '../blocs/note_bloc/note_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchText = TextEditingController();
  final List<String> filters = [
    "Todo",
    "Lista de tareas",
    "Notas",
    "Fijados",
    "Recientes"
  ];
  String selectedFilter = 'Todo';

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    Future.microtask(() {
      context.read<NoteBloc>().add(GetNotesEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.viewInsets.bottom;
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(8),
        child: Column(
          spacing: 10,
          children: [
            NoteTitle(),
            TextField(
              controller: _searchText,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Buscar mis notas",
                hintStyle:
                    TextStyle(color: Colors.black.withValues(alpha: 0.5)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
              onChanged: (value) {
                print(value);
              },
            ),
            if (filters.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: createFilter(filters, selectedFilter)),
              ),
            SizedBox(
              height: availableHeight * 0.65,
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is NoteLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NotesLoadedState) {
                    final notes = state.notes;
                    if (notes.isEmpty) {
                      return const Center(
                          child: Text('No hay notas disponibles.'));
                    }
                    return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: ListTile(
                            title: Text(note.title),
                            subtitle: Text(note.content),
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute<void>(builder: (context) => NoteScreen(isEdition: true, editNote: note,)),
                              );
                              _loadNotes();
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is NoteErrorState) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(
                      child: Text('Bienvenido a la app de notas.'));
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (context) => const NoteScreen()),
            );
            _loadNotes();
          },
          tooltip: "Crear nota",
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

List<Widget> createFilter(List<String> filters, String selectedFilter) {
  return filters.map((filter) {
    if (selectedFilter == filter) {
      return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            side: BorderSide(
                color: Colors.black.withValues(alpha: 0.5), width: 2)),
        child: Text(
          filter,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
      );
    } else {
      return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            side: BorderSide(
                color: Colors.black.withValues(alpha: 0.5), width: 2)),
        child: Text(
          filter,
          style: TextStyle(color: Colors.black.withValues(alpha: 0.5)),
        ),
      );
    }
  }).toList();
}
