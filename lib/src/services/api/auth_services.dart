import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:oraah_app/src/constants/constant.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/model/user/user.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/screen/Auth/registration.dart';
import 'package:oraah_app/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = Dio();

   Future<void> signUpUser({
    // required BuildContext context,
    required String email,
    required String password,
    required String name,
    required VoidCallback onSuccess,
    required Function(String) onError
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        token: '',
      );

      var response = await dio.post(
        '${Constants.uri}/api/signup',
        data: user.toJson(),
        options: Options(contentType: Headers.jsonContentType),
      );

      if(response.statusCode == 200) {
        onSuccess();
      }
      else{
        onError('Error: ${response.statusCode}');
      }

    } catch (e) {
      print('Error: ${e.toString()}');
      onError(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required Function(String) onError
  }) async {
    try{
      var response = await dio.post('${Constants.uri}/api/signin',
        data: {
          'email': email,
          'password': password
        },
        options: Options(contentType: Headers.jsonContentType),
        );

        if(response.statusCode == 200){
          var result = jsonEncode(response.data);
          var userController = Get.find<UserController>();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userController.setUser(result);
          await prefs.setString('x-auth-token', response.data['token']);
          onSuccess();
        } 
        
    } on DioException catch(e){
      if(e.response?.statusCode == 400){
        onError(e.response?.data['msg']);
      }
      else{
        onError(e.message ?? "Uknown Dio Error");
      }
    }
    catch(e){
       print('Error: ${e.toString()}');
      onError(e.toString());
    }
  }

 
  void getUser({required BuildContext context}) async {
    try {
      var userController = Get.find<UserController>();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

    
      var tokenRes  = await dio.post(
        '${Constants.uri}/tokenIsValid',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'x-auth-token': token!,
          },
        ),
      );

      var response = tokenRes.data;
   
      if(response == true){
        var userRes = await dio.get(
          '${Constants.uri}/',
          options: Options(
            contentType: Headers.jsonContentType,
            headers: {'x-auth-token': token},
          )
        );
        userController.setUser(jsonEncode(userRes.data));
      }

    } catch (e) {
      print('getUser Error: ${e.toString()}');
      showSnackBar(context, e.toString());
    }
}

Future<bool> validateToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    if (token == null) return false;

    try {
      var response = await dio.post(
        '${Constants.uri}/tokenIsValid',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'x-auth-token': token,
          },
        ),
      );
      return response.data == true; // Assuming the server returns true for a valid token
    } catch (e) {
      print('validationTokenError Error: ${e.toString()}');
      return false;
    }
  }
}



void signOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('x-auth-token', '');
  Get.offAll(()=> Registration());
}


