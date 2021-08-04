import 'package:flutter/material.dart';

class Notify {
  Text title;
  Widget child;
  List<Widget> actions;
  BuildContext context;

  show() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: title,
          content: child,
          actions: actions,
        )
    );
  }

  Notify({
    this.title,
    this.child,
    this.actions,
    this.context
  });
}
