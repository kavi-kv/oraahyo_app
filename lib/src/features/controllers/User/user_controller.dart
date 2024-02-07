import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import 'package:oraah_app/src/features/model/user/user.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final _isLoggedIn = false.obs;
  final _isLoading = true.obs;
  final Rx<User> _user = User(
    id: '',
    name: '',
    email: '',
    token: '',
    password: '',
  ).obs; 
  
  User get user => _user.value;

  // void initializeFavoriteController(){
  //   if(user.id.isNotEmpty){
  //      Get.put<FavoriteController>(FavoriteController());
  //   }
  // }


  void setUser(String userJson) {
    _user.value = User.fromJson(userJson);
  }

  

  setLoggedIn(bool value) => _isLoggedIn.value = value;
  bool get isLoggedIn => _isLoggedIn.value;

  setIsLoading(bool isLogged){
    if(isLoggedIn){
      _isLoading.value = false;
    }
  }
  bool get isLoading => _isLoading.value;

  void setUserFromModel(User user) {
    _user.value = user;
  }

}
