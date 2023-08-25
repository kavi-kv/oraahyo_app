

import 'package:get/get.dart';

class NavigationController extends GetxController{
  final selectedRoute = ''.obs;
  final title = ''.obs;

  void changeRoute(String section){
    selectedRoute.value = section;
    Get.toNamed('/navigation-layout');
  }


}