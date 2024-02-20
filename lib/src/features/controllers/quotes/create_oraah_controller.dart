import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oraah_app/src/constants/api_keys.dart';
import 'package:oraah_app/src/features/model/image/image_model.dart';
import 'package:oraah_app/src/repository/quotes_repo/image_repo.dart';

class CreateOraahController extends GetxController {
  var isLoading = true.obs;

  var fsQuote =
      "The best thing to do with the best things in life is to give them up"
          .obs;
  var fsAuthor = "Ambrose Bierce".obs;
  RxList<PhotosModel> images = RxList();
  RxList<String> fontsNames = [
    'Roboto',
    'OpenSans',
    'Lato',
    'Lobster',
    'Fraunces',
    'Lato',
    'GreatVibes',
    'Orbitron',
    'BreeSerif',
    'Prozalibre'
  ].obs;
  RxDouble sliderValue = 16.0.obs;
  RxDouble opacityValue = 0.5.obs;
  Rx<Color> textColor = Colors.white.obs;
  Rx<Color> backgroundColor = Colors.black54.obs;
  RxString fontFamily = 'Roboto'.obs;
  Rx<File?> selectedGalleryImage = Rx<File?>(null);
  RxString searchText = "".obs;
  List<String> data = ['Apple', 'Banana', 'Orange', 'Mango', 'Grapes'];
  RxString searchQuery = "".obs;
  RxList<String> searchResults = <String>[].obs;
  var imageRepo = RepositoryApi();
  RxString queries =
      "Nature,Cat,Palletes,Country Side, Deep Blue Ocean, Lonely".obs;
  final apiKeys = ApiKeys();
  RxString backgorundImage = "".obs;
  RxBool isEditingText = false.obs;
  late TextEditingController textEditingController;
  RxString initialText = "Oraahdada Halkan ku qor.".obs;
  RxBool editorVisibility = true.obs;

  void selectBackgroundImage(String image) {
    isLoading.value = true;
    backgorundImage.value = image;
    isLoading.value = false;
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    selectedGalleryImage.value = File(returnedImage.path);
  }

  void updateSearchQueryString(String newQuery) {
    searchQuery.value = newQuery;
    if (searchQuery.isEmpty) {
      searchResults.clear();
    } else {
      var filteredList = data
          .where((element) =>
              element.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
      searchResults.value = filteredList;
    }
    getInternetImages();
  }

  Future<void> getInternetImages() async {
    try {
      isLoading.value = true;
      if (searchQuery.isEmpty) {
        images.value = await imageRepo.getImagesFromInternet(
            queries.value, 20, apiKeys.quoteApiKeyUnsplash_2);
        log("Internet Images inside Function $images");
       
      }
      else{
        images.value = await imageRepo.getImagesFromInternet(
            searchQuery.value, 20, apiKeys.quoteApiKeyUnsplash_2);
        log("Internet Images inside Function $images");
      
      }
        isLoading.value = false;
      
    } catch (err) {
      log("Error while fetching images(inside createOraah): $err");
    }
  }

  void toggleEditing() {
    isEditingText.value = !isEditingText.value;
    Future.delayed(const Duration(seconds: 2), () {
      editorVisibility.value = !editorVisibility.value;
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInternetImages();
    // log("Internet Images $images");
    textEditingController = TextEditingController(text: initialText.value);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }
}
