import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ImageData
{
  int id;
  int userId;
  String date;
  String time;
  String filename;
  int active;
  String hash;

  ImageData ({
    this.id,
    this.userId,
    this.date,
    this.time,
    this.filename,
    this.active,
    this.hash
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => new ImageData(
      id: json["id"],
      userId: json["user_id"],
      date: json["date"],
      time: json["time"],
      filename: json["filename"],
      active: json["active"],
      hash: json["hash"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "date": date,
    "time": time,
    "filename": filename,
    "hash": hash
  };

  Future<Database> initDB () async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'client.db'),
    );
    return database;
  }

  Future<ImageData> get(int id) async {
    final db = await initDB();
    final data = await db.query("images", where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? ImageData.fromJson(data.first) : Null;
  }

  create(ImageData student) async {
    final db = await initDB();
    await db.insert(
      'images',
      student.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  update(ImageData student) async {
    final db = await initDB();
    await db.update(
      'images',
      student.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  remove(ImageData student) async {
    student.active = 0;
    update(student);
  }
}