import 'package:flutter/material.dart';
import 'package:flutter_notes/helper/note_provider.dart';
import 'package:flutter_notes/widgets/list_item.dart';
import 'package:provider/provider.dart';

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Consumer<NoteProvider>(
                builder: (context, noteprovider, child) =>
                    noteprovider.items.length == 0
                        ?  Container()
                        : ListView.builder(
                            itemCount: noteprovider.items.length ,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Container();
                              }
                              else {
                                final i = index - 1;
                                final item = noteprovider.items[i];

                                return ListItem(
                                  item.id,
                                  item.title,
                                  item.content,
                                  item.date,
                                );
                              }
                            },
                          ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  goToNoteEditScreen(context);
                },
                child: Icon(Icons.add),
              ),
            );
          }
        }
        return Container();
      },
    );
  }





  void goToNoteEditScreen(BuildContext context) {
    Navigator.of(context).pushNamed('/note-edit');
  }
}
