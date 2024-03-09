import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:oraah_app/src/common_widgets/api_address.dart';
import 'package:oraah_app/src/constants/constant.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/controllers/connection/network_controller.dart';
import 'package:oraah_app/src/features/model/user/user.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/screen/Auth/login_screen.dart';
import 'package:oraah_app/src/features/screen/Auth/registration.dart';
import 'package:oraah_app/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = Dio();
  String url = Get.find<MobileNetworkController>().ulr;
  // final urlEndPoints = WIpV4;

  Future<void> signUpUser(
      {
      // required BuildContext context,
      required String email,
      required String password,
      required String name,
      required VoidCallback onSuccess,
      required Function(String) onError}) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        token: '',
      );

      var response = await dio.post(
        '$url/api/signupAsUser',
        data: user.toJson(),
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        onSuccess();
      } else {
        onError('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      onError(e.toString());
    }
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required VoidCallback onSuccess,
      required Function(String) onError}) async {
    try {
      var response = await dio.post(
        '$url/api/signinAsUser',
        data: {'email': email, 'password': password},
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        var result = jsonEncode(response.data);
        var userController = Get.find<UserController>();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userController.setUser(result);
        await prefs.setString('x-auth-token', response.data['token']);
        onSuccess();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        onError(e.response?.data['msg']);
      } else {
        onError(e.message ?? "Uknown Dio Error");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      onError(e.toString());
    }
  }

  Future<bool> tokenValidy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    if (token == null) return false;

    try {
      var response = await dio.post(
        '$url/tokenIsValid',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'x-auth-token': token,
          },
        ),
      );
      return response.data == true;
    } catch (e) {
      log('validationTokenError Error: ${e.toString()}');
      return false;
    }
  }

  void validateAndFetchUser() async {
    try {
      var userController = Get.find<UserController>();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) return;

      bool tokenRes = await tokenValidy();
      log('Token: $tokenRes');
      var response = tokenRes;

      if (response == true) {
        var userRes = await dio.get('$url/',
            options: Options(
              contentType: Headers.jsonContentType,
              headers: {'x-auth-token': token},
            ));
        userController.setUser(jsonEncode(userRes.data));
      }
    } catch (e) {
      log('getUser Error: ${e.toString()}');
    }
  }

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('x-auth-token', '');
    Get.offAll(() => const LoginScreen());
  }
}
