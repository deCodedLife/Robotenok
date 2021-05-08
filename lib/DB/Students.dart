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

  Student ({
    this.id,
    this.name,
    this.phone,
    this.parents,
    this.sex
  });

  factory Student.fromJson(Map<String, dynamic> json) => new Student(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    parents: json["parents"],
    sex: json["sex"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "parents": parents,
    "sex": sex
  };

  Future<void> newStudent(Student student) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'client.db'),
    );
    final db = await database;
    await db.insert(
      'students',
      student.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}