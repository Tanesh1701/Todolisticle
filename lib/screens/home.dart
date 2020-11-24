import 'package:flutter/material.dart';
import 'package:todoey/database/database_provider.dart';
import 'package:todoey/model/model.dart';
import 'package:todoey/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'createNewTask.dart';


class HomeState extends StatefulWidget {
  @override
  _HomeStateState createState() => _HomeStateState();
}

class _HomeStateState extends State<HomeState> {
  List<Task> tasks = [];

  void onTaskCreated(String text) {
    setState(() {
      tasks.add(Task(text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: missing_return
      onGenerateRoute: (settings) {
        if (settings.name == "/create") {
          return PageRouteBuilder(
        pageBuilder: (_, __, ___) => NewTodo(onTaskCreated),
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (_, anim, __, child) {
        return FadeTransition(opacity: anim, child: child);
      },
    );
  }
      },
      initialRoute: '/',
      routes: {
        '/': (context) => TaskDisplay(tasks),
        '/create': (context) => NewTodo(onTaskCreated)
      },
    );
  }
}

class TaskDisplay extends StatefulWidget {
  final List<Task> tasks;
  TaskDisplay(this.tasks);

  @override
  _TaskDisplayState createState() => _TaskDisplayState();
}

class _TaskDisplayState extends State<TaskDisplay> {

  randomimages() {
    int image = 0;
    var list = new List<int>.generate(12, (i) => i + 1);
    list.shuffle();
    image = list[0];
    return image;
  }

  randomquotes() {
    String quoteToDisplay;    
    quotes.shuffle();
    quoteToDisplay = quotes[0];
    return quoteToDisplay;
  }

  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getTasks().then((value) {
      setState(() {
        widget.tasks.addAll(value);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: SizeConfig.blockSizeHorizontal,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/${randomimages()}.jpg'),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 4,
                        child: Text(
                          randomquotes(),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: GestureDetector(
                      // onTap: () {
                      //   setState(() {
                      //     if (widget.done == true) {
                      //     widget.done = false;
                      //   }
                      //   else {
                      //     widget.done = true;
                      //   }
                      //   });
                      // },
                      onLongPress: () {
                        DatabaseProvider.db.delete(widget.tasks[index].id).then((value) => {
                          setState(() {
                          widget.tasks.removeAt(index);
                          })
                        }
                        );
                      },
                      child: Text(
                        widget.tasks[index].text,
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                          //decoration: widget.done ? TextDecoration.lineThrough: TextDecoration.none,
                          color: Colors.white,
                          height: 1.5,
                          fontSize: 17,
                        )),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        color: Color(0xff121212),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff3577FF),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
      ),
    );
  }
}
