import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../provider/sketch_setting.dart';

/// ---> This is the Function to Change Color of Strokes <---

showColorPickerBottomSheet(BuildContext context) {
  /// ---> Creating the instance of Drawing Setting Provider <--- ///
  final drawingSettings = Provider.of<DrawingSettings>(context, listen: false);

  // Color List //
  final List<Color> colorOptions = [
    const Color.fromARGB(255, 106, 14, 8),
    const Color.fromARGB(255, 57, 154, 60),
    const Color.fromARGB(255, 4, 15, 24),
    const Color.fromARGB(255, 240, 118, 4),
    const Color.fromARGB(255, 45, 30, 49),
    const Color.fromARGB(255, 214, 70, 70),
    const Color.fromARGB(255, 69, 68, 68),
    const Color.fromARGB(255, 55, 0, 0),
    const Color.fromARGB(255, 200, 66, 57),
    const Color.fromARGB(255, 18, 106, 21),
    const Color.fromARGB(255, 19, 32, 43),
    const Color.fromARGB(255, 255, 154, 59),
    const Color.fromARGB(255, 121, 14, 148),
    const Color.fromARGB(255, 176, 39, 39),
    Colors.black,
    Colors.white,
  ];

  /// SHowing Bottom Sheet with the colors option , tapping on the color will change stroke color ///
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 150,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Select Color",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var color in colorOptions)
                    InkWell(
                      onTap: () {
                        drawingSettings.setSelectedColor(color);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container()
                            .box
                            .size(50, 50)
                            .roundedFull
                            .color(color)
                            .make(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
