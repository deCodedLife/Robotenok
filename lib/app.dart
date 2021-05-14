import 'package:flutter/material.dart';
import 'package:robotenok/API/Auth.dart';

import 'DB/Provider.dart';
import 'Pages/MainPage.dart';
import 'Pages/DatePeek.dart';

// Testing imports
import 'DB/Visits.dart';
import 'DB/Costs.dart';
import 'DB/Courses.dart';
import 'DB/Groups.dart';
import 'DB/Payments.dart';
import 'DB/Profile.dart';
import 'DB/Provider.dart';
import 'DB/Students.dart';

import 'API/Server.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
      accentColor: Colors.redAccent,
    ),
    home: LandingPage(),
  ));
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentPage = 0;
  var controller = PageController();

  List<Widget> pages = [
    HomePage(),
    DatePeek(),
  ];

  DBStorage handler = DBStorage();

  @override
  void initState() {
    super.initState();
  }

  testDB() async
  {
    Student newStudent = new Student(
      name: "Руслана Даниева",
      sex: 0,
      parents: "",
      phone: "8-978-722-23-94"
    );
    Student().create(newStudent);

    GroupType newGroupType = new GroupType(
      name: "WeDo"
    );
    GroupType().add(newGroupType);

    var groupTypes = await DBStorage().getGroupsTypes();

    Group newGroup = new Group(
      name: "Среда 16:30",
      duration: 100,
      time: "16:30",
      weekday: DateTime.wednesday,
      groupType: groupTypes.first.id
    );
    Group().create(newGroup);

    Course newCourse = new Course(
      name: "Робототехника WeDo",
      lessons: 16,
      payment: 2800
    );
    Course().add(newCourse);

    var student = await DBStorage().getStudents();

    Payment newPayment = new Payment(
      time: DateTime.now().hour.toString() + ":" + DateTime.now().second.toString(),
      date: DateTime.now().day.toString() + "." + DateTime.now().month.toString() + "." + DateTime.now().year.toString(),
      type: "cash",
      credit: 2800,
      studentID: student.first.id
    );
    Payment().newPayment(newPayment);

    var couses = await DBStorage().getCourses();
    var groups = await DBStorage().getGroups();

    GroupStudents newGroupStudent = new GroupStudents(
        studentID: student.first.id,
        groupID: groups.first.id
    );
    GroupStudents().add(newGroupStudent);

    CoursesGroups newCourseGroup = new CoursesGroups(
      groupID: groups.first.id,
      courseID: couses.first.id,
    );
    CoursesGroups().add(newCourseGroup);

    Visit newVisit = new Visit(
      studentID: student.first.id,
      type: "intramural",
      time: DateTime.now().hour.toString() + ":" + DateTime.now().second.toString(),
      date: DateTime.now().day.toString() + "." + DateTime.now().month.toString() + "." + DateTime.now().year.toString()
    );
    Visit().create(newVisit);
  }

  testServer () {
    AuthProvider auth = new AuthProvider();
    auth.initData("codedlife", "8895304025");

    Server srv = new Server(
      authProvider: auth
    );

    srv.authProvider.getToken();
    print("Server done");
  }

  @override
  Widget build(BuildContext context) {
    // testServer;
    var task = handler.initializeDB();
    testDB();

    return Scaffold(
      body: PageView(
        controller: controller,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentPage = index;
            controller.animateToPage(
              currentPage,
              duration: Duration(microseconds: 200),
              curve: Curves.easeInOutCubic,
            );
          });
        },
        currentIndex: currentPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Курсы",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account), label: "Группы"),
          BottomNavigationBarItem(
              icon: Icon(Icons.table_chart), label: "Таблица")
        ],
      ),
    );
  }
}