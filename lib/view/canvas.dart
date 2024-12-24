// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch_app/provider/sketch_provider.dart';
import 'package:sketch_app/provider/sketch_setting.dart';

class SketchingCanvas extends StatefulWidget {
  const SketchingCanvas({Key? key}) : super(key: key);

  @override
  State<SketchingCanvas> createState() => _SketchingCanvasState();
}

/// --->>> This is The Main File Controlling Canvas using CustomPaints using Cunsumer2,DrawingSettings,
/// DrawingStateManager Providers

class _SketchingCanvasState extends State<SketchingCanvas> {
  final List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
    return Consumer2<DrawingSettings, DrawingStateManager>(
      builder: (context, drawingSettings, drawingStateManager, _) {
        return GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              _points.add(renderBox.globalToLocal(details.globalPosition));
            });
          },
          onPanEnd: (DragEndDetails details) {
            drawingStateManager.addStroke(
                List.from(_points),
                drawingSettings.selectedColor,
                drawingSettings
                    .strokeWidth); //Getting the initial color and width from provider
            _points.clear();
          },
          //Canvas will be White
          child: Container(
            color: Colors.white,
            child: CustomPaint(
              painter: SketchPainter(
                strokes: drawingStateManager
                    .strokes, //Tracking the strokes using providers
              ),
            ),
          ),
        );
      },
    );
  }
}

/// ---> Define SketchPainter class <--- ///
class SketchPainter extends CustomPainter {
  final List<Stroke> strokes;

  SketchPainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      Paint paint = Paint()
        ..color = stroke.color
        ..strokeCap = StrokeCap.round
        ..strokeWidth = stroke.strokeWidth;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        if (stroke.points[i] != null && stroke.points[i + 1] != null) {
          canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
