import 'dart:math';

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
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();

  RxBool isLoggedIn = false.obs;
  RxBool isLoading = false.obs;

  void checkLoginStatus() async {
    var authService = AuthService();
    isLoggedIn.value = await authService.validateToken();

    isLoading = false.obs;
  }

  void signIn(String email, String pass, BuildContext context) async {
    isLoading.value = true;
    // await Future.delayed(const Duration(seconds: 3));
    await AuthService().signIn(
        email: email,
        password: pass,
        onSuccess: () async {
          var authService = AuthService();
          var userController = UserController();
          bool isLoggedIn = await authService.validateToken();
          if (isLoggedIn) {
            userController.setLoggedIn(isLoggedIn);
          }
          // AuthController.instance.isLoggedIn(isLoggedIn);
          Get.offAll(() => const MainScreen());
          isLoading.value = false;
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

  void getUser(BuildContext context) {
    AuthService().getUser(context: context);
  }

  void validateToken() {
    isLoading.value = true;
    try {
      AuthService().validateToken();
      isLoading.value = false;
    } catch (err) {
      flutter.log("Error Token Validity $err");
      isLoading.value = false;
    }
  }

  void logOut() {
    try {
      isLoading.value = true;
      AuthService().signOut();
      FavoriteController.instance.favorites.clear();
      isLoading.value = false;
    } catch (error) {
      flutter.log('Error on LoginOut: $error');
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }
}
