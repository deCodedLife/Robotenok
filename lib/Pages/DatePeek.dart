import 'package:flutter/material.dart';

import 'Groups.dart';

class daily {
  String dayOfWeek;
  int index;

  daily(this.dayOfWeek, this.index);
}

class DatePeek extends StatefulWidget {
  @override
  _DatePeekState createState() => _DatePeekState();
}

class _DatePeekState extends State<DatePeek> {

  List<daily> days = [
    daily(
      "Пн",
      0,
    ),
    daily(
        "Вт",
        1
    ),
    daily(
      "Ср",
      2,
    ),
    daily(
      "Чт",
      3,
    ),
    daily(
        "Пт",
        4
    ),
    daily(
      "Сб",
      5,
    ),
    daily(
      "Вс",
      6,
    ),
  ];

  List<daily> active_days = new List<daily>();
  int list = 0;

  initDays() {
    List<int> _days = [
      2, 3, 5, 6
    ];

    days.forEach((element) {
      bool currentDay = false;
      _days.forEach((day) {
        if (element.index == day) currentDay = true;
      });
      if (currentDay) {
        active_days.add(element);
      }
    });
  }

  bool active = false;

  @override
  Widget build(BuildContext context) {
    initDays();
    setState(() {
      list = active_days.length;
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {

          },
        ),
        title: Text(
          "Группы",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: list,
            itemBuilder: (context, index) => Daily(context, index)
        )
      ),
    );
  }
  Widget Daily (BuildContext context, int index) {
    bool current_visibility = false;

    active_days.forEach((element) {
      if (index == element) current_visibility = true;
    });

    return GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupsPage(-1, selectedDay: active_days.elementAt(index).index)));
        },
        child: Card(
          child:  Stack (
            children: <Widget>[
              Container(
                child: Center(
                  child: Text(
                    active_days.elementAt(index).dayOfWeek,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
