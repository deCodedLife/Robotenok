import 'package:flutter/material.dart';

class Notify {
  Text title;
  bool dismissible;
  Widget child;
  List<Widget> actions;
  BuildContext context;

  newUser() {
    showDialog(
        context: context,
        barrierDismissible: dismissible == null ? true : false,
        builder: (context) => SimpleDialog(
          title: title,
          children: actions,
        )
    );
  }

  show() {
    showDialog(
        context: context,
        barrierDismissible: dismissible == null ? true : false,
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
    this.context,
    this.dismissible
  });
}
