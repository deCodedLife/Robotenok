class DataPack
{
  Map<String, dynamic> body;
  String token;

  DataPack({
    this.body,
    this.token
  });
}

class ResponcePack
{
  String status;
  Map<String, dynamic> responce;

  ResponcePack({
    this.status,
    this.responce
  });

  factory ResponcePack.fromJson( Map<String, dynamic> json ) => new ResponcePack(
    status: json["status"],
    responce: json["response"],
  );
}