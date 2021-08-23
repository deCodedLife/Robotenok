import 'package:flutter/material.dart';

import '../API/Server.dart';
import '../DB/Image.dart';
import '../DB/Students.dart';

import 'Notification.dart';
import 'Camera.dart';

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  Student newStudent = Student(
      age: "Дата рождения"
  );
  DateTime selectedDate;
  DateTime currentDate = DateTime.now();

  bool nameValidation = false;
  bool phoneValidation = false;

  var nameTextController = TextEditingController();
  var phoneTextController = TextEditingController();

  @override
  initState() {
    super.initState();

    nameTextController.text = newStudent.name != null ? newStudent.name : "";
    phoneTextController.text = newStudent.phone != null ? newStudent.phone : "";
  }

  reverseDate(String date) {
    var parts = date.split(" ");
    date = parts[0];

    parts = date.split("-");

    if (parts.length < 2) {
      return "";
    }

    date = parts[2] + "-" + parts[1] + "-" + parts[0];

    return date;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate != null ? selectedDate : currentDate.subtract(Duration(days:  365 * 4)),
        firstDate: DateTime.now().subtract(Duration(days: 365 * 16)),
        lastDate: DateTime.now().subtract(Duration(days:  365 * 4))
    );

    if ( pickedDate != null ) {
      setState(() {
        print(pickedDate);
        selectedDate = pickedDate;
        newStudent.age = reverseDate(pickedDate.toString());
      });
    }
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
            onPressed: () {
              setState(() {
                nameValidation = nameTextController.text.isEmpty ? true : false;
                phoneValidation = phoneTextController.text.isEmpty ? true : false;
              });

              if ( nameValidation || phoneValidation ) return;

              newStudent.name = nameTextController.text;
              newStudent.phone = phoneTextController.text;

              if ( selectedDate == null ) {

                Notify(
                    context: context,
                    title: Text("Ошибка"),
                    child: Text("Введите дату"),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Ок"),
                      )
                    ]
                ).show();

                return;

              }

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TakePictureScreen())
              );
            },
            icon: Icon(Icons.check, color: Colors.black),
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
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              style: TextStyle(
                                  fontSize: 14
                              ),
                              controller: nameTextController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person_add),
                                  labelText: "Имя",
                                  errorText: nameValidation ? "Введите имя" : null
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () async {
                                await selectDate(context);
                                setState(() {});
                              },
                              child: IntrinsicWidth(
                                stepWidth: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                      newStudent.age
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              style: TextStyle(
                                  fontSize: 14
                              ),
                              controller: phoneTextController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.phone),
                                  hintText: "Номер",
                                  errorText: phoneValidation ? "Введите номер" : null
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Image.asset( "assets/logo.jpg" )
                    )
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
              reverseDate(DateTime.now().toString()),
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ListTile(
              leading: Icon(Icons.star),
              title: Text("Присоединился"),
            ),
          ),
        ],
      ),
    );
  }
}