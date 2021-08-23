import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:robotenok/DB/Students.dart';
import 'package:robotenok/DB/Visits.dart';

import '../globals.dart' as globals;

import 'package:robotenok/API/DataProvider.dart';
import 'package:robotenok/API/Server.dart';
import 'package:robotenok/DB/Groups.dart';

class LessonPage extends StatefulWidget {
  Group currentGroup;

  LessonPage({Key key, this.currentGroup}) : super(key: key);

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  Group currentGroup;
  List<Student> students = [];
  List<Visit> visits = [];

  @override
  void initState() {
    super.initState();
    currentGroup = widget.currentGroup;

    List<Student> tempStudents = [];
    GroupStudent searchStudent = GroupStudent(
      groupID: currentGroup.id
    );
    DataPack request = new DataPack(
      token: globals.authProvider.token,
      body: searchStudent.toJson(),
    );

    var future = Server().getData("select-group-students", request.toJson());

    future.then(
        (response) {

          if (response.statusCode != 200 || response.body == null) {
            return;
          }

          var data = RespDynamic.fromJson(jsonDecode(response.body));

          for (Map<String, dynamic> item in data.body) {
            GroupStudent groupStudent = GroupStudent.fromJson(item);
            request.body = Student(id: groupStudent.studentID).toJson();
            future = Server().getData("select-students", request.toJson());

            future.then(
                (response) {

                  if (response.statusCode != 200) {
                    return;
                  }

                  var data = RespDynamic.fromJson(jsonDecode(response.body));

                  for (Map<String, dynamic> item in data.body) {
                    tempStudents.add(Student.fromJson(item));
                  }

                  setState(() {
                    students = tempStudents;
                  });
                }
            );
          }
        }
    );
  }

  Widget StudentTile(BuildContext context, int index) {
    Color _currentColor = Colors.deepOrangeAccent;
    Student currentStudent = students.elementAt(index);

    for (Visit item in visits) {
      if (item.studentID == currentStudent.id) _currentColor = Colors.lightGreenAccent;
    }

    return ListTile(
      title: Text(
        currentStudent.name,
        style: Theme.of(context).textTheme.headline6,
      ),
      tileColor: _currentColor,
      trailing: Icon(Icons.monetization_on),
      onTap: () {
        setState(() {
          visits.add(
            Visit(
              type: "offline",
              studentID: currentStudent.id
            )
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ""
        ),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) => StudentTile(context, index),
      ),
    );
  }
}
