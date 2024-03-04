import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/model/quotes/quotesModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../repository/quotes_repo/image_repo.dart';
import '../../model/image/image_model.dart';
// import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';

class QuotesImageController extends GetxController {
  QuotesController quotesController = Get.find<QuotesController>();
  RxList<PhotosModel> photos = RxList();
  RxList<PhotosModel> storyPhotos = RxList();
  late final int imagesLength;
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
  List<String> dailyQuoteQueryType = [
    "Moon, Dark, Deep Ocean, Ocean, Cities, Cities, Clouds",
    "Doom, Lonely, Stars, Gallaxy, Streets",
    "Wisdom, Island, Milkway, Deep Sorrow",
  ];

  // int quoteNum = Get.find<QuotesController>().quotes.length;

  Future<void> getStoryImages() async {
    try {
      isLoading.value = true;
      storyPhotos.value = await repository.getImages(queryType.value, 5);
      log("Successfully Fetched Story Quotes: $storyPhotos");
    } catch (error) {
      log("Status Code is ");
    }
    isLoading.value = false;
  }

  Future<void> getPictureData() async {
    try {
      isLoading.value = true;
      await Get.find<QuotesController>().fetchQuotes();
      int quoteNum = Get.find<QuotesController>().quotes.length;
      print("Length of quotes: $quoteNum");
      if (quoteNum > 0) {
        photos.value = await repository.getImages(queryType.value, 27);
        print("length of images ${photos.length}");
      } else {
        log("No quotes available to match number of images");
        print("length of images $photos");
      }
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

  Future<void> captureAndSaveImage(GlobalKey key) async {
    RenderRepaintBoundary? boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary != null) {
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        if (await requestPermission(Permission.storage)) {
          final result = await ImageGallerySaver.saveImage(pngBytes);
          if (result['isSuccess']) {
            Get.snackbar("", "",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.transparent,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
                barBlur: 0.0,
                snackStyle: SnackStyle.GROUNDED,
                margin: const EdgeInsets.all(16.0),
                messageText: const Text(
                  "Successfully image saved to gallary",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ));
          } else {
            Get.snackbar("", "",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.transparent,
                colorText: Colors.white,
                duration: Duration(seconds: 3),
                barBlur: 0.0,
                snackStyle: SnackStyle.GROUNDED,
                margin: EdgeInsets.all(16.0),
                messageText: const Text(
                  "Error!!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ));
          }
        }
      }
    }
  }

  Future<void> captureAndShareImage(GlobalKey key) async {
    RenderRepaintBoundary? boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary != null) {
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        if (await requestPermission(Permission.storage)) {
          // final result = await ImageGallerySaver.saveImage(pngBytes);
          final temp = await getTemporaryDirectory();
          final path = '${temp.path}/image.png';
          print(path);
          File(path).writeAsBytesSync(pngBytes);
          await Share.shareXFiles([XFile(path)],text: 'Image', subject: 'Share Oraah😊');
          
        }
      }
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
    getStoryImages();
    getPictureData();
  }

  @override
  void dispose() {
    super.dispose();
    getPictureData();
    // getStoryImages();
  }
}
