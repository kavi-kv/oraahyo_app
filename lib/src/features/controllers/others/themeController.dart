import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/utils/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ThemeController extends GetxController {
  // RxBool isDarkMode = RxBool (Brightness.dark == Brightness.dark);
  RxBool isDarkMode = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadThemeMode();
  }
  
  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    await saveThemeMode(isDarkMode.value);
    print('CurrentThemeMode is : ${isDarkMode.value}');
  }

  
  Future<void> saveThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }


  Future<void> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool("isDarkMode") ?? false;
  }
  
  
}