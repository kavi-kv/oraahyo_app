import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import 'package:oraah_app/src/features/screen/Auth/login_screen.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';
import 'package:oraah_app/src/utils/utils.dart';
import 'dart:developer' as flutter;

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  // final favoriteController = FavoriteController();
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();

  RxBool isLoggedIn = false.obs;
  RxBool isLoading = false.obs;
  var authService = AuthService();
  var userController = Get.find<UserController>();

  void checkIsUserLoggedIn() async {
    try {
      userController.userIsLoading.value = true;
      bool isLoggedIn = await authService.tokenValidy();
      if (isLoggedIn) {
        userController.setLoggedIn(isLoggedIn);
      }
      userController.setIsLoading(false);
      log("Inside checkInLogin: => $isLoggedIn");
    } catch (err) {
      log("Error on checking token validty");
    }
  }

  void signIn(String email, String pass, BuildContext context) async {
    isLoading.value = true;
    // await Future.delayed(const Duration(seconds: 3));
    await AuthService().signIn(
        email: email,
        password: pass,
        onSuccess: () async {
          // var userController = UserController();
          UserController.instance.setLoggedIn(true);
          Get.offAll(() => const MainScreen());
          FavoriteController.instance.readFav(userController.user.id);
          isLoading.value = false;
          log('Inside SigIn function: [Is Logged in is =>] ${UserController.instance.isLoggedIn}');
        },
        onError: (message) {
          showSnackBar(context, message);
          isLoading.value = false;
        });
  }

  void registerUser(
      String email, String password, String name, BuildContext context) {
    isLoading.value = true;
    AuthService().signUpUser(
        email: email,
        password: password,
        name: name,
        onSuccess: () {
          Get.offAll(() => const LoginScreen());
          isLoading.value = false;
        },
        onError: (message) {
          showSnackBar(context, message);
          isLoading.value = false;
        });
  }

  void getUser() async {
    try {
      isLoading.value = true;
      AuthService().validateAndFetchUser();
      bool checkIfUserIsLoggedIn = await AuthService().tokenValidy();
      userController.setLoggedIn(checkIfUserIsLoggedIn);
      isLoading.value = false;
      userController.userIsLoading(false);
    } catch (error) {
      log('Error on getting userDetails');
      isLoading.value = false;
      userController.userIsLoading(false);
    }
  }

  // void validateToken() {
  //   isLoading.value = true;
  //   try {
  //     AuthService().validateToken();
  //     isLoading.value = false;
  //   } catch (err) {
  //     flutter.log("Error Token Validity $err");
  //     isLoading.value = false;
  //   }
  // }

  void logOut() {
    try {
      isLoading.value = true;
      AuthService().signOut();
      FavoriteController.instance.favorites.clear();
      log('Favorites Data: ${FavoriteController.instance.favoriteQuotes.length}');
      // log('Favorites List (Inside Logout): ${favoriteController.favorites.length} ');
      isLoading.value = false;
      
    } catch (error) {
      flutter.log('Error on LoginOut: $error');
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUser();
  }
}
