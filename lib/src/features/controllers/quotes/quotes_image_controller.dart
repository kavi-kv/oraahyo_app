import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/model/quotes/quotesModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../repository/quotes_repo/dio_service.dart';
import '../../model/image/image_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class QuotesImageController extends GetxController {
  QuotesController quotesController = Get.find<QuotesController>();
  RxList<PhotosModel> photos = RxList();
  late final int imagesLength ;
  RxBool isLoading = true.obs;
  RxString orderBy = "popular".obs;
  RxString queryType = "nature,dark nature, waterfalls, deep sorrow".obs;
  RxString apikey = "higK4AkKDQaXPNjFwUPY5yKHH-IEG8KVc1n3yD9v9QM".obs;
  var selectedIndex = 0.obs;
  var repository = RepositoryApi();
  List<String> orders = [
    "latest",
    "popular",
    "oldest",
    "views",
  ];

  Future<void> getPictureData() async {
    try {
      isLoading.value = true;
      photos.value = await repository.getImages(queryType.value, 30);
    } catch (e) {
      print("error us $e");
    }
    isLoading.value = false;
    // log("Status Code is "+response.statusCode.toString());
  }

  /// changing order value
  ordersFunc(String newVal) {
    orderBy.value = newVal;
    getPictureData();
  }

  void saveImgToGalary(ScreenshotController screenshotController) async {
    try {
      Uint8List? image = await screenshotController.capture();

      if (image != null) {
        saveImg(image);
      }
    } catch (err) {
      print("The error is $err");
    }
  }

  saveImg(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'orahyo_$time';
    await requestPermission(Permission.storage);
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    if (result["isSuccess"]) {
      print("Successfully captured");
      Get.snackbar("", "",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.transparent,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          barBlur: 0.0,
          snackStyle: SnackStyle.GROUNDED,
          margin: EdgeInsets.all(16.0),
          messageText: const Text(
            "image saved to gallary",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ));
    } else {
      print("Error for capturing image");
      Get.snackbar("", "",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.transparent,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          barBlur: 0.0,
          snackStyle: SnackStyle.GROUNDED,
          margin: EdgeInsets.all(16.0),
          messageText: const Text(
            "Error",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ));
    }
  }

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }

    return false;
  }

  @override
  void onInit() {
    super.onInit();
    imagesLength = quotesController.quotes.length;
    getPictureData();
  }

  @override
  void dispose() {
    super.dispose();
    getPictureData();
  }
}
