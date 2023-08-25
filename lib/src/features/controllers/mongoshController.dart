
// import 'package:get/get.dart';
// import 'package:oraahyo_app/src/repository/quotes_repo/mongo_service.dart';

// class MongoshController extends GetxController {
//   final MongoService mongoService = Get.find<MongoService>();

//   final dataLits = <Map<String, dynamic>>[].obs;

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     fetchData();
//     super.onInit();
//   }


//   Future<void> fetchData() async {
//     final document = await mongoService.getDocuments("quotes_with_no_auther");
//     dataLits.assignAll(document);
//   }



// }