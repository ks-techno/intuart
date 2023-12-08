import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:final_app/view/drawing_canvas/models/drawing_mode.dart';
import 'package:final_app/view/drawing_canvas/models/sketch.dart';
import 'package:final_app/view/drawing_canvas/widgets/color_palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import '../../../features/home/controller/home_controller.dart';
import '../../../utils/app_colors.dart';

class CanvasSideBar extends HookWidget {
  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<double> strokeSize;
  final ValueNotifier<double> eraserSize;
  final ValueNotifier<DrawingMode> drawingMode;
  final ValueNotifier<Sketch?> currentSketch;
  final ValueNotifier<List<Sketch>> allSketches;
  final GlobalKey canvasGlobalKey;
  final ValueNotifier<bool> filled;
  final ValueNotifier<int> polygonSides;
  final ValueNotifier<ui.Image?> backgroundImage;
  final ValueNotifier<int> selectedLeftMenu;

  const CanvasSideBar({
    Key? key,
    required this.selectedColor,
    required this.strokeSize,
    required this.eraserSize,
    required this.drawingMode,
    required this.currentSketch,
    required this.allSketches,
    required this.canvasGlobalKey,
    required this.filled,
    required this.polygonSides,
    required this.backgroundImage,
    required this.selectedLeftMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final undoRedoStack = useState(_UndoRedoStack(
      sketchesNotifier: allSketches,
      currentSketchNotifier: currentSketch,
    ));
    final scrollController = useScrollController();
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.015,
      ),
      width: MediaQuery.of(context).size.width * 0.35,
      // height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        // color: AppColors.fillColor,
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 3,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      // child: Scrollbar(
      //   controller: scrollController,
      //   thumbVisibility: true,
      //   trackVisibility: false,
      child: Obx(() {
        final selectedMenu = homeController.selectedLeftMenu.value;

        switch (selectedMenu) {
          case 0:
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shapes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const Divider(),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      _IconBox(
                        iconData: FontAwesomeIcons.pencil,
                        selected: drawingMode.value == DrawingMode.pencil,
                        onTap: () => drawingMode.value = DrawingMode.pencil,
                        tooltip: 'Pencil',
                      ),
                      _IconBox(
                        selected: drawingMode.value == DrawingMode.line,
                        onTap: () => drawingMode.value = DrawingMode.line,
                        tooltip: 'Line',
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 22,
                              height: 2,
                              color: drawingMode.value == DrawingMode.line
                                  ? Colors.grey[900]
                                  : Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      _IconBox(
                        iconData: Icons.hexagon_outlined,
                        selected: drawingMode.value == DrawingMode.polygon,
                        onTap: () => drawingMode.value = DrawingMode.polygon,
                        tooltip: 'Polygon',
                      ),
                      _IconBox(
                        iconData: FontAwesomeIcons.eraser,
                        selected: drawingMode.value == DrawingMode.eraser,
                        onTap: () => drawingMode.value = DrawingMode.eraser,
                        tooltip: 'Eraser',
                      ),
                      _IconBox(
                        iconData: FontAwesomeIcons.square,
                        selected: drawingMode.value == DrawingMode.square,
                        onTap: () => drawingMode.value = DrawingMode.square,
                        tooltip: 'Square',
                      ),
                      _IconBox(
                        iconData: FontAwesomeIcons.circle,
                        selected: drawingMode.value == DrawingMode.circle,
                        onTap: () => drawingMode.value = DrawingMode.circle,
                        tooltip: 'Circle',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Fill Shape: ',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      Checkbox(
                        value: filled.value,
                        onChanged: (val) {
                          filled.value = val ?? false;
                        },
                      ),
                    ],
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    child: drawingMode.value == DrawingMode.polygon
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Polygon Sides: ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              Slider(
                                value: polygonSides.value.toDouble(),
                                min: 3,
                                max: 8,
                                onChanged: (val) {
                                  polygonSides.value = val.toInt();
                                },
                                label: '${polygonSides.value}',
                                divisions: 5,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            );
          case 1:
            return Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Colors',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const Divider(),
                  ColorPalette(
                    selectedColor: selectedColor,
                  ),
                ],
              ),
            );
          case 2:
            return
                //  const SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Size',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: TextButton(
                                child: const Text('Stroke Size:'),
                                onPressed: () async {},
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: strokeSize.value,
                                min: 0,
                                max: 50,
                                onChanged: (val) {
                                  strokeSize.value = val;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: TextButton(
                                child: const Text('Eraser Size'),
                                onPressed: () async {},
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: eraserSize.value,
                                min: 0,
                                max: 80,
                                onChanged: (val) {
                                  eraserSize.value = val;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));

          case 3:
            return
                //  const SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Actions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const Divider(),
                        Wrap(
                          children: [
                            TextButton(
                              onPressed: allSketches.value.isNotEmpty
                                  ? () => undoRedoStack.value.undo()
                                  : null,
                              child: const Text('Undo'),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: undoRedoStack.value._canRedo,
                              builder: (_, canRedo, __) {
                                return TextButton(
                                  onPressed: canRedo
                                      ? () => undoRedoStack.value.redo()
                                      : null,
                                  child: const Text('Redo'),
                                );
                              },
                            ),
                            TextButton(
                              child: const Text('Clear'),
                              onPressed: () => undoRedoStack.value.clear(),
                            ),
                            // TextButton(
                            //   onPressed: () async {
                            //     if (backgroundImage.value != null) {
                            //       backgroundImage.value = null;
                            //     } else {
                            //       backgroundImage.value = await _getImage;
                            //       print("Image that am getting ${ backgroundImage.value.toString()}");
                            //     }
                            //   },
                            //   child: Text(
                            //     backgroundImage.value == null
                            //         ? 'Add Background'
                            //         : 'Remove Background',
                            //   ),
                            // ),
                            // TextButton(
                            //   child: const Text('Fork on Github'),
                            //   onPressed: () => _launchUrl(kGithubRepo),
                            // ),
                          ],
                        ),
                      ],
                    ));
          case 4:
            return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Export',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: TextButton(
                            child: const Text('Export PNG'),
                            onPressed: () async {
                              Uint8List? pngBytes = await getBytes();

                              if (pngBytes != null) saveFile(pngBytes, 'png');
                            },
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: TextButton(
                            child: const Text('Export JPEG'),
                            onPressed: () async {
                              Uint8List? pngBytes = await getBytes();
                              if (pngBytes != null) saveFile(pngBytes, 'jpeg');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ));

          // add about me button or follow buttons
          // const Divider(),

          default:
            return SizedBox();
        }
      }),
      //  ListView(
      //   padding: const EdgeInsets.all(10.0),
      //   controller: scrollController,
      //   children: [

      //     const SizedBox(height: 10),

      //     Container(
      //       padding: const EdgeInsets.all(8),
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const Text(
      //             'Shapes',
      //             style: TextStyle(
      //                 fontWeight: FontWeight.bold, color: Colors.black),
      //           ),
      //           const Divider(),
      //           Wrap(
      //             alignment: WrapAlignment.start,
      //             spacing: 5,
      //             runSpacing: 5,
      //             children: [
      //               _IconBox(
      //                 iconData: FontAwesomeIcons.pencil,
      //                 selected: drawingMode.value == DrawingMode.pencil,
      //                 onTap: () => drawingMode.value = DrawingMode.pencil,
      //                 tooltip: 'Pencil',
      //               ),
      //               _IconBox(
      //                 selected: drawingMode.value == DrawingMode.line,
      //                 onTap: () => drawingMode.value = DrawingMode.line,
      //                 tooltip: 'Line',
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Container(
      //                       width: 22,
      //                       height: 2,
      //                       color: drawingMode.value == DrawingMode.line
      //                           ? Colors.grey[900]
      //                           : Colors.grey,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               _IconBox(
      //                 iconData: Icons.hexagon_outlined,
      //                 selected: drawingMode.value == DrawingMode.polygon,
      //                 onTap: () => drawingMode.value = DrawingMode.polygon,
      //                 tooltip: 'Polygon',
      //               ),
      //               _IconBox(
      //                 iconData: FontAwesomeIcons.eraser,
      //                 selected: drawingMode.value == DrawingMode.eraser,
      //                 onTap: () => drawingMode.value = DrawingMode.eraser,
      //                 tooltip: 'Eraser',
      //               ),
      //               _IconBox(
      //                 iconData: FontAwesomeIcons.square,
      //                 selected: drawingMode.value == DrawingMode.square,
      //                 onTap: () => drawingMode.value = DrawingMode.square,
      //                 tooltip: 'Square',
      //               ),
      //               _IconBox(
      //                 iconData: FontAwesomeIcons.circle,
      //                 selected: drawingMode.value == DrawingMode.circle,
      //                 onTap: () => drawingMode.value = DrawingMode.circle,
      //                 tooltip: 'Circle',
      //               ),
      //             ],
      //           ),
      //           const SizedBox(height: 8),
      //           Row(
      //             children: [
      //               const Text(
      //                 'Fill Shape: ',
      //                 style: TextStyle(fontSize: 12, color: Colors.black),
      //               ),
      //               Checkbox(
      //                 value: filled.value,
      //                 onChanged: (val) {
      //                   filled.value = val ?? false;
      //                 },
      //               ),
      //             ],
      //           ),
      //           AnimatedSwitcher(
      //             duration: const Duration(milliseconds: 150),
      //             child: drawingMode.value == DrawingMode.polygon
      //                 ? Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     children: [
      //                       const Text(
      //                         'Polygon Sides: ',
      //                         style: TextStyle(
      //                             fontSize: 12, color: Colors.black),
      //                       ),
      //                       Slider(
      //                         value: polygonSides.value.toDouble(),
      //                         min: 3,
      //                         max: 8,
      //                         onChanged: (val) {
      //                           polygonSides.value = val.toInt();
      //                         },
      //                         label: '${polygonSides.value}',
      //                         divisions: 5,
      //                       ),
      //                     ],
      //                   )
      //                 : const SizedBox.shrink(),
      //           ),
      //         ],
      //       ),
      //     ),

      //     const SizedBox(height: 10),
      //     Container(
      //       padding: EdgeInsets.all(8),
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const Text(
      //             'Colors',
      //             style: TextStyle(
      //                 fontWeight: FontWeight.bold, color: Colors.black),
      //           ),
      //           const Divider(),
      //           ColorPalette(
      //             selectedColor: selectedColor,
      //           ),
      //         ],
      //       ),
      //     ),

      //     const SizedBox(height: 20),
      //     Container(
      //         padding: EdgeInsets.all(8),
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             const Text(
      //               'Size',
      //               style: TextStyle(
      //                   fontWeight: FontWeight.bold, color: Colors.black),
      //             ),
      //             const Divider(),
      //             Row(
      //               children: [
      //                 SizedBox(
      //                   width: 80,
      //                   child: TextButton(
      //                     child: const Text('Stroke Size:'),
      //                     onPressed: () async {},
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Slider(
      //                     value: strokeSize.value,
      //                     min: 0,
      //                     max: 50,
      //                     onChanged: (val) {
      //                       strokeSize.value = val;
      //                     },
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 SizedBox(
      //                   width: 80,
      //                   child: TextButton(
      //                     child: const Text('Eraser Size'),
      //                     onPressed: () async {},
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Slider(
      //                     value: eraserSize.value,
      //                     min: 0,
      //                     max: 80,
      //                     onChanged: (val) {
      //                       eraserSize.value = val;
      //                     },
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         )),

      //     const SizedBox(height: 20),
      //     Container(
      //         padding: EdgeInsets.all(8),
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             const Text(
      //               'Actions',
      //               style: TextStyle(
      //                   fontWeight: FontWeight.bold, color: Colors.black),
      //             ),
      //             const Divider(),
      //             Wrap(
      //               children: [
      //                 TextButton(
      //                   onPressed: allSketches.value.isNotEmpty
      //                       ? () => undoRedoStack.value.undo()
      //                       : null,
      //                   child: const Text('Undo'),
      //                 ),
      //                 ValueListenableBuilder<bool>(
      //                   valueListenable: undoRedoStack.value._canRedo,
      //                   builder: (_, canRedo, __) {
      //                     return TextButton(
      //                       onPressed: canRedo
      //                           ? () => undoRedoStack.value.redo()
      //                           : null,
      //                       child: const Text('Redo'),
      //                     );
      //                   },
      //                 ),
      //                 TextButton(
      //                   child: const Text('Clear'),
      //                   onPressed: () => undoRedoStack.value.clear(),
      //                 ),
      //                 // TextButton(
      //                 //   onPressed: () async {
      //                 //     if (backgroundImage.value != null) {
      //                 //       backgroundImage.value = null;
      //                 //     } else {
      //                 //       backgroundImage.value = await _getImage;
      //                 //       print("Image that am getting ${ backgroundImage.value.toString()}");
      //                 //     }
      //                 //   },
      //                 //   child: Text(
      //                 //     backgroundImage.value == null
      //                 //         ? 'Add Background'
      //                 //         : 'Remove Background',
      //                 //   ),
      //                 // ),
      //                 // TextButton(
      //                 //   child: const Text('Fork on Github'),
      //                 //   onPressed: () => _launchUrl(kGithubRepo),
      //                 // ),
      //               ],
      //             ),
      //           ],
      //         )),

      //     const SizedBox(height: 20),
      //     Container(
      //         padding: EdgeInsets.all(8),
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             const Text(
      //               'Export',
      //               style: TextStyle(
      //                   fontWeight: FontWeight.bold, color: Colors.black),
      //             ),
      //             const Divider(),
      //             Row(
      //               children: [
      //                 SizedBox(
      //                   width: 80,
      //                   child: TextButton(
      //                     child: const Text('Export PNG'),
      //                     onPressed: () async {
      //                       Uint8List? pngBytes = await getBytes();

      //                       if (pngBytes != null) saveFile(pngBytes, 'png');
      //                     },
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   width: 80,
      //                   child: TextButton(
      //                     child: const Text('Export JPEG'),
      //                     onPressed: () async {
      //                       Uint8List? pngBytes = await getBytes();
      //                       if (pngBytes != null) saveFile(pngBytes, 'jpeg');
      //                     },
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         )),

      //     // add about me button or follow buttons
      //     const Divider(),
      //   ],
      // ),

      // ),
    );
  }

  void saveFile(Uint8List bytes, String extension) async {
    if (kIsWeb) {
      print("image ext----${extension.toString()}");
      html.AnchorElement()
        ..href = '${Uri.dataFromBytes(bytes, mimeType: 'image/$extension')}'
        ..download =
            'FlutterLetsDraw-${DateTime.now().toIso8601String()}.$extension'
        ..style.display = 'none'
        ..click();
    } else {
      print(' i  m here');
      await FileSaver.instance.saveFile(
        'FlutterLetsDraw-${DateTime.now().toIso8601String()}.$extension',
        bytes,
        extension,
        mimeType: extension == 'png' ? MimeType.PNG : MimeType.JPEG,
      );
      //  Save the file to the gallery using gallery_saver
      var resp = await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));

      log(resp.toString());
      if (resp["isSuccess"] == true) {
        Get.snackbar("Canvas Saved to gallery", '');
      }

//       try{
//  var path = await ImageDownloader.findPath(response);
//   log(path.toString());
//       }catch(e){
// log(e.toString());
//       }

// await ImageDownloader.downloadImage(response,
//                                      destination: AndroidDestinationType.custom('sample', directory: '')
//                                      ..inExternalFilesDir()
//                                      ..subDirectory("custom/sample.gif"),
//          );
    }
  }

  Future<ui.Image> get _getImage async {
    final completer = Completer<ui.Image>();
    if (!kIsWeb && !Platform.isAndroid && !Platform.isIOS) {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (file != null) {
        final filePath = file.files.single.path;
        final bytes = filePath == null
            ? file.files.first.bytes
            : File(filePath).readAsBytesSync();
        if (bytes != null) {
          completer.complete(decodeImageFromList(bytes));
        } else {
          completer.completeError('No image selected');
        }
      }
    } else {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        completer.complete(
          decodeImageFromList(bytes),
        );
      } else {
        completer.completeError('No image selected');
      }
    }

    return completer.future;
  }

  Future<void> _launchUrl(String url) async {
    if (kIsWeb) {
      html.window.open(
        url,
        url,
      );
    } else {
      if (!await launchUrl(Uri.parse(url))) {
        throw 'Could not launch $url';
      }
    }
  }

  Future<Uint8List?> getBytes() async {
    RenderRepaintBoundary boundary = canvasGlobalKey.currentContext
        ?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    return pngBytes;
  }
}

