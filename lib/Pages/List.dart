import 'package:flutter/material.dart';

List<Widget> MoneyTiles = [
  Align(
    alignment: Alignment.center,
    child: Text("01.09.2021", style: TextStyle(color: Colors.grey)),
  ),
  ListTile(
    leading: Icon(Icons.account_balance_wallet),
    title: Text("Оплата занятий"),
    subtitle: Text("2800"),
  ),
  Align(
    alignment: Alignment.center,
    child: Text("29.08.2021", style: TextStyle(color: Colors.grey)),
  ),
  ListTile(
    leading: Icon(Icons.account_balance_wallet),
    title: Text("Оплата занятий"),
    subtitle: Text("3600"),
  )
];

class ListPage extends StatelessWidget {
  Text title;
  List<Widget> tiles;

  ListPage({
    this.title,
    this.tiles
  });

  Widget tileBuilder(BuildContext context, int index) {
    return tiles.elementAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
        ),
        title: title,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tiles.length,
              itemBuilder: (context, index) => tileBuilder(context, index),
            ),
          )
        ],
      ),
    );
  }
}
