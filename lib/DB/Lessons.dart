class Lesson {
  int ID;
  int Active;
  int UserID;
  int GroupID;
  String Date;
  String Time;
  String HostAddress;

  Lesson({
    this.ID,
    this.Active,
    this.UserID,
    this.GroupID,
    this.Date,
    this.Time,
    this.HostAddress
  });

  factory Lesson.fromJson (Map<String, dynamic> json) => Lesson(
    ID: json["id"],
    Active: json["active"],
    UserID: json["user_id"],
    GroupID: json["group_id"],
    Date: json["date"],
    Time: json["time"],
    HostAddress: json["host_address"]
  );

  Map<String, dynamic> toJson () => {
    "id": ID,
    "active": Active,
    "user_id": UserID,
    "group_id": GroupID,
    "date": Date,
    "time": Time,
    "host_address": HostAddress
  };
}