class _IconBox extends StatelessWidget {
  final IconData? iconData;
  final Widget? child;
  final bool selected;
  final VoidCallback onTap;
  final String? tooltip;

  const _IconBox({
    Key? key,
    this.iconData,
    this.child,
    this.tooltip,
    required this.selected,
    required this.onTap,
  })  : assert(child != null || iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? Colors.grey[900]! : Colors.grey,
              // color: selected ? Colors.white : Colors.white54,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Tooltip(
            message: tooltip,
            preferBelow: false,
            child: child ??
                Icon(
                  iconData,
                  color: selected ? Colors.grey[900] : Colors.grey,
                  // color:selected ? Colors.white : Colors.white54,
                  size: 20,
                ),
          ),
        ),
      ),
    );
  }
}

///A data structure for undoing and redoing sketches.
class _UndoRedoStack {
  _UndoRedoStack({
    required this.sketchesNotifier,
    required this.currentSketchNotifier,
  }) {
    _sketchCount = sketchesNotifier.value.length;
    sketchesNotifier.addListener(_sketchesCountListener);
  }

  final ValueNotifier<List<Sketch>> sketchesNotifier;
  final ValueNotifier<Sketch?> currentSketchNotifier;

  ///Collection of sketches that can be redone.
  late final List<Sketch> _redoStack = [];

