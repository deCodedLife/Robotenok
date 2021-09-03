import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:robotenok/Pages/Notification.dart';
import 'package:robotenok/Pages/QrScan.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  int _choosedRole = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "Роботёнок",
                        style: TextStyle(
                            fontSize: Theme.of(context).textTheme.headline4.fontSize
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      title: Text("Посетитель"),
                      leading: Radio(
                        value: 0,
                        groupValue: _choosedRole,
                        onChanged: (value) {
                          setState(() {
                            _choosedRole = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text("Клиент"),
                      leading: Radio(
                        value: 1,
                        groupValue: _choosedRole,
                        onChanged: (value) {
                          setState(() {
                            _choosedRole = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text("Преподпватель"),
                      leading: Radio(
                        value: 2,
                        groupValue: _choosedRole,
                        onChanged: (value) {
                          setState(() {
                            _choosedRole = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 1.5,
                      onPressed: () {
                        if ( _choosedRole == 0 ) {
                          Notify(
                            title: Text("Ошибка"),
                            child: Text("Временно не работает"),
                            actions: [
                              MaterialButton(
                                child: Text("Ок", style: TextStyle(color: Colors.white),),
                                color: Theme.of(context).accentColor,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                            context: context
                          ).show();
                        }

                        if ( _choosedRole == 1 ) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => QrView(choosedRole: _choosedRole))
                          );
                        }


                      },
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Продолжить",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("assets/logo.jpg"),
                                fit: BoxFit.fitHeight
                            )
                        )
                      ),
                      Container(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        child: Center(
                          child: Text(
                            "Ознакомление",
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.headline4.fontSize,
                              color: Colors.white
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/client.jpg"),
                              fit: BoxFit.fitWidth
                          )
                        ),
                      ),
                      Container(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        child: Center(
                          child: Text(
                            "Клиент",
                            style: TextStyle(
                                fontSize: Theme.of(context).textTheme.headline4.fontSize,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/teacher.jpg"),
                            fit: BoxFit.fitWidth
                          )
                        ),
                      ),
                      Container(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        child: Center(
                          child: Text(
                            "Преподаватель",
                            style: TextStyle(
                                fontSize: Theme.of(context).textTheme.headline4.fontSize,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
