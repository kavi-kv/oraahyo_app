import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:oraah_app/src/features/model/image/image_model.dart';

class RepositoryApi {
  final dio = Dio();

  Future<List<PhotosModel>> getImages(String queryType) async {
    List<PhotosModel> images = [];
    try {
      var response = await dio.get(
          "https://api.unsplash.com/search/photos?per_page=25&client_id=higK4AkKDQaXPNjFwUPY5yKHH-IEG8KVc1n3yD9v9QM&query=$queryType&urls=small");
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
