import 'dart:async';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class Profile
{
  String name;
  String login;
  String password;
  int cash;

  Profile({
    this.name,
    this.login,
    this.password,
    this.cash
  });

  factory Profile.fromJson(Map<String, dynamic> json) => new Profile(
    name: json["name"],
    login: json["login"],
    password: json["password"],
    cash: json["cash"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "login": login,
    "password": password,
    "cash": cash
  };

  Future<Database> initDB() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'client.db'),
    );
    final db = await database;
    return db;
  }

  Future<Profile> get() async {
    final db = await initDB();
    var data = await db.query("profile");
    return data.isNotEmpty ? Profile.fromJson(data.first) : Null;
  }

  Future<void> create(Profile profile) async {
    final db = await initDB();
    await db.insert(
      "profile",
      profile.toJson()
    );
  }

  Future<void> update(Profile, profile) async {
    final db = await initDB();
    await db.update(
        "profile",
        profile.toJson()
    );
  }

  Future<void> delete(Profile profile) async {
    final db = await initDB();
    await db.execute("DELETE * FROM profile");
  }

}