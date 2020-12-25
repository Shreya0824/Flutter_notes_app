import 'package:intl/intl.dart';

class Note {
  int _id;
  String _title;
  String _content;

  Note(this._id, this._title, this._content);

  int get id => _id;
  String get title => _title;
  String get content => _content;


  String get date {
    final date = DateTime.fromMillisecondsSinceEpoch(id);
    return DateFormat('EEE h:mm a, dd/MM/yyyy').format(date);
  }
}
