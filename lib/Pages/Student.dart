import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

List<ListTile> students = [
  ListTile(
    leading: Icon(Icons.monetization_on),
    title: Text("Оплата занятия"),
  ),
  ListTile(
    leading: Icon(Icons.check_box),
    title: Text("Посещение"),
  )
];

class _StudentPageState extends State<StudentPage> {
  Widget studentTile(BuildContext context, int index) {
    return students.elementAt(index);
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
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black,),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: Colors.black),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Card(
              child: Container(
                width: double.infinity,
                height: 180,
                child: Row(
                  children: [
                    // SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, size: 24),
                                Text(
                                  "Лавров Валерий",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.monetization_on, size: 24),
                                Text(
                                  "Не оплачено",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 24),
                                Text(
                                  "8-978-039-87-97",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/profile.jpg",
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "История",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "20.08.2021",
              style: TextStyle(
                color: Colors.grey
              ),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     padding: EdgeInsets.only(left: 15, right: 15),
          //     itemCount: students.length,
          //     itemBuilder: (context, index) => studentTile(context, index),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: students.elementAt(students.length - 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: students.elementAt(students.length - 1),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "18.08.2021",
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: students.elementAt(students.length - 1),
          )
        ],
      ),
    );
  }
}
