import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DB/Provider.dart';

import 'Pages/MainPage.dart';
import 'Pages/DatePeek.dart';

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
  Widget build(BuildContext context) {
    handler.initializeDB();
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