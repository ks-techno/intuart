import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as x;
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/app_colors.dart';
import '../../../view/drawing_canvas/widgets/dropdown.dart';
import '../controller/home_controller.dart';

class PatternMakerDetail extends StatefulWidget {
  const PatternMakerDetail({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  State<PatternMakerDetail> createState() => _PatternMakerDetailState();
}

class _PatternMakerDetailState extends State<PatternMakerDetail> {
  final dio = Dio();

  File? _image;
  bool showImage = false;

  _saveNetworkImage(url) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "");
    print(result);
    if (result["isSuccess"] == true) {
      x.Get.snackbar("Pattern saved in gallery", '');
    }
  }

  imageFromGalley() async {
    print("-------------------------------------------");
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imagePath = pickedImage?.path.toString();
    print(imagePath);
    if (pickedImage != null) {
      // Check if the file exists before using it
      if (File(pickedImage.path).existsSync()) {
        _image = File(pickedImage.path);
        if (kDebugMode) {
          print("Printing image path: ${_image?.path}");
        }
        // String decodedPath = Uri.decodeFull("$_image");

        // substring(5);
      } else {
        if (kDebugMode) {
          print("File does not exist at the specified path.");
        }
      }
    } else {
      if (kDebugMode) {
        print("Image picking operation was canceled or failed.");
      }
    }
  }

  final String baseURl =
      "https://intuart.ks-technologies.net/api/generate-pattern";
  String? imageList;
  bool isLoading = false;
  String? imageUrl;
  final ImagePicker imagePicker = ImagePicker();

  // Function to upload media and return the response data

