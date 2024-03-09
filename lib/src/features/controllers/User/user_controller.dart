import 'dart:developer';

import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import 'package:oraah_app/src/features/model/user/user.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final _isLoggedIn = false.obs;
  RxBool userIsLoading = true.obs;
  final _isLoading = true.obs;
  final Rx<User> _user = User(
    id: '',
    name: '',
    email: '',
    token: '',
    password: '',
    favorites: [],
  ).obs;

  @override
  void onInit() {
    super.onInit();
    log("Insdie UserController");
  }

  //?: -> Getters
  bool get isLoading => _isLoading.value;
  User get user => _user.value;
  bool get isLoggedIn => _isLoggedIn.value;

  //? -> Setters
  setLoggedIn(bool value) => _isLoggedIn.value = value;
  setIsLoading(bool isLogged) => _isLoading.value = isLogged;
  void setUser(String userJson) {
    _user.value = User.fromJson(userJson);
  }

  void setUserFromModel(User user) {
    _user.value = user;
  }
}
