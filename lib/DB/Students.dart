import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Student
{
  int id;
  String name;
  String phone;
  String parents;
  int sex;
  int active;

  Student ({
    this.id,
    this.name,
    this.phone,
    this.parents,
    this.sex,
    this.active
  });

  factory Student.fromJson(Map<String, dynamic> json) => new Student(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    parents: json["parents"],
    sex: json["sex"],
    active: json["active"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "parents": parents,
    "sex": sex,
    "active": active
  };

  Future<Database> initDB () async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'client.db'),
    );
    return await database;
  }

  Future<Student> get(int id) async {
    final db = await initDB();
    final data = await db.query("students", where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? Student.fromJson(data.first) : Null;
  }

  create(Student student) async {
    final db = await initDB();
    await db.insert(
      'students',
      student.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await db.close();
  }

  update(Student student) async {
    final db = await initDB();
    await db.update(
      'students',
      student.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await db.close();
  }

  remove(Student student) async {
    student.active = 0;
    update(student);
  }
}