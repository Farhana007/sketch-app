// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';

/// ---> This is the Download Provider to download Image in Gallery <--- ////
class CanvasImageDownload extends ChangeNotifier {
  GlobalKey? canvasKey; // Key will be global

  CanvasImageDownload({required this.canvasKey});

  Future<void> saveCanvasImage(BuildContext context) async {
    try {
      // Request storage permission using Permission Handler Package
      bool permissionGranted = await _requestPermission();

      if (permissionGranted) {
        if (canvasKey == null) {
          throw Exception("Canvas key is null.");
        }

        await Future.delayed(
            const Duration(milliseconds: 20)); // Delay for one frame

        if (canvasKey!.currentContext == null) {
          throw Exception("Canvas context is null.");
        }

        // Capture the widget as an image
        final boundary = canvasKey!.currentContext!.findRenderObject()
            as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 3.0);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

        if (byteData == null) {
          throw Exception("Failed to encode image data.");
        }

        // Convert the image to a byte array
        final imageData = byteData.buffer.asUint8List();

        // Save the image using SaverGallery package
        final result = await SaverGallery.saveImage(
          imageData,
          quality: 100,
          androidRelativePath: "DCIM/appName/images",
          fileName: "sketchAppImage",
          skipIfExists: false,
        );

        if (result.isSuccess) {
          // Showing a success SnackBar
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
          throw Exception("Failed to save image.");
        }
      } else {
        throw Exception("Storage permission denied.");
      }
    } catch (e) {
      // Showing Error SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Failed to save image: $e'),
        ),
      );
    }
  }

  Future<bool> _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
