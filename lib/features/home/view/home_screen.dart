import 'dart:ui' as ui;

import 'package:final_app/features/home/controller/home_controller.dart';
import 'package:final_app/features/home/view/art_boards_dialog.dart';
import 'package:final_app/features/home/view/live_share_dialog.dart';
import 'package:final_app/features/home/view/menu_closed.dart';
import 'package:final_app/features/home/view/menu_opened.dart';
import 'package:final_app/features/home/view/new_artboard_dialog.dart';
import 'package:final_app/features/home/view/pattern_maker_detail.dart';
import 'package:final_app/features/home/view/simulator_dialog.dart';
import 'package:final_app/utils/app_colors.dart';
import 'package:final_app/utils/app_strings.dart';
import 'package:final_app/utils/app_styles.dart';
import 'package:final_app/view/drawing_canvas/lets_draw.dart';
import 'package:final_app/view/write_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_painter/image_painter.dart';

import '../widget/icon_text_widget.dart';
import '../widget/round_icon_widget.dart';
import 'clip_board_detail.dart';
import 'layers_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final HomeController homeController = Get.put(HomeController());
  final _imageKey = GlobalKey<ImagePainterState>();

  //  Future<Uint8List?> getBytes() async {
  //   RenderRepaintBoundary boundary = canvasGlobalKey.currentContext
  //       ?.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage();
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List? pngBytes = byteData?.buffer.asUint8List();
  //   return pngBytes;
  // }

  //  final GlobalKey<DrawingPageState> drawingPageKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          AppStyles.focusOut();
          Get.back();
        },
        child: Scaffold(
          body: Column(
            children: [
            Expanded(child:   Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 30,
                  bottom: 0,
                  child: Container(
                    height: MediaQuery.sizeOf(context).height*0.9,
                    child:LetsDraw() ,
                  ),
                ),
                // LetsDraw(),
                // Positioned(
                //   top: 20,
                //   left: 0,
                //   right: 40,
                //   child: Padding(
                //     padding: const EdgeInsets.only(top:60.0),
                //     child: SizedBox(
                //       height: MediaQuery.of(context).size.height * 0.7,
                //       width: MediaQuery.of(context).size.width * 0.7,
                //       child: ImagePainter.asset(
                //         "assets/images/simulationImage.png",
                //         key: _imageKey,
                //         scalable: true,
                //         initialStrokeWidth: 2,
                //         textDelegate: TextDelegate(),
                //         initialColor: Colors.green,
                //         initialPaintMode: PaintMode.line,
                //       ),
                //     ),
                //   ),
                // ),
                // Center(
                //   child: Container(
                //     width: 0,
                //     height: double.infinity,
                //     color: const Color(0xffC3C3C3),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(21.w, 0.w, 16.w, 20.h),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Row(
                //         children: [
                //           Text(
                //             AppStrings.intuart,
                //             style: AppStyles.primaryBoldStyle(size: 40.sp, color: AppColors.fillColor),
                //           ),
                //           SizedBox(width: 20.w),
                //            RoundIconWidget(icon: Icons.settings_outlined,onTap: (){
                //             WriteScreen();
                //           },),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           RoundIconWidget(
                //               onTap: () {
                //                 newArtBoardDialog(context);
                //               },
                //               icon: Icons.add),
                //           IconTextWidget(
                //             onTap: () {
                //               artBoardDialog(context);
                //             },
                //             icon: Icons.color_lens_outlined,
                //             text: AppStrings.artBoards,
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           RoundIconWidget(
                //             icon: Icons.remove_red_eye_outlined,
                //             onTap: () {
                //               liveShareDialog(context);
                //             },
                //           ),
                //           RoundIconWidget(
                //             icon: Icons.share_outlined,
                //             onTap: () {},
                //           ),
                //           IconTextWidget(
                //             icon: Icons.upgrade_sharp,
                //             text: AppStrings.export,
                //              onTap:  () async {
                //       // Uint8List? pngBytes = await getBytes();
                //       // if (pngBytes != null) saveFile(pngBytes, 'jpeg');
                //     },
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
         
         
                // // Positioned(
                //   left: 31.w,
                //   top: MediaQuery.of(context).size.height / 2.2 - (35.h + 50.h) / 2,
                //   child: Column(
                //     children: [
                //       Container(
                //         width: 48.w,
                //         height: 48.h,
                //         margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
                //         child: CustomSvg(
                //           image: AppAssets.zoomInIcon,
                //           wi: 35.w,
                //           hi: 35.h,
                //         ),
                //       ),
                //       SizedBox(height: 49.h),
                //       Container(
                //         width: 50.w,
                //         height: 50.h,
                //         decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.blackColor, width: 4.w)),
                //         child: Center(
                //           child: Padding(
                //             padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 9.w),
                //             child: CustomSvg(
                //               image: AppAssets.formatColor,
                //               wi: 20.w,
                //               hi: 18.5.h,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Obx(() {
                //   final isClicked = homeController.isClicked.value;
                //   return isClicked ? MenuOpened() : MenuClosed();
                // },),
                //  Obx(() {
                //   final isLeftClicked = homeController.isLeftClicked.value;
                //   return isLeftClicked ? LeftMenuOpened() : LeftMenuClosed();
                // },),

                // Obx(() {
                //   final selectedMenu = homeController.selectedMenu.value;
                //   switch (selectedMenu) {
                //     case 1:
                //       return Positioned(
                //         right: 200.w,
                //         top: MediaQuery.of(context).size.height / 2 - (456.h / 2),
                //         child:  ClipBoardDetail(
                //           index: 1,
                //         ),
                //       );
                //     case 2:
                //       Future.delayed(Duration.zero, () {
                //         simulatorDialog();
                //       });
                //       return const SizedBox();
                //     case 3:
                //       return Positioned(
                //           right: 200.w,
                //           top: MediaQuery.of(context).size.height / 2 - (456.h / 2),
                //           child: PatternMakerDetail(homeController: homeController));
                //     case 4:
                //       return Positioned(
                //         right: 200.w,
                //         top: MediaQuery.of(context).size.height / 2 - (256.h / 2),
                //         child: LayersDetail(),
                //       );
                //     // case 5:
                //     //   return Positioned(
                //     //     right: 200.w,
                //     //     top: MediaQuery.of(context).size.height / 2 - (256.h / 2),
                //     //     child: LayersDetail(),
                //     //   );
                //     // case 6:
                //     //   return Positioned(
                //     //     right: 200.w,
                //     //     top: MediaQuery.of(context).size.height / 2 - (256.h / 2),
                //     //     child: ColorDialog(),
                //     //   );
                //     // case 7:
                //     //   return Positioned(
                //     //     right: 200.w,
                //     //     top: MediaQuery.of(context).size.height / 2 - (256.h / 2),
                //     //     child: LayersDetail(),
                //     //   );
                //     // case 8:
                //     //   return Positioned(
                //     //     right: 200.w,
                //     //     top: MediaQuery.of(context).size.height / 2 - (256.h / 2),
                //     //     child: LayersDetail(),
                //     //   );
                //     // case 9:
                //     //   return Positioned(
                //     //     right: 200.w,
                //     //     top: MediaQuery.of(context).size.height / 2 - (256.h / 2),
                //     //     child: LayersDetail(),
                //     //   );
                //     default:
                //       return const SizedBox();
                //   }
                // }),
                
                
              ],
            ),)
            ],
          ),
        ),
      ),
    );
    
  }
  //  void saveFile(Uint8List bytes, String extension) async {
  //   if (kIsWeb) {
  //     print("image ext----${extension.toString()}");
  //     html.AnchorElement()
  //       ..href = '${Uri.dataFromBytes(bytes, mimeType: 'image/$extension')}'
  //       ..download =
  //           'FlutterLetsDraw-${DateTime.now().toIso8601String()}.$extension'
  //       ..style.display = 'none'
  //       ..click();
  //   } else {
  //     print(' i  m here');
  //     await FileSaver.instance.saveFile(
  //       'FlutterLetsDraw-${DateTime.now().toIso8601String()}.$extension',
  //       bytes,
  //       extension,
  //       mimeType: extension == 'png' ? MimeType.PNG : MimeType.JPEG,
  //     );
  //   }
  // }
}
