// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

/// ---> This is the Download Provider to download Image in Gallery <--- ////
class CanvasImageDownload extends ChangeNotifier {
  GlobalKey? canvasKey; //Key will be global

  CanvasImageDownload({required this.canvasKey});

  Future<void> saveCanvasImage(BuildContext context) async {
    try {
      // Request storage permission Using Permission Handler Package
      PermissionStatus status = await Permission.storage.request();

      // Check if permission is granted
      if (status.isGranted) {
        if (canvasKey == null) {
          throw Exception("Canvas key is null.");
        }

        await Future.delayed(
            const Duration(milliseconds: 20)); // Delay for one frame

        if (canvasKey!.currentContext == null) {
          throw Exception("Canvas context is null.");
        }

        ///bOUNDary will be the Boudnary that wnats to save as png
        final boundary = canvasKey!.currentContext!.findRenderObject()
            as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 3.0);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

        if (byteData == null) {
          throw Exception("Failed to encode image data.");
        }
        //Saving the image using ImageGallerySaver package
        final imageData = byteData.buffer.asUint8List();
        await ImageGallerySaver.saveImage(imageData);

        // Showing a success snackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(255, 2, 56, 30),
            content: Text(
              'Image saved successfully',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      } else {
        throw Exception("Storage permission denied.");
      }
    } catch (e) {
      // Showing Error snackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Failed to save image: $e'),
        ),
      );
    }
  }
}
