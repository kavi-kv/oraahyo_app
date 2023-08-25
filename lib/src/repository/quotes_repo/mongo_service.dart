// import 'package:get/get.dart';
// import 'package:mongo_dart/mongo_dart.dart';

// class MongoService extends GetxController {
//   late Db _db;

//   Future<void> ConnectToDb() async {
//     _db = await Db.create('mongodb+srv://kavifirdou:upDUvKRDlRO6iFHN@cluster0.of2oym2.mongodb.net/oraahyo?retryWrites=true&w=majority');
//     await _db.open();
//   }

//   Future<List<Map<String, dynamic>>> getDocuments(String collectionName) async {
//   final collection = _db.collection(collectionName);
//   final cursor = collection.find();
//   return await cursor.toList();
// }
// }

