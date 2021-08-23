import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Student
{
  int id;
  String name;
  String age;
  String phone;
  String parents;
  int sex;
  int active;
  int image;

  Student ({
    this.id,
    this.name,
    this.age,
    this.phone,
    this.parents,
    this.sex,
    this.active,
    this.image
  });

  factory Student.fromJson(Map<String, dynamic> json) => new Student(
    id: json["id"],
    name: json["name"],
    age: json["age"],
    phone: json["phone"],
    parents: json["parents"],
    sex: json["sex"],
    active: json["active"],
    image: json["image"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "age": age,
    "phone": phone,
    "parents": parents,
    "sex": sex,
    "active": active,
    "image": image
  };

  Map<String, dynamic> export() => {
    "name": name,
    "phone": phone,
    "parents": parents,
    "sex": sex
  };

  Future<Database> initDB () async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'client.db'),
    );
    return database;
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
      student.export(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  update(Student student) async {
    final db = await initDB();
    await db.update(
      'students',
      student.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  remove(Student student) async {
    student.active = 0;
    update(student);
  }
}