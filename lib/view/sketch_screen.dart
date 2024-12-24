import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch_app/provider/download_provider.dart';
import 'package:sketch_app/view/canvas.dart';
import 'package:velocity_x/velocity_x.dart';
import '../provider/sketch_provider.dart';
import '../utils/color_change_bottom_sheet.dart';
import '../utils/width_change_bottom_sheet.dart';

///@Description:This screen Contains The UI of the app ,
///@param:Theres is no parameters fro this screen
///@function:There are Buttons for Undo, Redo, Clear Canvas, Color Choosing,Width Changing,Download
///Provider as StateMangement

class SketchScreen extends StatelessWidget {
  const SketchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Height and Widht variable
    double heightCount = MediaQuery.of(context).size.height;
    double widthCount = MediaQuery.of(context).size.width;
    //--->Creating the Instance of Provider to call the functions <--- ///
    final drawingManager =
        Provider.of<DrawingStateManager>(context, listen: false);

    final canvasImageDownload = Provider.of<CanvasImageDownload>(context);

    /// --->Scaffold StartS here <--- ///
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: "Sketch your thought out".text.white.make()), //Title
                10.heightBox,
                // --> This Row Contains two part, one contains buttons for cuntion, and another one is canvas <--//
                Row(
                  children: [
                    // --->First Part of the Row <---///
                    Column(
                      children: [
                        /**Button to Undo */
                        IconButton(
                            onPressed: () {
                              drawingManager.undo();
                            },
                            icon: const Icon(
                              Icons.undo,
                              size: 30,
                              color: Colors.white,
                            )),

                        /**Button to Redo */
                        IconButton(
                            onPressed: () {
                              drawingManager.redo();
                            },
                            icon: const Icon(
                              Icons.redo,
                              size: 30,
                              color: Colors.white,
                            )),

                        /**Button to Clear Canvas */
                        IconButton(
                            onPressed: () {
                              drawingManager.clearCanvas();
                            },
                            icon: const Icon(
                              CupertinoIcons.clear_circled,
                              size: 30,
                              color: Colors.white,
                            )),

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
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.white,
                            )),
                        const Spacer(),
                        /**Button to Downlaod Option*/
                        IconButton(
                            onPressed: () {
                              canvasImageDownload.saveCanvasImage(context);
                            },
                            icon: const Icon(
                              Icons.download,
                              size: 40,
                              color: Colors.redAccent,
                            )),
                        20.heightBox,
                      ],
                    )
                        .box
                        .size(widthCount * 0.27, heightCount * 0.9)
                        .color(const Color.fromARGB(255, 67, 47, 131))
                        .border(
                            color: const Color.fromARGB(255, 49, 4, 63),
                            width: 2)
                        .make(),

                    /// ---> Second part of the Row , THis is the canvas <--- ///
                    Consumer<CanvasImageDownload>(
                      builder: (context, canvasProvider, _) => RepaintBoundary(
                        key: canvasProvider.canvasKey,
                        child: const SketchingCanvas()
                            .box
                            .size(widthCount * 0.67, heightCount * 0.9)
                            .white
                            .border(
                                color: const Color.fromARGB(255, 69, 21, 5),
                                width: 2)
                            .make(),
                      ),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
