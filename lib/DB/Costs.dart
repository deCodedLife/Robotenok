import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Cost
{
  int id;
  String product;
  int cost;
  String date;
  String time;
  int active;

  Cost({
    this.id,
    this.product,
    this.cost,
    this.date,
    this.time,
    this.active
  });

  factory Cost.fromJson(Map<String, dynamic> json) => new Cost(
    id: json["id"],
    product: json["product"],
    cost: json["cost"],
    date: json["date"],
    time: json["time"],
    active: json["active"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product,
    "cost": cost,
    "date": date,
    "time": time,
    "active": active
  };

  Map<String, dynamic> export() => {
    "product": product,
    "cost": cost,
    "date": date,
    "time": time
  };

  Future<Database> initDB() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'client.db'),
    );
    final db = await database;
    return db;
  }

  Future<Cost> get(int id) async {
    final db = await initDB();
    var data = await db.query("costs", where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? Cost.fromJson(data.first) : Null;
  }

  Future<void> add(Cost cost) async {
    final db = await initDB();
    await db.insert("costs", cost.export());
    await db.close();
  }

  Future<void> update(Cost cost) async {
    final db = await initDB();
    await db.update("costs", cost.toJson());
    await db.close();
  }

  Future<void> delete(Cost cost) async {
    cost.active = 0;
    update(cost);
  }
}