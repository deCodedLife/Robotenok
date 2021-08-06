import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'globals.dart' as globals;

import 'DB/Profile.dart';
import 'API/Auth.dart';

import 'Pages/ProfilePage.dart';
import 'Pages/Groups.dart';
import 'Pages/Notification.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  globals.camera = cameras.first;

  await Profile().init();
  globals.profile = await Profile().get();
  globals.authProvider.initData(
      globals.profile.login,
      globals.profile.password
  );

  await globals.authProvider.getToken();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
          textTheme: TextTheme(
              button: TextStyle(color: Colors.white),
          ),
      ),
      home: AppProvider()
  ));
}

class AppProvider extends StatefulWidget {
  @override
  _AppProviderState createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  PageController _controller;
  int _currentPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      if ( globals.authProvider.token.isEmpty ) {
        Notify(
            context: context,
            dismissible: false,
            title: Text("Ошибка"),
            child: Text("Ошибка авторизации. Токен безопасности не получен"),
            actions: [
              MaterialButton(
                child: Text("Выйти"),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  SystemNavigator.pop();
                },
              )
            ]
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(globals.authProvider.token);

    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: [
          ProfilePage(),
          GroupsPage()
        ],
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}