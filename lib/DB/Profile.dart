import 'dart:async';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';


Profile localProfile = new Profile(
  id: 1,
  name: "Григорий Кесимин",
  login: "CodedLife",
  password: "\$wnkd.K^^ntD.",
  profileImage: "",
  type: "admin",
  cash: 0
);


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