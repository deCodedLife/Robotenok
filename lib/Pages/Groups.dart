import 'package:flutter/material.dart';

class GroupsList {
  int weak;
  String time;
  String title;
  int dateIndex;
  Image icon;
  int typeIndex;

  GroupsList(this.weak, this.time, this.title, this.dateIndex, this.icon, this.typeIndex);
}

class GroupsPage extends StatefulWidget {
  int selectedDay;
  int selectedType;

  GroupsPage(this.selectedType, {
    Key key,
    @required this.selectedDay,
  }) : super(key : key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {

  List<GroupsList> groups = [
    GroupsList(
        DateTime.saturday,
        "9:30 - 12:15",
        "Mindstorms утро",
        6,
        Image.asset("assets/mindstorms.png"),
        4
    ),
    GroupsList(
      DateTime.saturday,
      "13:00 - 15:35",
      "Mindstorms день",
      6,
      Image.asset("assets/mindstorms.png"),
      4
    ),
    GroupsList(
      DateTime.saturday,
      "16:00 - 17:40",
      "Scratch вечер",
      6,
      Image.asset("assets/scratch.png"),
      3
    ),
    GroupsList(
      DateTime.saturday,
      "18:00 - 19:40",
      "Дизайн вечер",
      6,
      Image.asset("assets/designers.png"),
      0
    ),

    GroupsList(
      DateTime.sunday,
      "9:30 - 11:10",
      "Вэб утро",
      6,
      Image.asset("assets/web.png"),
      1
    ),
    GroupsList(
      DateTime.sunday,
      "11:30 - 13:10",
      "Вэб утро",
      6,
      Image.asset("assets/web.png"),
      1
    ),
    GroupsList(
      DateTime.sunday,
      "14:00 - 15:40",
      "Вэб день",
      6,
      Image.asset("assets/web.png"),
      1
    ),
    GroupsList(
        DateTime.sunday,
        "16:00 - 17:40",
        "Scratch вечер",
        6,
        Image.asset("assets/scratch.png"),
      3
    ),

    GroupsList(
        DateTime.thursday,
        "10:00 - 11:40",
        "WeDo утро",
        6,
        Image.asset("assets/wedo.png"),
      2
    ),
    GroupsList(
        DateTime.thursday,
        "16:00 - 17:40",
        "Дизайн вечер",
        6,
        Image.asset("assets/designers.png"),
      0
    ),
    GroupsList(
        DateTime.thursday,
        "18:00 - 19:40",
        "Дизайн вечер",
        6,
        Image.asset("assets/designers.png"),
      0
    ),

    GroupsList(
        DateTime.wednesday,
        "16:00 - 17:40",
        "WeDo утро",
        6,
        Image.asset("assets/wedo.png"),
      2
    ),
  ];

  List<GroupsList> selected = new List<GroupsList>();

  getItems () {
    var day = widget.selectedDay;

    if (widget.selectedType != -1) {
      groups.forEach((element) {
        if (element.typeIndex == widget.selectedType) {
          selected.add(element);
        }
      });
    } else {
      groups.forEach((element) {
        if ((element.weak - 1) == day) {
          selected.add(element);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getItems();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Список групп",
          style: TextStyle(
          color: Colors.white
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () { Navigator.of(context).pop(); },
        ),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < 0) {
            Navigator.of(context).pop();
          }
        },
        child: ListView.builder(
          itemCount: selected.length,
          itemBuilder: (context, index) => GroupsViewer(context, index),
        ),
      ),
    );
  }

  Widget GroupsViewer(BuildContext context, int index) {
    return ListTile(
      leading: selected.elementAt(index).icon,
      subtitle: Text(selected.elementAt(index).time),
      title: Text(selected.elementAt(index).title),
    );
  }
}