  ///Whether redo operation is possible.
  ValueNotifier<bool> get canRedo => _canRedo;
  late final ValueNotifier<bool> _canRedo = ValueNotifier(false);

  late int _sketchCount;

  void _sketchesCountListener() {
    if (sketchesNotifier.value.length > _sketchCount) {
      //if a new sketch is drawn,
      //history is invalidated so clear redo stack
      _redoStack.clear();
      _canRedo.value = false;
      _sketchCount = sketchesNotifier.value.length;
    }
  }

  void clear() {
    _sketchCount = 0;
    sketchesNotifier.value = [];
    _canRedo.value = false;
    currentSketchNotifier.value = null;
  }

  void undo() {
    final sketches = List<Sketch>.from(sketchesNotifier.value);
    if (sketches.isNotEmpty) {
      _sketchCount--;
      _redoStack.add(sketches.removeLast());
      sketchesNotifier.value = sketches;
      _canRedo.value = true;
      currentSketchNotifier.value = null;
    }
  }

  void redo() {
    if (_redoStack.isEmpty) return;
    final sketch = _redoStack.removeLast();
    _canRedo.value = _redoStack.isNotEmpty;
    _sketchCount++;
    sketchesNotifier.value = [...sketchesNotifier.value, sketch];
  }

  void dispose() {
    sketchesNotifier.removeListener(_sketchesCountListener);
  }
}
