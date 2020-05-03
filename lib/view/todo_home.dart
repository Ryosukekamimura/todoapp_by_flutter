import 'package:flutter/material.dart';
import 'package:todo/add_todo_screen.dart';
import 'package:todo/view/todo_list.dart';
import 'package:todo/model/todo_model.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ToDoHome extends StatefulWidget {

  @override
  _ToDoHomeState createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {

  String subject = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Colors.lightBlueAccent,
              onPressed: () {
                showModalBottomSheet(
                    context: context, builder: (context) => AddTodoScreen());
              },
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
      onPressed: () {
        final RenderBox box = context.findRenderObject();
        //TODO: shareメソッドの使い方
        Share.share("${Provider.of<TodoModel>(context, listen:false).todos[0].todoTask}",
            subject: subject,
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      },
      backgroundColor: Colors.red,
      child: FaIcon(FontAwesomeIcons.hashtag),
    )
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 80),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0)),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: Icon(
                        Icons.assignment,
                        size: 30.0,
                      ),
                      radius: 30.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '#今日の積み上げ',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${Provider.of<TodoModel>(context).todoCount.toString()} items',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TodoList(),
              )
            ],
          ),
        ));
  }
}


