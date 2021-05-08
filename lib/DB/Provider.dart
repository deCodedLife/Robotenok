import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBStorage {

  final String createStudents = "CREATE TABLE IF NOT EXISTS students (id	INTEGER NOT NULL UNIQUE,name	TEXT NOT NULL,phone	TEXT NOT NULL,parents	TEXT NOT NULL,sex	INTEGER NOT NULL,PRIMARY KEY(id AUTOINCREMENT));";
  final String createPayments = "CREATE TABLE IF NOT EXISTS payments (id	INTEGER NOT NULL UNIQUE, date	TEXT NOT NULL, time	TEXT NOT NULL, student_id	INTEGER NOT NULL, credit	INTEGER NOT NULL, type	TEXT NOT NULL, FOREIGN KEY(student_id) REFERENCES students(id),PRIMARY KEY(id AUTOINCREMENT));";
  final String createCosts = "CREATE TABLE IF NOT EXISTS costs (id	INTEGER NOT NULL UNIQUE, product	TEXT NOT NULL, cost	INTEGER NOT NULL, date	TEXT NOT NULL, time	TEXT NOT NULL, PRIMARY KEY(id AUTOINCREMENT));";
  final String createVisits = "CREATE TABLE IF NOT EXISTS visits (id	INTEGER NOT NULL UNIQUE, student_id	INTEGER NOT NULL, date	TEXT NOT NULL, time	TEXT NOT NULL, type	TEXT NOT NULL, FOREIGN KEY(student_id) REFERENCES students(id),PRIMARY KEY(id AUTOINCREMENT));";
  final String createGroupTypes = "CREATE TABLE IF NOT EXISTS group_types (id	INTEGER NOT NULL UNIQUE, name	TEXT NOT NULL,PRIMARY KEY(id AUTOINCREMENT));";
  final String createGroups = "CREATE TABLE IF NOT EXISTS groups (id	INTEGER NOT NULL UNIQUE, name	TEXT NOT NULL,time	TEXT NOT NULL,duration	TEXT NOT NULL,weekday	INTEGER NOT NULL,group_type	INTEGER NOT NULL,PRIMARY KEY(id AUTOINCREMENT),FOREIGN KEY(group_type) REFERENCES group_types(id));";
  final String createGroupsStudents = "CREATE TABLE IF NOT EXISTS groups_students (id	INTEGER NOT NULL UNIQUE, group_id	INTEGER NOT NULL, student_id	INTEGER NOT NULL, PRIMARY KEY(id AUTOINCREMENT),FOREIGN KEY(group_id) REFERENCES groups(id),FOREIGN KEY(student_id) REFERENCES students(id));";
  final String createCourses = "CREATE TABLE IF NOT EXISTS courses (id	INTEGER NOT NULL UNIQUE, name	TEXT NOT NULL, payment	INTEGER NOT NULL, lessons	INTEGER NOT NULL, PRIMARY KEY(id AUTOINCREMENT));";
  final String createCoursesStudents = "CREATE TABLE IF NOT EXISTS courses_students (id	INTEGER NOT NULL UNIQUE, course_id	INTEGER NOT NULL, student_id	INTEGER NOT NULL, FOREIGN KEY(student_id) REFERENCES students(id),FOREIGN KEY(course_id) REFERENCES courses(id),PRIMARY KEY(id AUTOINCREMENT));";
  final String createProfile = "CREATE TABLE IF NOT EXISTS profile (login	TEXT NOT NULL, password	TEXT NOT NULL, cash	INTEGER NOT NULL)";

  createTables(Database db) async {
    await db.execute(createStudents);
    await db.execute(createPayments);
    await db.execute(createCosts);
    await db.execute(createVisits);
    await db.execute(createGroupTypes);
    await db.execute(createGroups);
    await db.execute(createGroupsStudents);
    await db.execute(createCourses);
    await db.execute(createCoursesStudents);
    await db.execute(createProfile);
  }

  removeTables(Database db) async {
    await db.execute("DROP TABLE students IF EXISTS");
    await db.execute("DROP TABLE payments IF EXISTS");
    await db.execute("DROP TABLE costs IF EXISTS");
    await db.execute("DROP TABLE visits IF EXISTS");
    await db.execute("DROP TABLE group_types IF EXISTS");
    await db.execute("DROP TABLE groups IF EXISTS");
    await db.execute("DROP TABLE groups_students IF EXISTS");
    await db.execute("DROP TABLE courses IF EXISTS");
    await db.execute("DROP TABLE courses_students IF EXISTS");
    await db.execute("DROP TABLE profile IF EXISTS");
  }

  Future<Database> initializeDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'client.db');

    Database database = await openDatabase(
      path,
      version: 2,

      onCreate: (db, version) async {
        await createTables(db);
      },

      onUpgrade: (db, old, current) async {
        await removeTables(db);
        await createTables(db);
      },
    );

    await database.close();
  }
}