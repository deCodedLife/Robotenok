import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum Types {
  cash,
  e_pay
}

class Payment {

  final _Types = [
    "cash",
    "e-pay"
  ];

  int id;
  String date;
  String time;
  int studentID;
  int credit;
  String type;
  int active;

  Payment({
    this.id,
    this.date,
    this.time,
    this.studentID,
    this.credit,
    this.type,
    this.active
  });

  factory Payment.fromJson(Map<String, dynamic> json) => new Payment(
    id: json["id"],
    date: json["date"],
    time: json["time"],
    studentID: json["student_id"],
    credit: json["credit"],
    type: json["type"],
    active: json["active"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "time": time,
    "student_id": studentID,
    "credit": credit,
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

  Future<void> newPayment(Payment payment) async {
    final db = await initDB();
    await db.insert(
      "payments",
      payment.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> update(Payment payment) async {
    final db = await initDB();
    await db.update(
        "payments",
        payment.toJson()
    );
  }

  Future<void> deletePayment(Payment payment) async {
    payment.active = 0;
    await update(payment);
  }

  getPayment(int id) async {
    final db = await initDB();
    var data = await db.query("payments", where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? Payment.fromJson(data.first) : Null;
  }
}