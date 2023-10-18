import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oraah_app/src/common_widgets/api_address.dart';
import 'package:oraah_app/src/features/model/quotes/authorsModel.dart';
import 'package:oraah_app/src/features/model/quotes/quotesModel.dart';
import 'package:oraah_app/src/repository/DI/dependancy_injection.dart';
import 'package:get/get.dart';

class QuotesRepository {
  final dio = Dio();
  // final DependencyInjection depIn;
  // QuotesRepository() : depIn = Get.find<DependencyInjection>();
  final urlEndPoints = WIpV4;
  // final urlEndPoints = EthIpV4;

  Future<List<QuoteModel>> fetchQuotes() async {
    List<QuoteModel> quotes = [];
    try {
      var response = await dio.get("http://$urlEndPoints:5005/xikmado/quotes");

      if (response.statusCode != 200) {
        Future.error({
          "error": "Something went wrong ${response.statusCode}",
          "description": "There is an error for getting the request!"
        });
      }

      quotes = (response.data as List).map((quote) {
        return QuoteModel.fromJson(quote);
      }).toList();

      // print("Data is: ${quotes}");
      // print("The Connection Type is ${depIn}");
      return quotes;
    } on DioException catch (err) {
      return Future.error({
        "error": "${err.response}",
        "description": "An unknown error ocurred"
      });
    }
  }

  Future<List<QuoteModel>> byCategory(String category) async {
    List<QuoteModel> quotes = [];
    try {
      var response =
          await dio.get("http://$urlEndPoints:5005/xikmado/byCategory/$category");
      if (response.statusCode != 200) {
        Future.error({
          "error": "Something went unexpected ${response.statusCode}",
          "description": "Unknown error ocurred"
        });
      }

      quotes = (response.data as List).map((quote) {
        return QuoteModel.fromJson(quote);
      }).toList();

      return quotes;

    } on DioException catch (error) {
      return Future.error({
        "error": "Error is ${error.response}",
        "description": "Unknown error ocurred"
      });
    }
  }

  Future<List<QuoteModel>> byAuthor(String author) async {
    List<QuoteModel> quotes = [];
    try{
      var response = await dio.get("http://$urlEndPoints:5005/xikmado/byAuther/$author");
      if(response.statusCode != 200) {
        return Future.error({
          "error": "Error: ${response.statusCode}",
          "description": "Unknown error occured"
        });

      }
      quotes = (response.data as List).map((quote) {
        return QuoteModel.fromJson(quote);
      }).toList();

      
      return quotes;
    }
    on DioException catch(error) {
      return Future.error({
        "error": "Error is ${error.response}",
        "description": "Unknown fatal error"
      });
    }
  }

  Future<List<AuthorsModel>> authorsList() async {
    List<AuthorsModel> authors = [];
    try{
      final response = await dio.get("http://$urlEndPoints:5005/xikmado/authorsList");
      if(response.statusCode != 200) {
        return Future.error({
          "error": "Internal error occured ${response.statusCode}" ,
          "description": "Unknown fatal external error!"
        });
      }

      authors = (response.data as List).map((data) {
        return AuthorsModel.fromJson(data);
      }).toList();
      return authors;
    }
    on DioException catch(err) {
      return Future.error({
        "error": "Error is $err.response",
        "description": "Unknown erros"
      });
    }
  }

  Future<bool> isCategoryExists() async {
    final bool isExist ;
    try{
      final response = await dio.get("http://$urlEndPoints:5005/xikmado/isCatExist/Farxad");
      if(response.statusCode != 200){
        return Future.error({
          "error": "Internal error occured ${response.statusCode}" ,
          "description": "Unknown fatal external error!"
        });
      }
      else{
        final responseData = response.data;

        if(responseData["Exists"] == true){
          isExist = true;
        }
        else{
          isExist = false;
        }
      }

      return isExist;
    }
    on DioException catch(er){
      return Future.error({
        "error": "Error is $er.response",
        "description": "Unknown erros"
      });
    }
  }

}
