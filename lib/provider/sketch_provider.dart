import 'package:flutter/material.dart';

/// ---> This file contains the Function to draw the sketch,
/// Function : Undo, Redo, List of Strokes, Undone Strokes, Clear the Canvas , Changing color and width of stroke
///  <----

class DrawingStateManager extends ChangeNotifier {
  final List<Stroke> _strokes = []; //List of Strokes
  final List<Stroke> _undoneStrokes =
      []; //Tracking the undone Strokes to perform redo, undo and clearing canvas function
  int _currentIndex = -1; //Currenct index is -1 means empty canvas

  List<Stroke> get strokes => _strokes;
  int get currentIndex => _currentIndex;

  //**Function of Adding Stronkes to _strokes list *///
  void addStroke(List<Offset> newStroke, Color color, double strokeWidth) {
    _strokes
        .add(Stroke(points: newStroke, color: color, strokeWidth: strokeWidth));
    _undoneStrokes.clear();
    _currentIndex = _strokes.length - 1;
    notifyListeners();
  }

  //**Function to undo any stroke *//
  void undo() {
    if (_currentIndex >= 0) {
      _undoneStrokes.add(_strokes.removeLast());
      _currentIndex--;
      notifyListeners();
    }
  }

  //**Function to redo the undo stroke *//
  void redo() {
    if (_undoneStrokes.isNotEmpty) {
      _strokes.add(_undoneStrokes.removeLast());
      _currentIndex++;
      notifyListeners();
    }
  }

//**Function to Clearing the Canvas */
  void clearCanvas() {
    _strokes.clear();
    _undoneStrokes.clear();
    _currentIndex = -1;
    notifyListeners();
  }
}

//**Stroke class to track strok color  point and width *//
class Stroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  Stroke(
      {required this.points, required this.color, required this.strokeWidth});
}
