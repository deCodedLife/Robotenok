import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../globals.dart' as globals;

import 'Notification.dart';
import 'Student.dart';
import 'Camera.dart';

import '../API/Server.dart';
import '../API/DataProvider.dart';

import '../DB/Students.dart';
import '../DB/Groups.dart';

class GroupPage extends StatefulWidget {
  final Group currentGroup;

  GroupPage({
    this.currentGroup
  });

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

  String searchBy;

  List<Student> students = [];

  @override
  initState() {
    super.initState();
    init();
  }

  void init () async {
    List<GroupStudent> groupStudents = [];

    GroupStudent searchingStudents = new GroupStudent(
        groupID: widget.currentGroup.id
    );

    DataPack request = new DataPack(
        token: globals.authProvider.token,
        body: searchingStudents.toJson()
    );

    var response = await Server().getData("group-students", request.toJson());

    if ( response.statusCode != 200 ) {
      Notifications(context: context).serverError();
      return;
    }

    RespDynamic data = RespDynamic.fromJson(jsonDecode(response.body));

    if ( data.status != 200 ) {
      Notifications(context: context).customError(data.body.toString());
      return;
    }

    for ( Map<String, dynamic> student in data.body ) {
      groupStudents.add( GroupStudent.fromJson( student ) );
    }

    for ( GroupStudent student in groupStudents ) {
      Student requestedStudent = new Student(
          id: student.id
      );
      request.body = requestedStudent.toJson();

      response = await Server().getData("students", request.toJson());

      if ( response.statusCode != 200 ) {
        Notifications(context: context).serverError();
        return;
      }

      data = RespDynamic.fromJson( jsonDecode( response.body ) );

      if ( data.status != 200 ) {
        Notifications(context: context).customError(data.body.toString());
      }

      print(data.body);

      for ( Map<String, dynamic> item in data.body ) {
        students.add( Student.fromJson( item ) );
      }

    }

    setState(() {});
  }

  ImageProvider StudentImage(Student student) {
    return student.image != "" ? NetworkImage(student.image) : AssetImage("logo.jpg");
  }

  Widget studentCard(BuildContext context, int index) {
    var currentStudent = students.elementAt(index);

    return Card(
      elevation: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentPage()));
        },
        child: Padding(
          padding: EdgeInsets.all(5),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: StudentImage(currentStudent),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 18),
                      Text(
                        currentStudent.name,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.cancel, size: 18),
                      Text(
                        "Не оплачено",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 18),
                      Text(
                        currentStudent.phone,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  )
                ],
              ),
              // Spacer()
            ],

          ),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
        ),
        title: Text("Суббота 10:00", style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Notify(
            context: context,
            title: Text("Новый студент"),
            actions: [
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "ФИО"
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Возраст"
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Номер"
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TakePictureScreen())
                    );
                  },
                ),
              )
            ]
          ).show();
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: TextField(
              minLines: 1,
              maxLines: 1,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "Имя, тел",
                prefixIcon: Icon(Icons.search)
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: students.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:  2, childAspectRatio: 0.75),
              padding: EdgeInsets.only(left: 15, right: 15),
              itemBuilder: (context, index) => studentCard(context, index),
            ),
          )
        ],
      ),
    );
  }
}
