import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oraah_app/src/features/controllers/connection/network_controller.dart';
import 'package:get/get.dart';

final locator = GetIt.instance;

class DependencyInjection {
  static void setUp() {
    debugPrint("Setup is called");

    locator.registerFactory<NetworkController>(()=> NetworkController());
  }

  static void init(){
     Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}

