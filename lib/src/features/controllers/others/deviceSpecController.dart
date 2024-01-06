import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceSpacController extends GetxController{
  static DeviceSpacController get instance => Get.find();
  final BuildContext context;
  
  RxDouble deviceHeight = 0.0.obs;
  RxDouble deiceWidth = 0.0.obs;
  Brightness brightness = Brightness.dark;
  Brightness? brightnessLight ;
  DeviceSpacController(this.context);

  void configureDevice(){
    final mediauery = MediaQuery.of(context);
    deviceHeight = mediauery.size.height.obs;
    deiceWidth = mediauery.size.width.obs;
    brightness = mediauery.platformBrightness;
    brightnessLight = mediauery.platformBrightness;
  }

  @override
  void onInit() {
    super.onInit();
    configureDevice();
  }

}