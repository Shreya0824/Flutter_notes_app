import 'package:flutter/material.dart';
import 'package:flutter_notes/helper/note_provider.dart';
import 'package:flutter_notes/models/note.dart';
import 'package:flutter_notes/utils/constants.dart';
import 'package:flutter_notes/widgets/delete_popup.dart';
import 'package:provider/provider.dart';

class NoteEditScreen extends StatefulWidget {


  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();


  bool firstTime = true;
  Note selectedNote;
  int id;

    @override
    void didChangeDependencies() {
      // TODO: implement didChangeDependencies
      super.didChangeDependencies();

      if (firstTime) {
        id = ModalRoute.of(this.context).settings.arguments;

        if (id != null) {
          selectedNote = Provider.of<NoteProvider>(
            this.context,
            listen: false,
          ).getNote(id);

          titleController.text = selectedNote.title;
          contentController.text = selectedNote.content;


        }
      }
      firstTime = false;
    }

    @override
    void dispose() {
      titleController.dispose();
      contentController.dispose();

      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
          color: black,
        ),
        actions: [

          IconButton(
            icon: Icon(Icons.delete),
            color: black,
            onPressed: () {
              if (id != null) {
                _showDialog();
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 10.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: TextField(
                controller: titleController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: createTitle,
                decoration: InputDecoration(
                    hintText: 'Enter Note Title', border: InputBorder.none),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: TextField(
                controller: contentController,
                maxLines: null,
                style: createContent,
                decoration: InputDecoration(
                  hintText: 'Enter Something...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text.isEmpty)
            titleController.text = 'Untitled Note';

          saveNote();
        },
        child: Icon(Icons.save),
      ),
    );
  }


  void saveNote() {
    String title = titleController.text.trim();
    String content = contentController.text.trim();

    if (id != null) {
      Provider.of<NoteProvider>(
        this.context,
        listen: false,
      ).addOrUpdateNote(id, title, content, EditMode.UPDATE);
      Navigator.of(this.context).pop();
    } else {
      int id = DateTime.now().millisecondsSinceEpoch;

      Provider.of<NoteProvider>(this.context, listen: false)
          .addOrUpdateNote(id, title, content, EditMode.ADD);

      Navigator.of(this.context)
          .pushReplacementNamed('/note-view', arguments: id);
    }
  }

  void _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return DeletePopUp(selectedNote);
        });
  }
}
