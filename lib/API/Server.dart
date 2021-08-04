import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'DataProvider.dart';
import 'Auth.dart';

class Server
{
  AuthProvider authProvider;

  Server({
    this.authProvider
  });

  Future<RespDynamic> getData(String uri, DataPack data) async {
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var response = await http.post(
      Uri.http("192.168.1.86", "robotenok/" + uri),
      headers: headers,
      body: jsonEncode(data.toJson())
    );

    if (response.statusCode != 200) {
      return RespDynamic(status: 500, body: null);
    }

    return RespDynamic.fromJson(jsonDecode(response.body));
  }

  Future<bool> checkConnection () async {
    var request = await http.get(Uri.http("192.168.1.86", "/"));
    if ( request.statusCode == 200 && request.body.length > 1 )
      return true;

    return false;
  }



}