  Future<Map<String, dynamic>> uploadMediaRequest(
      {required BuildContext context, var image, var type}) async {
    isLoading = true;
    var url = "$baseURl?tilingStyle=$type";
    print("base url is -------${url}");
    MultipartFile file = await MultipartFile.fromFile(
      image,
      filename: image.toString(),
    );

    var formData = FormData.fromMap({
      'file': file,
    });

    try {
      var response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'accept': 'application/json',
          },
          contentType: 'multipart/form-data',
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming the response data is a Map<String, dynamic>
        Map<String, dynamic> responseData = response.data;
        if (kDebugMode) {
          print("printing response $responseData");
        }
        imageUrl = responseData['pattern_url'];
        if (kDebugMode) {
          print("printing response $imageUrl");
        }
        setState(() {
          isLoading = false;
        });
        return responseData;
      } else {
        setState(() {
          isLoading = false;
        });
        if (kDebugMode) {
          print("Error: ${response.statusMessage}");
        }
        return {'error': response.statusMessage ?? 'Unknown error'};
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print("Exception: $e");
      }
      return {'error': 'Exception occurred: $e'};
    }
  }

  Future<ui.Image> downloadImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final List<int> bytes = response.bodyBytes;
      final Completer<ui.Image> completer = Completer();

      ui.decodeImageFromList(Uint8List.fromList(bytes), (ui.Image img) {
        completer.complete(img);
      });

      return completer.future;
    } else {
      throw Exception('Failed to load image: ${response.statusCode}');
    }
  }

  final List<String> filterItems = [
    'random',
    'facade',
    'crossbrick',
    'weave',
    'zigzag',
    'hexagon',
    'crossweave'
  ];
  String selectedSortValue = 'random';
  String? selectedOrder;
  String? imagePath;

  Future<Map<String, dynamic>>? uploadMediaFuture;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 339.w,
      height: MediaQuery.sizeOf(context).height - 50,
      decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(48.r)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterWidget(
                  kisWeb: false,
                  selectedOrderFilter: (String val) {
                    selectedOrder = val;
                    if (kDebugMode) {
                      print("--------$selectedOrder");
                    }
                    return "$selectedOrder";
                  },
                  callBackOrderFilter: selectedOrder ?? "",
                ),
              ],
            )

            // Padding(
            //   padding: EdgeInsets.only(top: 32.h),
            //   child: FileNameWidget(
            //     width: 210.w,
            //     height: 100.h,
            //     imageWidth: 50.w,
            //     imageHeight: 60.h,
            //     text: AppStrings.imagePreview,
            //     style: AppStyles.interMedium(size: 20.sp),
            //   ),
            // ),
            // Obx(
            //   () => SliderOptionWidget(
            //     maxValue: homeController.maxValue1.value,
            //     value: homeController.sliderValue1.value,
            //     onChange: (value) {
            //       homeController.sliderValue1.value = value;
            //     },
            //     textValue: "${homeController.sliderValue1.value.toInt()}",
            //   ),
            // ),
            // Obx(
            //   () => SliderOptionWidget(
            //     maxValue: homeController.maxValue2.value,
            //     value: homeController.sliderValue2.value,
            //     onChange: (value) {
            //       homeController.sliderValue2.value = value;
            //     },
            //     textValue: "${homeController.sliderValue2.value.toInt()}",
            //   ),
            // ),
            // Obx(
            //   () => SliderOptionWidget(
            //     maxValue: homeController.maxValue3.value,
            //     value: homeController.sliderValue3.value,
            //     onChange: (value) {
            //       homeController.sliderValue3.value = value;
            //     },
            //     textValue: "${homeController.sliderValue3.value.toInt()}",
            //   ),
            // ),
            ,
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         TextButton(
            //           onPressed: () async {
            //             setState(() {
            //               isLoading=true;
            //             });
            //             if (kDebugMode) {
            //               print("Image list is ${_image?.path.substring(1)}");
            //             }
            //             await uploadMediaRequest(
            //                 context:    context,
            //                 image: _image?.path.substring(1),
            //                 type:    selectedOrder??"random");
            //
            //             setState(() {
            //               isLoading=false;
            //             });
            //
            //           },
            //           child: const Text('Create pattern '),
            //         ),
            //         SizedBox(
            //           height: 60,
            //         ),
            //         TextButton(
            //           onPressed: () async {
            //             imageFromGalley();
            //             // if (_image != null) {
            //             //   await uploadMediaRequest(context, _image);
            //             // }
            //             // if (backgroundImage?.value != null) {
            //             //   backgroundImage?.value = null;
            //             // } else {
            //             //   backgroundImage?.value = await _getImage;
            //             // }
            //           },
            //           child: const Text(
            //             // backgroundImage?.value == null
            //             //     ?
            //               'Add photo '
            //             // : 'Remove',
            //           ),
            //         ),
            //         // ButtonWithIcon(
            //         //   width: 160.w,
            //         //   bottomHeight: 0.h,
            //         //   text: AppStrings.add,
            //         //   color: AppColors.lightBlueColor,
            //         // ),
            //       ],
            //     ),
            //     // Get.context!.isPhone && Get.context!.isLandscape
            //     //     ? const SizedBox(height: 150)
            //     //     : const SizedBox()
            //     showImage
            //         ? Container(
            //       height: 200,
            //       width: 180,
            //       child: Image.network(imageUrl!,
            //         fit: BoxFit.cover,
            //       ),
            //
            //     )
            //         : TextButton(
            //       onPressed: () async {
            //         setState(() {
            //           showImage = true;
            //         });
            //         // imageFromGalley();
            //       },
            //       child: const Text(
            //         // backgroundImage?.value == null
            //         //     ?
            //           'Show Image '
            //         // : 'Remove',
            //       ),
            //     ),
            //   ],
            // )
            if (imagePath != null)
              Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    // color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: FileImage(File(imagePath.toString())),
                        fit: BoxFit.cover)),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imagePath != null)
                  TextButton(
                    onPressed: isLoading ? (){}: () {
                      // Only initiate the upload if not already in progress
                      // if () {
                        setState(() {
                          isLoading = true;
                        });
                        uploadMediaFuture = uploadMediaRequest(
                          context: context,
                          image: _image?.path.substring(1),
                          type: selectedOrder ?? "random",
                        );
                        uploadMediaFuture!.whenComplete(() {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      // }
                    },
                    child:  Text( uploadMediaFuture == null ? 'Create pattern' : 'Regenerate pattern'),
                  ),
                const SizedBox(
                  height: 60,
                ),
                imagePath == null
                    ? TextButton(
                        onPressed:
                            () async {
                          imageFromGalley();
                        },
                        child: const Text('Add photo'),
                      )
                    : imageUrl != null
                        ? TextButton(
                            onPressed: () {
                              _saveNetworkImage(imageUrl);
                            },
                            child: const Text('Export'))
                        : const SizedBox.shrink()
              ],
            ),
            // FutureBuilder(
            //   future: uploadMediaFuture,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else if (snapshot.hasData) {
            //       // Assuming the response data is a Map<String, dynamic>
            //       Map<String, dynamic> responseData = snapshot.data!;
            //       imageUrl = responseData['pattern_url'];
            //       return showImage
            //           ? Container(
            //         height: 200,
            //         width: 180,
            //         child: Image.network(
            //           imageUrl!,
            //           fit: BoxFit.cover,
            //         ),
            //       )
            //           : TextButton(
            //         onPressed: () {
            //           setState(() {
            //             showImage = true;
            //           });
            //         },
            //         child: const Text('Show Image'),
            //       );
            //     } else {
            //       return SizedBox.shrink();
            //     }
            //   },
            // ),
            FutureBuilder(
              future: uploadMediaFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a placeholder while waiting for the image to load
                  return  const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Handle errors
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // Assuming the response data is a Map<String, dynamic

                  return showImage
                      ? Image.network(
                          imageUrl!,
                          height: 180,
                          width: 160,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              // Show a loading indicator while the image is loading
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            // Handle errors during image loading
                            return const Center(
                              child: Text('Error loading image'),
                            );
                          },
                        )
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              showImage = true;
                            });
                          },
                          child: const Text('Show Image'),
                        );
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
