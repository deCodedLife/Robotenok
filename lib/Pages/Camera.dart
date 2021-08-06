import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:robotenok/API/DataProvider.dart';

import 'Notification.dart';
import '../DB/Image.dart';
import '../API/Server.dart';
import '../globals.dart' as globals;

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      globals.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: CameraPreview(_controller),
            );
            // return Transform.scale(
            //   scale: _controller.value.aspectRatio / deviceRatio,
            //   child: Center(
            //     child: AspectRatio(
            //       aspectRatio: _controller.value.aspectRatio,
            //       child: CameraPreview(_controller),
            //     ),
            //   ),
            // );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final dynamic imagePath;

  DisplayPictureScreen({this.imagePath});

  @override
  Widget build(BuildContext context) {
    // Server().postImage("uploads/uqj2z2vik007ya8kh95c3324n648hj00n1927q91vl", imagePath);

    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          ImageData newImage = ImageData(
            userId: globals.profile.id
          );
          DataPack request = DataPack(
            token: globals.authProvider.token,
            body: newImage.toJson()
          );

          var response = await Server().getData("image", request.toJson());

          if ( response.statusCode != 200 ) {
            Notify(
              title: Text("Ошибка"),
              child: Text("Сервер не доступен")
            ).show();

            return;
          }

          RespDynamic content = RespDynamic.fromJson(jsonDecode(response.body));

          if ( content.status != 200 ) {
            Notify(
                title: Text("Ошибка"),
                child: Text(content.body.toString())
            ).show();

            return;
          }
          
          newImage = ImageData.fromJson( List<Map<String, dynamic>>.from(content.body)[0] );
          response = await Server().postImage("uploads/" + newImage.hash, imagePath);

          if ( response.statusCode != 200 ) {
            Notify(
                title: Text("Ошибка"),
                child: Text("Сервер не доступен")
            ).show();

            return;
          }

          content = RespDynamic.fromJson(jsonDecode(response.body));

          if ( content.status != 200 ) {
            Notify(
                title: Text("Ошибка"),
                child: Text(content.body.toString())
            ).show();

            return;
          }

          Navigator.of(context).pop();
        },
      ),
    );
  }
}