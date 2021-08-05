import 'dart:async';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class Profile
{
  int id;
  String name;
  String login;
  String password;
  String profileImage;
  String type;
  int cash;

  String token;

  Profile({
    this.id,
    this.name,
    this.login,
    this.password,
    this.profileImage,
    this.type,
    this.cash,
    this.token
  });

  Future init() async {
    var db = await initDB();
    await db.execute("CREATE TABLE IF NOT EXISTS profile (id	INTEGER NOT NULL, name	TEXT NOT NULL, login	TEXT NOT NULL, password	TEXT NOT NULL, image	TEXT NOT NULL, type	TEXT NOT NULL, cash	INTEGER NOT NULL);");
  }

  factory Profile.fromJson(Map<String, dynamic> json) => new Profile(
    id: json["id"],
    name: json["name"],
    login: json["login"],
    password: json["password"],
    profileImage: json["image"],
    type: json["type"],
    cash: json["cash"],
    token: json["secret"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "login": login,
    "password": password,
    "image": profileImage,
    "type": type,
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
    return data.isNotEmpty ? Profile.fromJson(data.first) : null;
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