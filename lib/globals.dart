library robotenok.globals;

import 'package:robotenok/DB/Groups.dart';

import 'DB/Lessons.dart';
import 'DB/Profile.dart';

import 'API/Auth.dart';
import 'API/DataProvider.dart';

List<Lesson> lessons = [];
List<Group> groups = [];
List<GroupType> groupTypes = [];

AuthProvider authProvider = new AuthProvider();
Profile profile = new Profile();