

import 'package:get/get.dart';

class NavigationController extends GetxController{
  final selectedRoute = ''.obs;
  final title = ''.obs;
  RxBool isLoading = true.obs;

  void changeRoute(String section){
    isLoading.value = true;
    selectedRoute.value = section;
    Get.toNamed('/navigation-layout');
    isLoading.value = false;
  }


}