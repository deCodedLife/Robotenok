class DataPack
{
  Map<String, dynamic> body;
  String token;

  DataPack({
    this.body,
    this.token
  });

  Map<String, dynamic> toJson() => {
    "token": token,
    "body": body
  };

}

class RespString
{
  int status;
  String response;

  RespString({
    this.status,
    this.response
  });

  factory RespString.fromJson( Map<String, dynamic> json ) => new RespString(
    status: json["status"],
    response: json["response"],
  );
}

class RespDynamic
{
  int status;
  List<dynamic> body;

  RespDynamic({
    this.status,
    this.body
  });

  Map<String, dynamic> toJson() => {
    "status": status,
    "response": body
  };

  factory RespDynamic.fromJson( Map<String, dynamic> json ) => new RespDynamic(
    status: json["status"],
    body: json["response"],
  );
}

class SingleResp {
  int status;
  dynamic body;

  SingleResp({
    this.status,
    this.body
  });

  Map<String, dynamic> toJson() => {
    "status": status,
    "response": body
  };

  factory SingleResp.fromJson( Map<String, dynamic> json ) => new SingleResp(
    status: json["status"],
    body: json["response"],
  );
}

class Device
{
  int id;
  String hash;
  int active;

  Device({this.id, this.hash, this.active});

  Map<String, dynamic> toJson() => {
    "id": id,
    "hash": hash,
    "active": active
  };

  factory Device.fromJson( Map<String, dynamic> json ) => new Device(
    id: json["id"],
    hash: json["hash"],
    active: json["active"]
  );
}