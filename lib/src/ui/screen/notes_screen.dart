
import 'package:app_notas_prueba_tenica_rafael_tobon/src/domain/entities/note.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/ui/blocs/note_bloc/note_bloc.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/ui/blocs/note_bloc/note_event.dart';
import 'package:app_notas_prueba_tenica_rafael_tobon/src/ui/widgets/note_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteScreen extends StatefulWidget {
  final bool isEdition;
  final Note? editNote;
  const NoteScreen({super.key, this.isEdition = false, this.editNote});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitle = TextEditingController();
  final TextEditingController _noteText = TextEditingController();
  final List<String> placeholderTag = [
    "tag #1",
    "tag #2",
    "tag #3"
  ];
  String date = '';
  List<String> tags = [];

  @override
  void initState() {
    super.initState();
    if (widget.isEdition) {
      _noteTitle.text = widget.editNote!.title;
      _noteText.text = widget.editNote!.content;
      date = widget.editNote!.date!;
    }
  }

  Future<bool> _onWillPop() async {
    if (_formKey.currentState?.validate() ?? false) {
      
      if (widget.isEdition) {
        Note noteModel = Note(id: widget.editNote!.id, title: _noteTitle.text, content: _noteText.text, tags: tags);
        context.read<NoteBloc>().add(EditNoteEvent(noteModel));
      } else if (_noteText.text.isNotEmpty && _noteTitle.text.isNotEmpty) {
        Note noteModel = Note(title: _noteTitle.text, content: _noteText.text, tags: tags);
        context.read<NoteBloc>().add(CreateNoteEvent(noteModel));
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardVisible = mediaQuery.viewInsets.bottom > 0;
    final availableHeight = mediaQuery.size.height - mediaQuery.viewInsets.bottom;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.all(8),
          child: Column(
            spacing: 10,
            children: [
              NoteTitle(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: PopupMenuButton<int>(
                      onSelected: (value) {
                        switch (value) {
                          case 1:
                            context.read<NoteBloc>().add(DeleteNoteEvent(widget.editNote!.id!));
                            Navigator.pop(context);
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text('Eliminar'),
                        ),
                      ],
                      child: Icon(Icons.more_vert),
                    ),
                  ),
                ],
              ),
              if (widget.isEdition) ...[
                Center(
                  child: Text("Última edición: $date"),
                ),
              ],
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: 1,
                        controller: _noteTitle,
                        decoration: InputDecoration(
                          hintText: "Titulo",
                          hintStyle: TextStyle(
                              color: Colors.black.withAlpha(127),
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (_noteText.text.isNotEmpty && (value == null || value.isEmpty)) {
                            return 'El titulo es obligatorio';
                          }
                          return null;
                        },
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: widget.isEdition ? keyboardVisible ? availableHeight * 0.36 : availableHeight * 0.56 : keyboardVisible ? availableHeight * 0.4 : availableHeight * 0.6,
                            child: TextFormField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              controller: _noteText,
                              decoration: InputDecoration(
                                hintText: "Nota",
                                hintStyle: TextStyle(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    fontSize: 20),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (_noteTitle.text.isNotEmpty && (value == null || value.isEmpty)) {
                                  return 'La nota es obligatorio';
                                }
                                return null;
                              },
                            ),
                          ),
                          if (placeholderTag.isNotEmpty)
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: listItemsInRow(placeholderTag))
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
            }, tooltip: "Crear nota", child: Icon(Icons.tag)),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}

List<Widget> listItemsInRow(List<String> tags) {
  return tags.map((tag) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(
              color: Colors.black.withValues(alpha: 0.5), width: 2)),
      child: Text(
        tag,
        style: TextStyle(color: Colors.black.withValues(alpha: 0.5)),
      ),
    );
  }).toList();
}