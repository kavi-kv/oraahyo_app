import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/utils/theme/theme.dart';
class ThemeController extends GetxController {
  //  final BuildContext context;
  RxBool isDarkMode = RxBool (Brightness.dark == Brightness.dark);
  
  void toggleTheme(){
    isDarkMode.value = !isDarkMode.value;
    if(isDarkMode.value){
      Get.changeThemeMode(ThemeMode.dark);
    }
    else{
     Get.changeThemeMode(ThemeMode.light);
    }
    print("Theme toggled ${isDarkMode.value}");
    
  }
}