import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../provider/sketch_setting.dart';

/// ---> This is the Function to change Stroke width Size using Slider <--- ///
showStrokeWidthBottomSheet(BuildContext context) {
  /// ---> Creating the Instance of DrawingSettings Provider <--- ///
  final drawingSettings = Provider.of<DrawingSettings>(context, listen: false);

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Change Stroke Width".text.size(15).make(),
            const SizedBox(height: 20),
            StatefulBuilder(
              builder: (context, setState) {
                return Slider(
                  //**Slider *//
                  value: drawingSettings.strokeWidth,
                  min: 1,
                  max: 11,
                  divisions: 10,
                  onChanged: (double value) {
                    setState(() {
                      drawingSettings.setStrokeWidth(
                          value); //Called the Function from provider
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: "OK"
                  .text
                  .white
                  .makeCentered()
                  .box
                  .size(100, 30)
                  .roundedSM
                  .shadowSm
                  .black
                  .makeCentered(),
            ),
          ],
        ),
      );
    },
  );
}
