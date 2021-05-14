import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CoursesGroups
{
    int id;
    int courseID;
    int groupID;

    CoursesGroups({
      this.id,
      this.courseID,
      this.groupID
    });

    factory CoursesGroups.fromJson(Map<String, dynamic> json) => new CoursesGroups(
      id: json["id"],
      courseID: json["course_id"],
      groupID: json["group_id"]
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "course_id": courseID,
      "group_id": groupID
    };

    Map<String, dynamic> export() => {
      "course_id": courseID,
      "group_id": groupID
    };

    Future<Database> initDB() async {
      final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'client.db'),
      );
      final db = await database;
      return db;
    }

    Future<List<CoursesGroups>> get(int group) async {
      final db = await initDB();
      var data = await db.query("courses_groups");
      return data.isNotEmpty ? data.map((c) => CoursesGroups.fromJson(c)).toList() : [];
    }

    Future<void> clear(int group) async {
      final db = await initDB();
      await db.delete("courses_groups", where: "group_id = ?", whereArgs: [groupID]);
    }

    Future<void> add(CoursesGroups data) async {
      final db = await initDB();
      await db.insert("courses_groups", data.export());
    }
}

class Course
{
  int id;
  String name;
  int payment;
  int lessons;
  int active;

  Course({
    this.id,
    this.name,
    this.payment,
    this.lessons,
    this.active
  });

  factory Course.fromJson(Map<String, dynamic> json) => new Course(
    id: json["id"],
    name: json["name"],
    payment: json["payment"],
    lessons: json["lessons"],
    active: json["active"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "payment": payment,
    "lessons": lessons,
    "active": active
  };

  Map<String, dynamic> export() => {
    "name": name,
    "payment": payment,
    "lessons": lessons
  };

  Future<Database> initDB() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'client.db'),
    );
    final db = await database;
    return db;
  }

  Future<Course> get(int id) async {
    final db = await initDB();
    var data = await db.query("courses", where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? Course.fromJson(data.first) : Null;
  }

  Future<void> add(Course course) async {
    final db = await initDB();
    await db.insert("courses", course.export());
    await db.close();
  }

  Future<void> update(Course course) async {
    final db = await initDB();
    await db.update("courses", course.toJson());
    await db.close();
  }

  Future<void> delete (Course course) async {
    course.active = 0;
    update(course);
  }

}