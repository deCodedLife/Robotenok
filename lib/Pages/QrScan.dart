import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../globals.dart' as globals;

import '../API/DataProvider.dart';
import '../API/Server.dart';

import '../DB/Profile.dart';

import 'NewStudent.dart';
import 'Notification.dart';

class QrView extends StatefulWidget {
  int choosedRole = 1;
  QrView({this.choosedRole});

  @override
  QRViewState createState() => QRViewState();
}

class QRViewState extends State<QrView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          try {controller.stopCamera(); controller.dispose();} on Exception catch (_) {
            print("Something gone wrong");
          }

          if ( result.code.isEmpty ) {

            Notify(
              title: Text("Ошибка"),
              child: Text(result.code),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                )
              ]
            ).show();

            return;
          }

          if ( widget.choosedRole == 1 ) {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => AddStudentPage(hash: result.code)
                )
            );
          }

        },
        child: Icon(Icons.camera),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          QRView(
            key: qrKey,
            overlay: QrScannerOverlayShape(
                borderColor: Theme.of(context).accentColor,
                borderLength: 20,
                borderRadius: 10,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8
            ),
            onQRViewCreated: _onQRViewCreated,
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
