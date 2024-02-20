import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_image_controller.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/custom_appbar.dart';

class CustomShiverAppBar extends StatelessWidget {
  const CustomShiverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final quotesController = Get.put(QuotesController());
    final imageController = Get.put(QuotesImageController());
    return CustomAppBar(quotesController: quotesController, imageController: imageController);
  }
}