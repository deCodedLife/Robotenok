import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:robotenok/globals.dart' as globals;

import 'Auth.dart';
import 'Server.dart';
import 'DataProvider.dart';

import '../DB/Groups.dart';
import '../DB/Profile.dart';

import '../Pages/Lesson.dart';

class Workers {
  DateTime _dateTime;
  Server server = Server();
  Profile profile = Profile();
  AuthProvider provider = AuthProvider();
  List<Group> activeGroups = [];
  BuildContext context;

  void initProfileData() async {
    profile = await Profile().get();
  }

  void checkGroups() async {
    GroupCurator curator = new GroupCurator();
    List<GroupCurator> selectedGroups = [];
    curator.userID = profile.id;

    DataPack pack = new DataPack();
    pack.token = provider.token;
    pack.body = curator.toJson();

    var data = await server.getData("select-group-curators", pack.toJson());
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
      data = await server.getData("select-groups", pack.toJson());

      response = RespDynamic.fromJson(jsonDecode(data.body));

      if (response.status != 200) {
        continue;
      }

      for (Map<String, dynamic> item in response.body) {
        activeGroups.add(new Group.fromJson(item));
      }
    }

    globals.groups = activeGroups;

    checkActiveLessons();
  }

  void checkActiveLessons() {
    DateTime currentTime = DateTime.now();

    for (Group currentGroup in activeGroups) {

      if (currentTime.weekday != currentGroup.weekday && currentGroup.weekday != -1) continue;

      String parseTime = currentTime.toUtc().toString();
      var parts = parseTime.split(" ");
      parseTime = parts[0] + " " + currentGroup.time + ".000Z";

      var groupDate = DateTime.parse(parseTime);
      var targetTime = groupDate.add(Duration(minutes: currentGroup.duration));

      if (currentTime.isAfter(groupDate) && targetTime.isAfter(currentTime)) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LessonPage(currentGroup: currentGroup),
        ));
      }

    }

  }

  Workers({this.context}) {
    _dateTime = new DateTime.now();

    initProfileData();
    provider.initData(profile.login, profile.password);

    var future = provider.getToken();

    future.then((value) {
      profile.token = provider.token;
      globals.authProvider = provider;
      checkGroups();
    });
  }
}
