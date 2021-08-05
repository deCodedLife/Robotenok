import 'dart:convert';

import '../DB/Profile.dart';

import 'DataProvider.dart';
import 'Server.dart';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class AuthData
{
  String login;
  String hash;

  AuthData({
    this.login,
    this.hash
  });

  String generateHash(String password) {
    return  sha512.convert( utf8.encode(password) ).toString();
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

  Future<void> getToken () async {
    token = "";
    var response = await Server().getData("auth", data.toJson());

    if ( response.statusCode == 200 && response.body.length > 1 ) {
      RespString json = RespString.fromJson(jsonDecode(response.body));
      token = json.response;
    }
  }
}