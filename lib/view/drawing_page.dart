import 'dart:ui';
import 'dart:ui' as ui;

import 'package:file_saver/file_saver.dart';
import 'package:final_app/features/home/controller/home_controller.dart';
import 'package:final_app/features/home/view/pattern_maker.dart';
import 'package:final_app/view/drawing_canvas/drawing_canvas.dart';
import 'package:final_app/view/drawing_canvas/models/drawing_mode.dart';
import 'package:final_app/view/drawing_canvas/models/sketch.dart';
import 'package:final_app/view/drawing_canvas/widgets/canvas_side_bar.dart';
import 'package:final_app/view/write_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:universal_html/html.dart' as html;

import '../features/home/view/art_boards_dialog.dart';
import '../features/home/view/clip_board_detail.dart';
import '../features/home/view/layers_detail.dart';
import '../features/home/view/left_menu_closed.dart';
import '../features/home/view/live_share_dialog.dart';
import '../features/home/view/menu_closed.dart';
import '../features/home/view/menu_opened.dart';
import '../features/home/view/new_artboard_dialog.dart';
import '../features/home/view/pattern_maker_detail.dart';
import '../features/home/view/simulator_dialog.dart';
import '../features/home/widget/icon_text_widget.dart';
import '../features/home/widget/round_icon_widget.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/app_styles.dart';

// ignore: must_be_immutable
class DrawingPage extends HookWidget {
  DrawingPage({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
//  final backgroundImage = homeController.backgroundImage.value;

    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final canvasHeight = useState<double>(MediaQuery.of(context).size.height * 0.88);
    final canvasWidth = useState<double>(double.maxFinite);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);
    final canvasGlobalKey = GlobalKey();
    final selectedLeftMenu = useState(0);


    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 0,
    );

    //   animationController.addListener(() {
    //     print("0000000");
    // if (animationController.value == 0) {
    //   // Show LeftMenuClosed
    //    LeftMenuClosed();
    // } else {
    //   // Handle other cases if needed
    // }}
    // );
    Future<Uint8List?> getBytes() async {
      RenderRepaintBoundary boundary = canvasGlobalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
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

        if (resp["isSuccess"] == true) {
          Get.snackbar("Canvas Saved to gallery", '');
        }
      }
    }

    return ListView(
      physics:const BouncingScrollPhysics(),
      children: [
        Stack(
          children: [
            SizedBox(
              // color: Colors.red,
              width: canvasWidth.value,
              height: canvasHeight.value,
              // height: double.maxFinite,
              // margin: EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.2,top: 10),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.height * 0.06),
                child: DrawingCanvas(
                  width: canvasWidth.value,
                  height: canvasHeight.value,
                  drawingMode: drawingMode,
                  selectedColor: selectedColor,
                  strokeSize: strokeSize,
                  eraserSize: eraserSize,
                  sideBarController: animationController,
                  currentSketch: currentSketch,
                  allSketches: allSketches,
                  canvasGlobalKey: canvasGlobalKey,
                  filled: filled,
                  polygonSides: polygonSides,
                  backgroundImage: backgroundImage,
                ),
              ),
            ),

            Positioned(
              top: 70,
              left: 42,
              // left: -5,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animationController),
                child: CanvasSideBar(
                  selectedLeftMenu: selectedLeftMenu,
                  drawingMode: drawingMode,
                  selectedColor: selectedColor,
                  strokeSize: strokeSize,
                  eraserSize: eraserSize,
                  currentSketch: currentSketch,
                  allSketches: allSketches,
                  canvasGlobalKey: canvasGlobalKey,
                  filled: filled,
                  polygonSides: polygonSides,
                  backgroundImage: backgroundImage,
                ),
              ),
            ),
            // Obx((){
            //   return
            //  animationController.value == 0 ?
            //  _CustomAppBar(animationController: animationController)
            // :
            LeftMenuClosed(animationController: animationController,selectedLeftMenu: selectedLeftMenu),
            // }),

            Obx(
              () {
                final isClicked = homeController.isClicked.value;
                return isClicked ? MenuOpened() : MenuClosed();
              },
            ),

            Obx(() {
              final selectedMenu = homeController.selectedMenu.value;
              switch (selectedMenu) {
                case 1:
                  return Positioned(
                    right: 200.w,
                    // top: MediaQuery.of(context).size.height / 2 - (456.h / 2),
                    top: MediaQuery.of(context).size.height / 2 - (406.h / 2),
                    // top: 40,
                    child: ClipBoardDetail(
                      backgroundImage: backgroundImage,
                      index: 1,
                    ),
                  );
                case 2:
                  Future.delayed(Duration.zero, () {
                    simulatorDialog();
                  });
                  return const SizedBox();
                case 3:
                  return Positioned(
                      right: 200.w,

                      // top: MediaQuery.of(context).size.height / 2 - (456.h / 2),

                      top: MediaQuery.of(context).size.height / 2 - (406.h / 2),
                      child:
                          PatternMakerDetail(homeController: homeController));
                case 4:
                  return Positioned(
                    right: 200.w,
                    top: MediaQuery.of(context).size.height / 2 - (256.h / 2),
                    child: LayersDetail(),
                  );
                default:
                  return const SizedBox();
              }
            }),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(21.w, 0.w, 16.w, 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppStrings.intuart,
                          style: AppStyles.primaryBoldStyle(
                              size: 40.sp, color: AppColors.fillColor),
                        ),
                        SizedBox(width: 20.w),
                        RoundIconWidget(
                          icon: Icons.settings_outlined,
                          onTap: () {
                            WriteScreen();
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RoundIconWidget(
                            onTap: () {
                          
                       newArtBoardDialog(
                                context,
                              
                       
                                () {
                          
    
                              
                                  backgroundImage.value = null;
                                  allSketches.value = [];
                                  currentSketch.value = null;
                                  // canvasHeight.value = double.parse(homeController.height1Controller.text.toString()) ;
                                  // canvasWidth.value = double.parse(homeController.height2Controller.text.toString());
                                  // print(canvasWidth.value);
                                },
                                         canvasHeight,
                               canvasWidth,
                              );
                     
                              
                            },
                            icon: Icons.add),
                        IconTextWidget(
                          onTap: () {
                            artBoardDialog(context, () {
                              backgroundImage.value = null;
                              allSketches.value = [];
                              currentSketch.value = null;
                            },
                             canvasHeight,
                               canvasWidth,
                            );
                          },
                          icon: Icons.color_lens_outlined,
                          text: AppStrings.artBoards,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RoundIconWidget(
                          icon: Icons.remove_red_eye_outlined,
                          onTap: () {
                            liveShareDialog(context);
                          },
                        ),
                        RoundIconWidget(
                          icon: Icons.share_outlined,
                          onTap: () {},
                        ),
                        IconTextWidget(
                          icon: Icons.upgrade_sharp,
                          text: AppStrings.export,
                          onTap: () async {
                            Uint8List? pngBytes = await getBytes();
                            if (pngBytes != null) saveFile(pngBytes, 'jpeg');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //
          ],
        ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final AnimationController animationController;

  const _CustomAppBar({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(MediaQuery.sizeOf(context).width * 0.25,
          -MediaQuery.sizeOf(context).height * 0.02),
      child: IconButton(
        color: Colors.black,
        onPressed: () {
          if (animationController.value == 0) {
            animationController.forward();
          } else {
            animationController.reverse();
          }
        },
        icon: const Icon(Icons.menu),
      ),
    );
  }
}
