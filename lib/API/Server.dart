import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'DataProvider.dart';

class Server
{
  // final serverUri = "192.168.1.86";
  final serverUri = "192.168.1.13";

  Future<http.Response> getData(String uri, Map<String, dynamic> data) async {
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var response = await http.post(
      Uri.http(serverUri, "robotenok/" + uri),
      headers: headers,
      body: jsonEncode(data)
    );

    return response;
  }

  Future<http.Response> postImage(String uri, String path) async {
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var response = await http.post(
        Uri.http(serverUri, "robotenok/" + uri),
        headers: headers,
        body: await File.fromUri(Uri.parse(path)).readAsBytes()
    );

    return response;
  }

  Future<bool> checkConnection () async {
    var request = await http.get(Uri.http(serverUri, "/"));
    if ( request.statusCode == 200 && request.body.length > 1 )
      return true;

    return false;
  }



}