import 'dart:developer' as flutter;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:oraah_app/src/constants/api_keys.dart';
import 'package:oraah_app/src/features/model/image/image_model.dart';

class RepositoryApi {
  final dio = Dio();
  final apiKeys = ApiKeys();

  Future<List<PhotosModel>> getImagesFromInternet(
      String query, int pageNum, String apiKey) async {
    List<PhotosModel> images = [];
    try {
      var response = await dio.get(
          "https://api.unsplash.com/search/photos?per_page=$pageNum&client_id=$apiKey&query=$query&urls=small");
      if (response.statusCode != 200) {
        Future.error({
          "error":
              "Something went wrong while fetching image data in: ${response.statusCode}",
          "description": "Error from getting url request"
        });
      }

      images = (response.data['results'] as List).map(((image) {
        return PhotosModel.fromJson(image);
      })).toList();

      return images;
    } on DioException catch (err) {
      flutter.log('Error occurred in getImagesFromInternet: $err', error: err);
      return Future.error({
        "error": "Error while fetching Image from internet $err",
        "description": "Error on getImageFromInternet"
      });
    }
  }

  Future<List<PhotosModel>> getImages(String queryType, int pageNum) async {
    List<PhotosModel> images = [];
    try {
      var response = await dio.get(
          "https://api.unsplash.com/search/photos?per_page=$pageNum&client_id=${apiKeys.quoteApiKeyUnsplash_1}&query=$queryType&urls=small");
      if (response.statusCode != 200) {
        Future.error({
          "error": "Something is wrong from the request ${response.statusCode}",
          "description": "Error from the getting this request"
        });
      }
      images = (response.data['results'] as List).map((image) {
        return PhotosModel.fromJson(image);
      }).toList();

      return images;
    } on DioException catch (e) {
      return Future.error({
        "error": "${e.response}",
        "description": "Error occured while reading images"
      });
    }
  }
}
