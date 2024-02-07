import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/model/quotes/favoriteModel.dart';
import 'package:oraah_app/src/repository/quotes_repo/quotes_repo.dart';

class FavoriteController extends GetxController {
  RxList<FavoriteModel> favorites = <FavoriteModel>[].obs;
  RxBool isLoading = true.obs;
  late final QuotesRepository quotesRepository;
  final userController = Get.find<UserController>();
  // UserController get userController => Get.find<UserController>();
  // final userController = Get.find<UserController>();
  FavoriteController() {
    quotesRepository = Get.find<QuotesRepository>();
    // userController = Get.find<UserController>();
  }

  bool isFavorite(String quoteId) {
    return favorites.any((fav) => fav.quoteId == quoteId);
  }

  Future readFav(String userId) async {
    if (userId.isEmpty) {
      print('Error the User Id is empty');
      return;
    }
    try {
      isLoading.value = true;
      var favData = await quotesRepository.getFavorites(userId);
      // List<FavoriteModel> favModels = favData.map<FavoriteModel>((json) => FavoriteModel.fromJson(json)).toList();
      favorites.value = favData;
      isLoading.value = false;
      print("User ID, In readFav function: $userId");
      print("FavData in readFav func: ${favorites.toJson().toString()}");
    } catch (e) {
      print('Error occurred while fetching favorites: $e');
      // Handle the error appropriately
    }
  }

  Future removeFav(quoteId, userId) async {
    try {
      isLoading.value = true;
      var response = await quotesRepository.removeFromFav(quoteId, userId);
      favorites.removeWhere((fav) => fav.id == quoteId);
      isLoading.value = false;
      // return response;
    } catch (err) {
      isLoading.value = false;
      print('Error occurred while fetching favorites: $err');
    }
  }

  void addQuotesToFav(
      String quoteId,String userId, String quotesText, String imageUrl, String author) async {
    FavoriteModel newFavorite = (await quotesRepository.addToFav(
      quoteId: quoteId,
      userId: userId,
      quoteTxt: quotesText,
      imgUrl: imageUrl,
      author: author,
    ));

    favorites.add(newFavorite);
  }

  @override
  void onInit() {
    super.onInit();
    print("Inside FavScreen");
    String userId = userController.user.id;
    if (userId.isNotEmpty) {
      print("UserId in favController: ${userController.user.id}");
      readFav(userController.user.id).then((_) => isLoading.value = false);
      print("Favorite Data: ${favorites.toJson().toString()}");
    }
  }
}
