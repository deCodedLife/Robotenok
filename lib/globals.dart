library robotenok.globals;

import 'package:robotenok/DB/Groups.dart';

import 'DB/Lessons.dart';
import 'API/Auth.dart';
import 'API/DataProvider.dart';

List<Lesson> lessons = [];
List<Group> groups = [];

AuthProvider authProvider = new AuthProvider();