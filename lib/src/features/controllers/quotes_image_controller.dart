import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/quotes_controller.dart';
import 'package:oraah_app/src/features/model/quotes/quotesModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../repository/dio_service.dart';
import '../model/image/image_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class QuotesImageController extends GetxController {
  RxList<PhotosModel> photos = RxList();

  RxBool isLoading = true.obs;
  RxString orderBy = "popular".obs;
  RxString queryType = "nature,dark nature, waterfalls, deep sorrow".obs;
  RxString apikey = "higK4AkKDQaXPNjFwUPY5yKHH-IEG8KVc1n3yD9v9QM".obs;
  var selectedIndex = 0.obs;
  // late List<GlobalKey> containerKeys = List.generate(photos.length, (index) => GlobalKey());
  List<String> orders = [
    "latest",
    "popular",
    "oldest",
    "views",
  ];

  void saveImgToGalary(ScreenshotController screenshotController) async {
    Uint8List? image = await screenshotController.capture();

    if(image != null){
      saveImg(image!);
    }

  }

  saveImg(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'orahyo_$time';
    await requestPermission(Permission.storage);
    final result = await ImageGallerySaver.saveImage(bytes,name: name);
    if(result["isSuccess"]){
      Get.snackbar(
          "",
          "",
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
          )
      );
    }
  }

  Future<bool> requestPermission(Permission permission) async {
    if(await permission.isGranted){
      return true;
    }
    else{
      var result = await permission.request();
      if(result == PermissionStatus.granted) {
        return true;
      }
    }


    return false;
  }




  //   Get.snackbar(
  //     'Download Success',
  //     'Image and quote text downloaded successfully!',
  //     backgroundColor: Colors.green,
  //     colorText: Colors.white,
  //   );


  /// Get Picture
  Future<void> getPictureData({void Function(String, dynamic)? action}) async {
    isLoading.value = true;
    var response = await DioService().getMethod(
        "https://api.unsplash.com/search/photos?per_page=17&client_id=higK4AkKDQaXPNjFwUPY5yKHH-IEG8KVc1n3yD9v9QM&query=${queryType.value}&urls=small");
    photos = RxList();
    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        photos.add(PhotosModel.fromJson(element));
      });
      isLoading.value = false;
    }

    // log("Status Code is "+response.statusCode.toString());
  }

  /// changing order value
  ordersFunc(String newVal) {
    orderBy.value = newVal;
    getPictureData();
  }

  @override
  void onInit() {
    super.onInit();
    getPictureData();
  }

  @override
  void dispose() {
    super.dispose();
    getPictureData();
  }
}
