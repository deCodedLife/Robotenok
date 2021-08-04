// Testing imports
import 'DB/Visits.dart';
import 'DB/Costs.dart';
import 'DB/Courses.dart';
import 'DB/Groups.dart';
import 'DB/Payments.dart';
import 'DB/Profile.dart';
import 'DB/Provider.dart';
import 'DB/Students.dart';

testDB() async
{
  Student newStudent = new Student(
      name: "Руслана Даниева",
      sex: 0,
      parents: "",
      phone: "8-978-722-23-94"
  );
  Student().create(newStudent);

  GroupType newGroupType = new GroupType(
      name: "WeDo"
  );
  GroupType().add(newGroupType);

  var groupTypes = await DBStorage().getGroupsTypes();

  Group newGroup = new Group(
      name: "Среда 16:30",
      duration: 100,
      time: "16:30",
      weekday: DateTime.wednesday,
      groupType: groupTypes.first.id
  );
  Group().create(newGroup);

  Course newCourse = new Course(
      name: "Робототехника WeDo",
      lessons: 16,
      payment: 2800
  );
  Course().add(newCourse);

  var student = await DBStorage().getStudents();

  Payment newPayment = new Payment(
      time: DateTime.now().hour.toString() + ":" + DateTime.now().second.toString(),
      date: DateTime.now().day.toString() + "." + DateTime.now().month.toString() + "." + DateTime.now().year.toString(),
      type: "cash",
      credit: 2800,
      studentID: student.first.id
  );
  Payment().newPayment(newPayment);

  var couses = await DBStorage().getCourses();
  var groups = await DBStorage().getGroups();

  GroupStudent newGroupStudent = new GroupStudent(
      studentID: student.first.id,
      groupID: groups.first.id
  );
  GroupStudent().add(newGroupStudent);

  CoursesGroups newCourseGroup = new CoursesGroups(
    groupID: groups.first.id,
    courseID: couses.first.id,
  );
  CoursesGroups().add(newCourseGroup);

  Visit newVisit = new Visit(
      studentID: student.first.id,
      type: "intramural",
      time: DateTime.now().hour.toString() + ":" + DateTime.now().second.toString(),
      date: DateTime.now().day.toString() + "." + DateTime.now().month.toString() + "." + DateTime.now().year.toString()
  );
  Visit().create(newVisit);
}