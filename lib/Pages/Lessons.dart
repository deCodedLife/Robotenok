import 'dart:convert';

import 'package:flutter/material.dart';

import '../globals.dart' as globals;

import '../DB/Lessons.dart';
import '../DB/Groups.dart';

import '../API/DataProvider.dart';
import '../API/Server.dart';

class Lessons extends StatefulWidget {
  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  List<Lesson> lessons = globals.lessons;

  @override
  void initState() {
    super.initState();

    var searchLessons = Lesson(Active: 1);
    List<Lesson> tempLessons = [];
    var request = DataPack(
        token: globals.authProvider.token, 
        body: searchLessons.toJson(),
    );
    
    var future = Server().getData("select-classes", request.toJson());

    future.then((response) {
      if (response.statusCode != 200) {
        return;
      }

      var data = RespDynamic.fromJson(jsonDecode(response.body));

      for (Map<String, dynamic> item in data.body) {
        tempLessons.add(Lesson.fromJson(item));
      }

      if (tempLessons.length != globals.lessons.length) {
        globals.lessons = tempLessons.reversed.toList();
      }

      tempLessons = [];

      setState(() {
        lessons = globals.lessons;
      });
    });
  }

  Widget LessonTile(BuildContext context, int index) {
    Lesson currentLesson = lessons.elementAt(index);
    Group currentGroup = new Group();

    for(Group item in globals.groups) {
      if (item.id == currentLesson.GroupID) {
        currentGroup = item;
      }
    }

    return ListTile(
      tileColor: Colors.lightBlue,
      title: Text(
        currentGroup.name,
        style: Theme.of(context).textTheme.headline5,
      ),
      subtitle: Text(
        currentLesson.Date,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => LessonTile(context, index),
      itemCount: lessons.length,
    );
  }
}
