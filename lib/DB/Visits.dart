import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum VisitTypes {
  intramural,
  online
}

class Visit
{
  int id;
  int studentID;
  String date;
  String time;
  String type;
  int active;

  Visit({
    this.id,
    this.studentID,
    this.date,
    this.time,
    this.type,
    this.active
  });

  VisitTypes typeFromString(String type) {
    if (type == "intramural") {
      return VisitTypes.intramural;
    }
    else if (type == "online") {
      return VisitTypes.online;
    }
    return VisitTypes.intramural;
  }

  factory Visit.fromJson(Map<String, dynamic> json) => new Visit(
    id: json["id"],
    studentID: json["student_id"],
    date: json["date"],
    time: json["time"],
    type: json["type"],
    active: json["active"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_id": studentID,
    "date": date,
    "time": time,
    "type": type,
    "active": active
  };

  Future<Database> initDB() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'client.db'),
    );
    final db = await database;
    return db;
  }

  get() async {
    final db = await initDB();
    var data = await db.query("visits", where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? Visit.fromJson(data.first) : Null;
  }

  Future<void> create(Visit visit) async {
    final db = await initDB();
    await db.insert("visits", visit.toJson());
  }

  Future<void> update(Visit visit) async {
    final db = await initDB();
    await db.update("visits", visit.toJson());
  }

  Future<void> delete(Visit visit) async {
    visit.active = 0;
    await update(visit);
  }

}