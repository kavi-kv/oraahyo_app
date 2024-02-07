import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/screen/Auth/login_screen.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';
import 'package:oraah_app/src/utils/utils.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();

  RxBool isLoggedIn = false.obs;
  RxBool isLoading = true.obs;

  void checkLoginStatus() async {
    var authService = AuthService();
    isLoggedIn.value = await authService.validateToken();
    
    isLoading = false.obs;
  
  }

  void signIn(String email, String pass, BuildContext context) async {
    AuthService().signIn(
        email: email,
        password: pass,
        onSuccess: () {
          Get.offAll(() => const MainScreen());
        },
        onError: (message) {
          showSnackBar(context, message);
        });
  }

  void registerUser(
      String email, String password, String name, BuildContext context) {
    AuthService().signUpUser(
        email: email,
        password: password,
        name: name,
        onSuccess: () {
          Get.offAll(() => const LoginScreen());
        },
        onError: (message) {
          showSnackBar(context, message);
        });
  }

  void getUser(BuildContext context){
    AuthService().getUser(context: context);
  }

  void validateToken(){
    AuthService().validateToken();
  }
  void logOut(){
    AuthService().signOut();
  }
}
