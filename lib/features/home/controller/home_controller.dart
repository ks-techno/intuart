import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui; // Import dart:ui
class HomeController extends GetxController {

  final emailController = TextEditingController();
  final height1Controller = TextEditingController();
  final height2Controller = TextEditingController();

    Rx<ui.Image?> backgroundImage = Rx<ui.Image?>(null); // Change Image? to ui.Image?

  void setBackgroundImage(ui.Image? image) {
    backgroundImage.value = image;
  }


  RxBool isClicked = false.obs;
  RxBool isLeftClicked = false.obs;
  RxDouble maxValue1 = 40.0.obs;
  RxDouble sliderValue1 = 1.0.obs;


  RxString clipimg0 =''.obs;
  RxString clipName0 =''.obs;
  RxString clipimg1 =''.obs;
  RxString clipName1 =''.obs;
  RxString clipimg2 =''.obs;
  RxString clipName2 =''.obs;
 Rx<Uint8List> clipBack0 = Rx<Uint8List>(Uint8List(0));
 Rx<Uint8List> clipBack1 = Rx<Uint8List>(Uint8List(0));
 Rx<Uint8List> clipBack2 = Rx<Uint8List>(Uint8List(0));

  RxDouble maxValue2 = 40.0.obs;
  RxDouble sliderValue2 = 1.0.obs;

  RxDouble maxValue3 = 40.0.obs;
  RxDouble sliderValue3 = 1.0.obs;

  RxInt selectedMenu = 0.obs;
  RxInt selectedLeftMenu = 0.obs;
  void selectMenu(int menuIndex) {
    selectedMenu.value = menuIndex;
  }
  void selectLeftMenu(int menuIndex) {
    selectedLeftMenu.value = menuIndex;
  }

  RxInt radioSelectedValue = 0.obs;

  void updateSelectedValue(int value) {
    radioSelectedValue.value = value;
  }

  RxInt selectedValueDropButton = 0.obs;

  void selectValueDropButton(int menuIndex) {
    selectedValueDropButton.value = menuIndex;
  }
}