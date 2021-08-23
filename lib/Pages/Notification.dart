import 'package:flutter/material.dart';

class Notifications {

  BuildContext context;
  Notifications({this.context});

  serverError() {
    Notify(
        context: context,
        title: Text("Ошибка"),
        child: Text("Сервер недоступен"),
        actions: [MaterialButton(child: Text("Ок"), onPressed: () {Navigator.of(context).pop();})]
    ).show();
  }

  customError(String error) {
    Notify(
        context: context,
        title: Text("Ошибка"),
        child: Text(error),
        actions: [MaterialButton(child: Text("Ок"), onPressed: () {Navigator.of(context).pop();})]
    ).show();
  }

}

class Notify {
  Text title;
  bool dismissible;
  Widget child;
  List<Widget> actions;
  BuildContext context;

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
