import 'package:flutter/material.dart';

import 'Pages/ProfilePage.dart';
import 'Pages/Groups.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.light,
    theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        textTheme: TextTheme(button: TextStyle(color: Colors.white))),
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
  Widget build(BuildContext context) {
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
