import 'package:flutter/material.dart';

///--- > Drawing setting for Colors and Width <--- ///

class DrawingSettings extends ChangeNotifier {
  Color _selectedColor = Colors.black; //Initallly Color will be black
  double _strokeWidth = 5.0; //Width will be 5

  Color get selectedColor => _selectedColor;
  double get strokeWidth => _strokeWidth;

  //**Function to change Color  *//
  void setSelectedColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

//**Function to Change Stroke Width *//
  void setStrokeWidth(double width) {
    _strokeWidth = width;
    notifyListeners();
  }
}
