import 'package:flutter/material.dart';
import '../globals.dart' as globals;

import 'List.dart';
import 'Notification.dart';
import '../DB/Costs.dart';

List<ListTile> events = [
  ListTile(
    minVerticalPadding: 10,
    tileColor: Colors.white,
    leading: Icon(Icons.monetization_on),
    title: Text("Зачислено 15000 на карту"),
  ),
  ListTile(
    minVerticalPadding: 10,
    tileColor: Colors.white,
    leading: Icon(Icons.assistant_photo),
    title: Text("Проведен урок 28.07.2021"),
  ),
];

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Widget> data = [];

  Widget stats(BuildContext context, int index) {
    return data.elementAt(index);
  }
  
  Widget eventTile(BuildContext context, int index) {
    return events.elementAt(index);
  }

  @override
  Widget build(BuildContext context) {
    data = [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ListPage(
                title: Text("Доходы", style: TextStyle(color: Colors.black)),
                tiles: MoneyTiles,
              )
          ));
        },
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance_wallet, size: 32,),
              Text("${globals.profile.cash}", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {

        },
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.monetization_on, size: 32),
              Text("1550", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {

        },
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.assistant_photo),
              Text("${globals.lessons.length}",
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {

        },
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.notification_important),
              Text("0", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      )
    ];

    setState(() {});

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: Container(
          margin: EdgeInsets.only(left: 25, top: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            image: DecorationImage(
                image: AssetImage("assets/logo.jpg"),
                fit: BoxFit.fitHeight
            )
          ),
        ),
        title: Text(
          globals.profile.name,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Notify(
                context: context,
                title: Text("Временно не работает"),
                child: Text("Если Вам требуется редактировать данные профиля - обращайтесь к администратору"),
                actions: [
                  MaterialButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]
              ).show();
            },
            icon: Icon(Icons.edit, color: Colors.black,),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(15),
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => stats(context, index),
            ),
          ),
          SizedBox(height: 25),
          Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Последние действия",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) => eventTile(context, index),
            ),
          )
        ],
      ),
    );
  }
}
