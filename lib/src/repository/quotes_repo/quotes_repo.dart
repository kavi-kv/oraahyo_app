import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oraah_app/src/common_widgets/api_address.dart';
import 'package:oraah_app/src/constants/constant.dart';
import 'package:oraah_app/src/features/controllers/connection/network_controller.dart';
import 'package:oraah_app/src/features/model/quotes/authorsModel.dart';
import 'package:oraah_app/src/features/model/quotes/favoriteModel.dart';
import 'package:oraah_app/src/features/model/quotes/quotesModel.dart';
// import 'package:oraah_app/src/repository/DI/dependancy_injection.dart';
import 'package:get/get.dart';

class QuotesRepository {
  final dio = Dio();

  // final urlEndPoints = NetworkController().connectivtyType;
  // final urlEndPoints = EthIpV4;
  // final urlEndPoints = WIpV4;
  String url = Get.find<MobileNetworkController>().ulr;

  Future<List<QuoteModel>> fetchQuotes() async {
    List<QuoteModel> quotes = [];
    try {
      var response = await dio.get("$url/xikmado/quotes");

      if (response.statusCode != 200) {
        Future.error({
          "error": "Something went wrong ${response.statusCode}",
          "description": "There is an error for getting the request!"
        });
      }

      quotes = (response.data as List).map((quote) {
        return QuoteModel.fromJson(quote);
      }).toList();

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
      var response = await dio
          .get("$url/xikmado/byCategory/$category");
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
    try {
      var response =
          await dio.get("$url/xikmado/byAuther/$author");
      if (response.statusCode != 200) {
        return Future.error({
          "error": "Error: ${response.statusCode}",
          "description": "Unknown error occured"
        });
      }
      quotes = (response.data as List).map((quote) {
        return QuoteModel.fromJson(quote);
      }).toList();

      return quotes;
    } on DioException catch (error) {
      return Future.error({
        "error": "Error is ${error.response}",
        "description": "Unknown fatal error"
      });
    }
  }

  Future<List<AuthorsModel>> authorsList() async {
    List<AuthorsModel> authors = [];
    try {
      final response =
          await dio.get("$url/xikmado/authorsList");
      if (response.statusCode != 200) {
        return Future.error({
          "error": "Internal error occured ${response.statusCode}",
          "description": "Unknown fatal external error!"
        });
      }

      authors = (response.data as List).map((data) {
        return AuthorsModel.fromJson(data);
      }).toList();
      return authors;
    } on DioException catch (err) {
      return Future.error(
          {"error": "Error is $err.response", "description": "Unknown erros"});
    }
  }

  Future<bool> isCategoryExists() async {
    final bool isExist;
    try {
      final response =
          await dio.get("$url/xikmado/isCatExist/Farxad");
      if (response.statusCode != 200) {
        return Future.error({
          "error": "Internal error occured ${response.statusCode}",
          "description": "Unknown fatal external error!"
        });
      } else {
        final responseData = response.data;

        if (responseData["Exists"] == true) {
          isExist = true;
        } else {
          isExist = false;
        }
      }

      return isExist;
    } on DioException catch (er) {
      return Future.error(
          {"error": "Error is $er.response", "description": "Unknown erros"});
    }
  }

  //? : Favorite

  Future<void> removeFromFav(quoteId, userId) async {
    try {
      var response =
          await dio.delete('$url/api/removeFav/$quoteId/$userId');
      if (response.statusCode != 200) {
        throw Exception(
            'Error from removing favorites: ${response.statusCode}');
      }
      return response.data;
    } catch (error) {
      if (kDebugMode) {
        print('Error: ${error.toString()}');
      }
    }
  }

  Future<List<FavoriteModel>> getFavorites(String userId) async {
    try {
      var response = await dio.get('$url/api/readFav/$userId');
      if (response.statusCode != 200) {
        throw Exception('Error fetching favorites: ${response.statusCode}');
      }
      List<dynamic> responseData = response.data;


      List<FavoriteModel> favQuotes = responseData.map((quoteData) {
        return FavoriteModel.fromJson(Map<String, dynamic>.from(quoteData));
      }).toList();

      return favQuotes;
    } on DioException catch (error) {
      throw Exception('Dio error: ${error.message}');
    }
  }

  Future<FavoriteModel> addToFav({
    required String quoteId,
    required String userId,
    required String quoteTxt,
    required String imgUrl,
    required String author,
  }) async {
    try {
      FavoriteModel fav = FavoriteModel(
          id: '', quoteTxt: quoteTxt, imgUrl: imgUrl, author: author, quoteId: quoteId);

      var response = await dio.post(
        '$url/api/addfav',
        data: {'quoteId': quoteId, 'userId': userId, ...fav.toJson()},
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        return FavoriteModel.fromJson(response.data);
      } else {
        throw Exception('Error on adding to favorites: ${response.statusCode}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: ${error.toString()}');
      }

      throw Exception('Error on Adding quote to fav');
    }
  }
}
