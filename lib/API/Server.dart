import 'dart:io';

import 'package:http/http.dart' as http;
import 'Auth.dart';

class Server
{
  AuthProvider authProvider;

  Server({
    this.authProvider
  });

  Future<bool> checkConnection () async {
    var request = await http.get(Uri.https("coded.life", "docs"));
    if ( request.statusCode == 200 && request.body.length > 1 )
      return true;

    return false;
  }



}