import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GroupStudents
{
  int id;
  int groupID;
  int studentID;
  
  GroupStudents({
    this.id,
    this.groupID,
    this.studentID
  });
  
  factory GroupStudents.fromJson(Map<String, dynamic> json) => new GroupStudents(
    id: json["id"],
    groupID: json["group_id"],
    studentID: json["student_id"]
  );
  
  Map<String, dynamic> toJson() => {
    "id": id,
    "group_id": groupID,
    "student_id": studentID
  };

  Future<Database> initDB() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'client.db'),
    );
    final db = await database;
    return db;
  }

  Future<List<GroupStudents>> get(int student) async {
    final db = await initDB();
    var data = await db.query("groups_students", where: "student_id = ?", whereArgs: [student]);
    return data.isNotEmpty ? data.map((s) => GroupStudents.fromJson(s)).toList() : [];
  }
  
  Future<void> add(GroupStudents data) async {
    final db = await initDB();
    await db.insert("groups_students", data.toJson());
    await db.close();
  }
  
  Future<void> clear(int student) async {
    final db = await initDB();
    await db.delete("groups_students", where: "student_id = ?", whereArgs: [student]);
    await db.close();
  }
}

class Group
{
  int id;
  String name;
  String time;
  String duration;
  int active;

  Group({
    this.id,
    this.name,
    this.time,
    this.duration,
    this.active
  });

  factory Group.fromJson(Map<String, dynamic> json) => new Group(
    id: json["id"],
    name: json["name"],
    time: json["time"],
    duration: json["duration"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "time": time,
    "duration": duration,
    "active": active
  };

  Future<Database> initDB() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'client.db'),
    );
    final db = await database;
    return db;
  }

  Future<Group> get(int id) async {
    final db = await initDB();
    var data = await db.query("groups", where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? Group.fromJson(data.first) : Null;
  }

  Future<void> create(Group group) async {
    final db = await initDB();
    await db.insert("groups", group.toJson());
    await db.close();
  }

  Future<void> update(Group group) async {
    final db = await initDB();
    await db.update("groups", group.toJson());
    await db.close();
  }

  Future<void> delete(Group group) async {
    group.active = 0;
    await update(group);
  }

}