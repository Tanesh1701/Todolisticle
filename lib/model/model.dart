import 'package:todoey/database/database_provider.dart';

class Task {
  String text;
  bool isDone;
  int id;

  Task(this.text);

   Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_TEXT: text,
    };

    if (id!=null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    text = map[DatabaseProvider.COLUMN_TEXT];
  }
}