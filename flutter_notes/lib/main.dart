import 'package:flutter/material.dart';
import 'package:flutter_notes/screens/note_view_screen.dart';
import 'package:provider/provider.dart';
import 'helper/note_provider.dart';
import 'screens/note_edit_screen.dart';
import 'screens/note_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => NoteProvider(),
      child: MaterialApp(
        title: "Flutter Notes",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => NoteListScreen(),
          '/note-view': (context) => NoteViewScreen(),
          '/note-edit': (context) => NoteEditScreen(),
        },
      ),
    );
  }
}
