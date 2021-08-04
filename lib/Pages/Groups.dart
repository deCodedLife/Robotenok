import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Group.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  List<int> selectedTiles = [];


  Widget GroupTile(BuildContext context, int index) {
    bool _isSelected = false;

    for (int tile in selectedTiles) {
      if (index == tile) {
        _isSelected = true;
      }
    }

    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          if (_isSelected) {
            selectedTiles.remove(index);
          } else {
            selectedTiles.add(index);
          }
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _isSelected ? Theme.of(context).accentColor : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Text(
            "Lego Mindstorms",
            style: TextStyle(
              color: _isSelected ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Widget GroupCard(BuildContext context, int index) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupPage()));
        },
        child: Stack(
          fit: StackFit.loose,
          children: [
            BackgroundImage(),
            Container(
              width: double.infinity,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Name(),
                  Payment()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Группы",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add, color: Colors.black),
          )
        ],
      ),
      body: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity, maxHeight: 64),
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => GroupTile(context, index),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) => GroupCard(context, index),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class Name extends StatelessWidget {
  const Name({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        "Суббота 10:00",
        style: TextStyle(
          fontSize: 26,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
    );
  }
}

class Payment extends StatelessWidget {
  const Payment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.monetization_on,
          color: Colors.white,
        ),
        Text(
          "2800",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Container(
        color: Color.fromARGB(100, 0, 0, 0),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/bg_wedo.jpg"),
            fit: BoxFit.fitWidth
        ),
      ),
    );
  }
}
