import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Notification.dart';
import 'Student.dart';
import 'Camera.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  Widget studentCard(BuildContext context, int index) {
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
                        image: AssetImage(
                            "assets/profile.jpg"
                        ),
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
                        "Лавров Валерий",
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
                        "8-978-039-87-97",
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
              itemCount: 6,
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
