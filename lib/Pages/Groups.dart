import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:robotenok/API/DataProvider.dart';
import 'package:robotenok/Pages/Notification.dart';

import '../DB/Groups.dart';
import '../API/Server.dart';
import '../globals.dart' as globals;

import 'Group.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  List<int> selectedTiles = [];
  List<int> selectedWeekdays = [];
  List<GroupType> _groupTypes = [];

  List<Group> groups = [];
  List<GroupType> groupTypes = [];

  List<Group> actualGroups = [];

  bool isMore = false;

  @override
  initState() {
    super.initState();

    groups = globals.groups;
    groupTypes = globals.groupTypes;

    exec();
  }

  void exec() async {
    if (globals.groups.isNotEmpty) return;

    GroupCurator curator = new GroupCurator();
    List<GroupCurator> selectedGroups = [];
    curator.userID = globals.profile.id;

    DataPack pack = new DataPack();
    pack.token = globals.authProvider.token;
    pack.body = curator.toJson();

    var data = await Server().getData("group-curators", pack.toJson());
    RespDynamic response = RespDynamic.fromJson(jsonDecode(data.body));

    if (response.status != 200) {
      return;
    }

    for (Map<String, dynamic> item in response.body) {
      selectedGroups.add(new GroupCurator.fromJson(item));
    }

    for (GroupCurator group in selectedGroups) {
      Group searchingGroup = new Group();
      searchingGroup.id = group.groupID;

      pack.body = searchingGroup.toJson();
      data = await Server().getData("groups", pack.toJson());

      response = RespDynamic.fromJson(jsonDecode(data.body));

      if (response.status != 200) {
        continue;
      }

      for (Map<String, dynamic> item in response.body) {
        Group element = Group.fromJson(item);
        groups.add(element);

        GroupType searchingGroupType = new GroupType();
        searchingGroupType.id = element.groupType;
        pack.body = searchingGroupType.toJson();

        data = await Server().getData("group-types", pack.toJson());
        response = RespDynamic.fromJson(jsonDecode(data.body));

        if (response.status != 200) {
          continue;
        }

        for (Map<String, dynamic> item in response.body) {
          GroupType element = GroupType.fromJson(item);

          for (GroupType type in groupTypes) {
            if (element.id == type.id) element = null;
          }

          if (element != null) groupTypes.add(element);
        }
      }
    }

    pack.body = new GroupType(active: 1).toJson();
    data = await Server().getData("group-types", pack.toJson());

    if (data.statusCode != 200) {
      data.body != null
          ? Notifications(context: context).customError(data.body)
          : Notifications(context: context).serverError();
    }

    response = RespDynamic.fromJson(jsonDecode(data.body));

    for (Map<String, dynamic> item in response.body) {
      _groupTypes.add(GroupType.fromJson(item));
    }

    globals.groups = groups;
    globals.groupTypes = groupTypes;

    setState(() {});
  }

  Widget TileProvider(BuildContext context, int index) {
    bool _isSelected = false;

    for (int tile in selectedTiles) {
      if (index == tile) {
        _isSelected = true;
      }
    }

    return TypeWidget(_isSelected, index, context);
  }

  Padding TypeWidget(bool _isSelected, int index, BuildContext context) {
    var currentType = groupTypes.elementAt(index);

    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          if (_isSelected) {
            selectedTiles.remove(index);
          } else {
            selectedTiles.add(index);
          }
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: _isSelected ? Theme.of(context).accentColor : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Text(
            currentType.name,
            style: TextStyle(
                color: _isSelected ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget GroupCard(BuildContext context, int index) {
    var currentGroup = groups.elementAt(index);

    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GroupPage(
                    currentGroup: currentGroup,
                  )));
        },
        child: Stack(
          fit: StackFit.loose,
          children: [
            BackgroundImage(),
            Container(
              width: double.infinity,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Name(
                    weekday: currentGroup.weekday,
                    start: currentGroup.time,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Search() {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(minWidth: double.infinity, maxHeight: 64),
      child: ListView.builder(
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
        itemCount: groupTypes.length,
        itemBuilder: (context, index) => TileProvider(context, index),
      ),
    );
  }

  Widget WeekdaysProvider(BuildContext context, int index) {
    bool _isSelected = false;

    for (int day in selectedWeekdays) {
      if (index == day) {
        _isSelected = true;
      }
    }

    return WeekDays(_isSelected, index, context);
  }

  Widget WeekDays(bool _isSelected, int index, BuildContext context) {
    String day;

    if (index == 0) day = "Пн";
    if (index == 1) day = "Вт";
    if (index == 2) day = "Ср";
    if (index == 3) day = "Чт";
    if (index == 4) day = "Пт";
    if (index == 5) day = "Сб";
    if (index == 6) day = "Вс";

    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          if (_isSelected) {
            selectedWeekdays.remove(index);
          } else {
            selectedWeekdays.add(index);
          }
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: _isSelected ? Theme.of(context).accentColor : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Text(
            day,
            style: TextStyle(
                color: _isSelected ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget Addons() {
    return isMore
        ? ConstrainedBox(
            constraints:
                const BoxConstraints(minWidth: double.infinity, maxHeight: 64),
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) => WeekdaysProvider(context, index),
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Группы",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isMore = !isMore;
              });
            },
            icon: Icon(Icons.more_vert, color: Colors.black),
          )
        ],
      ),
      body: Column(
        children: [
          Search(),
          Addons(),
          Expanded(
            child: ListView.builder(
              itemCount: groups.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) => GroupCard(context, index),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                var newGroup = Group();
                var selectedGroupType = _groupTypes.first;

                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text("Новая группа"),
                      actions: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Expanded(
                            child: Container(
                              child: DropdownButton<GroupType>(
                                iconSize: 30,
                                icon: Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Theme.of(context).accentColor,
                                ),
                                value: selectedGroupType,
                                onChanged: (item) {
                                  setState(() {
                                    selectedGroupType = item;
                                  });
                                },
                                items: _groupTypes
                                    .map<DropdownMenuItem<GroupType>>(
                                        (GroupType value) {
                                  return DropdownMenuItem<GroupType>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              });
        },
      ),
    );
  }
}

class Name extends StatelessWidget {
  final int weekday;
  final String start;

  const Name({Key key, this.weekday, this.start}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String day;

    if (weekday == -1) day = "Ежедневно";
    if (weekday == 1) day = "Понедельник";
    if (weekday == 2) day = "Вторник";
    if (weekday == 3) day = "Среда";
    if (weekday == 4) day = "Четверг";
    if (weekday == 5) day = "Пятница";
    if (weekday == 6) day = "Суббота";
    if (weekday == 7) day = "Воскресенье";

    String parseTime = DateTime.now().toUtc().toString();
    var parts = parseTime.split(" ");
    parseTime = parts[0] + " " + start + ".000Z";

    var groupDate = DateTime.parse(parseTime);

    return Text(
      "$day ${DateFormat.Hms().format(groupDate)}",
      style: TextStyle(
          fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}

class Payment extends StatelessWidget {
  final int payment;

  const Payment({Key key, this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.monetization_on,
          color: Colors.white,
        ),
        Text(
          "$payment",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Container(
        color: Color.fromARGB(100, 0, 0, 0),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/bg_wedo.jpg"), fit: BoxFit.fitWidth),
      ),
    );
  }
}
