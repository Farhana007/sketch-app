import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch_app/view/canvas.dart';
import 'package:velocity_x/velocity_x.dart';

import '../provider/download_provider.dart';
import '../provider/sketch_provider.dart';
import '../utils/color_change_bottom_sheet.dart';
import '../utils/width_change_bottom_sheet.dart';

class NewSketchScreen extends StatelessWidget {
  const NewSketchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Height and Widht variable
    double heightCount = MediaQuery.of(context).size.height;
    double widthCount = MediaQuery.of(context).size.width;
    //--->Creating the Instance of Provider to call the functions <--- ///
    final drawingManager =
        Provider.of<DrawingStateManager>(context, listen: false);

    final canvasImageDownload = Provider.of<CanvasImageDownload>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ''.text.make(),
                  /**Button to Clear Canvas */
                  IconButton(
                      onPressed: () {
                        drawingManager.clearCanvas();
                      },
                      icon: const Icon(
                        CupertinoIcons.clear_circled,
                        size: 30,
                        color: Color.fromARGB(255, 135, 38, 19),
                      )),
                  "Sketch Mind".text.size(25).semiBold.color(blackIsh).make(),
                  /**Button to Undo */
                  IconButton(
                      onPressed: () {
                        drawingManager.undo();
                      },
                      icon: const Icon(
                        Icons.undo,
                        size: 40,
                        color: Color.fromARGB(255, 253, 48, 2),
                      )),

                  /**Button to Redo */
                  IconButton(
                      onPressed: () {
                        drawingManager.redo();
                      },
                      icon: const Icon(
                        Icons.redo,
                        size: 40,
                        color: Color.fromARGB(255, 28, 93, 79),
                      )),
                ],
              ),
            ).box.size(double.infinity, 80).white.make(),
            Row(
              children: [
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      /**Button to Showing Color chosing Dialog*/
                      IconButton(
                          onPressed: () {
                            showColorPickerBottomSheet(context);
                          },
                          icon: const Icon(
                            Icons.color_lens_rounded,
                            size: 30,
                            color: Colors.white,
                          )),

                      /**Button to Showing  width chossing dialog*/
                      IconButton(
                          onPressed: () {
                            showStrokeWidthBottomSheet(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.pencil,
                            size: 30,
                            color: Colors.white,
                          )),
                    ],
                  ),
                )
                    .box
                    .size(70, 150)
                    .color(blackIsh)
                    .shadowSm
                    .rightRounded(value: 20)
                    .make(),

                /// ---> Second part of the Row , THis is the canvas <--- ///
                Consumer<CanvasImageDownload>(
                  builder: (context, canvasProvider, _) => RepaintBoundary(
                    key: canvasProvider.canvasKey,
                    child: const SketchingCanvas()
                        .box
                        .size(widthCount * 0.75, heightCount * 0.7)
                        .white
                        .make(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          canvasImageDownload.saveCanvasImage(context);
        },
        child: const Icon(
          Icons.download,
          size: 30,
          color: Color.fromARGB(255, 10, 57, 97),
        ),
      ),
    );
  }
}

const blackIsh = Color.fromARGB(255, 32, 7, 47);
