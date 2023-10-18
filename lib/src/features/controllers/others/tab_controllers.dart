

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageTabControllers extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<String> tabs = [
    "All",
    "Newest",
    "Popular",
    
  ];

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

}