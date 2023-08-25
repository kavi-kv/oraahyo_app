
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class DioService {

  Future<dynamic> getMethod(String url , {void Function(String, dynamic)? action}) async {
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      // log(response.toString());
      return response;
    });
  }

  // Future<dynamic> getImages(String url, {void Function(String, dynamic)? action}) async {
  //   try{
  //     final response = await http.get(Uri.parse(url));

  //     if(response.statusCode == 200){
  //       print("Success ${response.body}");

  //     }
  //     if (action != null) {
  //         action(response.body, null);
  //        return response;
  //   } else{
  //     print('Request failed with status code: ${response.statusCode}');
  //     return null;
  //   }

  //   } catch(error){
  //     print("Error is ${error}");
  //     return null;
  //   }
  // } 
  
}