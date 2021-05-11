import 'dart:convert';

import '../DB/Profile.dart';

import 'DataProvider.dart';

import 'package:http/http.dart' as http;

class AuthData
{
  String login;
  String hash;

  AuthData({
    this.login,
    this.hash
  });

  String generateHash(String password) {
    hash = password.toUpperCase();
  }

  Map<String, dynamic> toJson() => {
    "login": login,
    "hash": hash
  };
}

class AuthProvider
{
  AuthData data;
  String token;

  AuthProvider({
    this.data,
    this.token
  });
  
  initData( String login, String password ) {
    data = AuthData(
      login: login,
      hash: AuthData().generateHash(password)
    );
  }

  getToken () async {
    var responce = await http.post( Uri.http("95.142.40.58", "robotenok/auth"), body: data.toJson() );

    token = "";

    if ( responce.statusCode == 200 && responce.body.length > 1 ) {

      ResponcePack json = ResponcePack.fromJson(jsonDecode(responce.body));
      token = json.responce["body"].toString();

    }

  }
}