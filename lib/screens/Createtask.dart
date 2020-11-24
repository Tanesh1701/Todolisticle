// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:todoey/database/database_provider.dart';
// import 'package:todoey/model/model.dart';

// class TodoCreate extends StatefulWidget {
//   final onCreate;
//   TodoCreate(this.onCreate);
//   @override
//   _TodoCreateState createState() => _TodoCreateState();
// }

// class _TodoCreateState extends State<TodoCreate> {
//   final TextEditingController controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: TextField(
//             style: GoogleFonts.montserrat(
//               textStyle: TextStyle(
//                 color: Colors.white,
//                 fontSize: 17,
//                 height: 1.5
//               )
//             ),
//             autofocus: true,
//             controller: controller,
//             decoration: InputDecoration(
//               labelText: 'Add a new task'
//             ),
//           )
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color(0xff3577FF),
//         child: Icon(Icons.done, color: Colors.white),
//         onPressed: () {
//           Task task =Task(controller.text);
//           DatabaseProvider.db.insert(task);
//           widget.onCreate(controller.text);
//           Navigator.pop(context);
//         },
//       ),
//       backgroundColor: Color(0xff121212),
//     );
//   }
// }