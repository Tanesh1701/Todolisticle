import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoey/database/database_provider.dart';
import 'package:todoey/model/model.dart';
import 'package:todoey/size_config.dart';

class NewTodo extends StatefulWidget {
  final onCreate;
  NewTodo(this.onCreate);

  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: AlertDialog(
          content: TextField(
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(color: Color(0xff121212), fontSize: 13, height: 2)),
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Add a new task',
          labelStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: Color(0xff3577FF),
              fontSize: 17,
              height: 1
            )
          )
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Task task =Task(controller.text);
            DatabaseProvider.db.insert(task);
            widget.onCreate(controller.text);
            Navigator.pop(context);
          },
          child: Text(
            'Done',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: Color(0xff3577FF),
              )
            ),
          )
        )
      ]
      ),
    );
  }
}
