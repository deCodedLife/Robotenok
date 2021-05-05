import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Groups.dart';

bool _moreInfo = false;

class HomePage extends StatefulWidget {
  final visible = false;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var controller = PageController();

  int currentPage = 0;

  double x = 0;
  double y = 0;

  List<Stack> pages = [
    Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg_design.jpg"),
              fit: BoxFit.fitHeight
            ),
          ),
        ),
        Container(
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
        Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Дизайн',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '2800 3200',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  'Длительность: 1.40',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )
          ),
        ),
      ],
    ),
    Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg_web.png"),
                fit: BoxFit.fitHeight
            ),
          ),
        ),
        Container(
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
        Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Web',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '2800 3200',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  'Длительность: 1.40',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )
          ),
        ),
      ],
    ),
    Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg_wedo.jpg"),
                fit: BoxFit.fitHeight
            ),
          ),
        ),
        Container(
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
        Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'WeDo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '2400 2800',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  'Длительность: 1.40',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )
          ),
        ),
      ],
    ),
    Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg_scratch.jpg"),
                fit: BoxFit.fitHeight
            ),
          ),
        ),
        Container(
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
        Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Scratch',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '2400-2800',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  'Длительность: 1.40',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )
          ),
        ),
      ],
    ),
    Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg_mindstorms.jpg"),
                fit: BoxFit.fitHeight
            ),
          ),
        ),
        Container(
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
        Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Mindstorms',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '3200-3600',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  'Длительность: 2.45',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )
          ),
        ),
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dy < 0) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupsPage(currentPage, selectedDay: -1,)));
          }
        },
        onTap: () {
          setState(() {
            currentPage++;
            if (currentPage > 4) {
              currentPage = 0;
            }
          });
          controller.animateToPage(currentPage, duration: Duration(milliseconds: 200), curve: Curves.easeInOutCubic);
        },
        child: PageView(
          controller: controller,
          children: pages,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
        ),
      ),
    );
  }
}
