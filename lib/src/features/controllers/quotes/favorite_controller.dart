import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/model/quotes/favoriteModel.dart';
import 'package:oraah_app/src/repository/quotes_repo/quotes_repo.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();
  RxList<FavoriteModel> favorites = <FavoriteModel>[].obs;
  RxBool isLoading = true.obs;
  late final QuotesRepository quotesRepository;
  final userController = UserController();
  RxList<FavoriteModel> favoriteQuotes = <FavoriteModel>[].obs;
  FavoriteController() {
    quotesRepository = Get.find<QuotesRepository>();
  }

  bool isFavorite(String quoteId) {
    return favorites.any((fav) => fav.quoteId == quoteId);
  }

  bool isUserLoggedIn() {
    return userController.user.token.isEmpty || userController.user.id.isEmpty;
  }

  Future readFav(String userId) async {
    isLoading.value = true;
    if (userId.isEmpty) {
      log('Error the is no user available');
      isLoading.value = false;
    }

    try {
      var favData = await quotesRepository.getFavorites(userId);
      // List<FavoriteModel> favModels = favData.map<FavoriteModel>((json) => FavoriteModel.fromJson(json)).toList();
      favorites.value = favData;
      isLoading.value = false;
      log("User ID, In readFav function: $userId");
      log("FavData in readFav func: ${favorites.toJson().toString()}");
    } catch (e) {
      log('Error occurred while fetching favorites: $e');
      isLoading.value = false;
    }
  }

  Future<void> removeFav(quoteId, userId) async {
    try {
      isLoading.value = true;
      var response = await quotesRepository.removeFromFav(quoteId, userId);
      favorites.removeWhere((fav) => fav.id == quoteId);
      isLoading.value = false;
      return response;
    } catch (err) {
      log('Error occurred while fetching favorites: $err');
      isLoading.value = false;
    }
  }

  void addQuotesToFav(String quoteId, String userId, String quotesText,
      String imageUrl, String author) async {
    isLoading.value = true;
    try {
      FavoriteModel newFavorite = (await quotesRepository.addToFav(
        quoteId: quoteId,
        userId: userId,
        quoteTxt: quotesText,
        imgUrl: imageUrl,
        author: author,
      ));

      favorites.add(newFavorite);
      isLoading.value = false;
    } catch (error) {
      log("Error while fetching quotes $error");
      isLoading.value = false;
    }
  }

  Future readFavById(String favId) async {
    try {
      isLoading.value = true;
      if (UserController.instance.user.id != '' ||
          UserController.instance.user.id.isNotEmpty) {
        var res = await quotesRepository.getFavoritesById(favId);
        favoriteQuotes.value = res;
      }
    } catch (error) {
      log('Error for reading favorite by ID: $error');
    }
  }

  @override
  void onInit() {
    super.onInit();
    log("Inside FavScreen");
    String userId = UserController.instance.user.id;
    String userIdE = userController.user.id;
    if (userId.isNotEmpty) {
      log("UserId in favController: $userId");
      readFav(userId).then((_) => isLoading.value = false);
      log("Favorite Data: ${favorites.toJson().toString()}");
    }
    isLoading.value = false;
  }
}
