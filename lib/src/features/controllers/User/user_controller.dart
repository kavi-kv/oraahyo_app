import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import 'package:oraah_app/src/features/model/user/user.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final _isLoggedIn = false.obs;
  RxBool userIsLoading = true.obs;
  final _isLoading = true.obs;
  final Rx<User> _user = User(
    id: '',
    name: '',
    email: '',
    token: '',
    password: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    // print("Islaoding=> $isLoading");
  }

  User get user => _user.value;

  // void initializeFavoriteController(){
  //   if(user.id.isNotEmpty){
  //      Get.put<FavoriteController>(FavoriteController());
  //   }
  // }

  void setUser(String userJson) {
    _user.value = User.fromJson(userJson);
  }

  bool get isLoading => _isLoading.value;

  setLoggedIn(bool value) => _isLoggedIn.value = value;
  bool get isLoggedIn => _isLoggedIn.value;

  setIsLoading(bool isLogged) => _isLoading.value = isLogged;

  void setUserFromModel(User user) {
    _user.value = user;
  }
}
