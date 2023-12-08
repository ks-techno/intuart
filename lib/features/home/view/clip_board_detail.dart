import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../widgets/button_with_icon.dart';
import '../controller/home_controller.dart';
import '../widget/file_name_widget.dart';
import 'edit_clipboard_dialog.dart';
import 'dart:ui' as ui;

class ClipBoardDetail extends StatefulWidget {
  final ValueNotifier<ui.Image?> backgroundImage;
  ClipBoardDetail({
    super.key,
    required this.index,
    required this.backgroundImage,
  });

  final int index;

  @override
  State<ClipBoardDetail> createState() => _ClipBoardDetailState();
}

class _ClipBoardDetailState extends State<ClipBoardDetail> {
  String? imagePath;
  String? imageName;
  String? imagePath1;
  String? imageName1;
  String? imagePath2;
  String? imageName2;

 List<Map> tabs = [
    {'title': 'All', 'selected': true},
    {'title': 'PNG', 'selected': false, 'status': true},
    {'title': 'SVG', 'selected': false, 'status': false},
  ];
    int selectedTabIndex = 0;
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
     double screenW = MediaQuery.of(context).size.width;
    return Container(
        width: 378.w,
        height: 456.h,
        decoration: BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.circular(48.r)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
 for (int i = 0; i < tabs.length; i++)
              InkWell(
                onTap: () {
                   setState(() {
                        tabs[selectedTabIndex]['selected'] = false;
                        selectedTabIndex = i;
                        tabs[selectedTabIndex]['selected'] = true;
                      });
                },
                child: Container(
                      padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 30),
                  decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              width: tabs[i]['selected'] ? 2 : .5,
                              color: tabs[i]['selected']
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ))),
                            child: Text(
                              tabs[i]['title'],
                              style: TextStyle(
                                  color: tabs[i]['selected']
                                      ? Colors.white
                                      : Colors.grey.shade800,
                                  fontSize: screenW < 768 ? 14 : 16,
                                  fontWeight: tabs[i]['selected']
                                      ? FontWeight.w600
                                      : FontWeight.w500),
                            ),
                ),
              ),
              ],),
             
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 33.w, vertical: 32.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return FileNameWidget(
                        fileImg: homeController.clipimg0.value,
                        text: homeController.clipName0.value,
                        onTap: () async {
                          if (homeController.clipBack0.value != null) {
                            print("inside the tap");

                            widget.backgroundImage.value = await convertImage(
                                homeController.clipBack0.value);
                          }

                          // editClipBoardDialog(context);
                        },
                      );
                    }),
                    Obx(() {
                      return FileNameWidget(
                        fileImg: homeController.clipimg1.value,
                        text: homeController.clipName1.value,
                        onTap: () async {
                          if (homeController.clipBack1.value != null) {
                            print("inside the tap");

                            widget.backgroundImage.value = await convertImage(
                                homeController.clipBack1.value);
                          }
                          // editClipBoardDialog(context);
                        },
                      );
                    }),
                  ],
                ),
              ),
              Obx(() {
                return FileNameWidget(
                  fileImg: homeController.clipimg2.value,
                  text: homeController.clipName2.value,
                  onTap: () async {
                    if (homeController.clipBack2.value != null) {
                      print("inside the tap");

                      widget.backgroundImage.value =
                          await convertImage(homeController.clipBack2.value);
                    }
                    // editClipBoardDialog(context);
                  },
                );
              }),
              SizedBox(
                height: 32.h,
              ),
              ButtonWithIcon(
                onTap: () async {
                  // if (widget.backgroundImage.value != null) {
                  //   widget.backgroundImage.value = null;
                  // } else

                  {
                    // widget.backgroundImage.value = await _getImage;
                    await _getImage;
                  }
                },
                text: AppStrings.importImage,
                color: AppColors.lightBlueColor,
              ),
            ],
          ),
        ));
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

      imagePath = image?.path.toString();
      imageName = image?.name.toString();
      log("$imagePath Image Path");
      if (image != null) {
        if (homeController.clipName0.value == '' ||
            homeController.clipimg0.value == '') {
          homeController.clipName0.value = image.name.toString();
          homeController.clipimg0.value = image.path.toString();
          final bytes = await image.readAsBytes();
          homeController.clipBack0.value = bytes;
        } else if (homeController.clipName1.value == '' ||
            homeController.clipimg1.value == '') {
          homeController.clipName1.value = image.name.toString();
          homeController.clipimg1.value = image.path.toString();
          final bytes = await image.readAsBytes();
          homeController.clipBack1.value = bytes;
        } else if (homeController.clipName2.value == '' ||
            homeController.clipimg2.value == '') {
          homeController.clipName2.value = image.name.toString();
          homeController.clipimg2.value = image.path.toString();
          final bytes = await image.readAsBytes();
          homeController.clipBack2.value = bytes;
        }
      }

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

  Future<ui.Image> convertImage(Uint8List? bytes) async {
    final Completer<ui.Image> completer = Completer<ui.Image>();

    if (bytes != null) {
      completer.complete(await decodeImageFromList(bytes));
    } else {
      completer.completeError('No image selected');
    }

    return completer.future;
  }
}
