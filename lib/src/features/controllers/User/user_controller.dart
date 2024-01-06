import 'package:get/get.dart';
import 'package:oraah_app/src/features/model/user/user.dart';

class UserController extends GetxController {
  // static UserController get instance => Get.find();
  final Rx<User> _user = User(
    id: '',
    name: '',
    email: '',
    token: '',
    password: '',
  ).obs; 

  User get user => _user.value;

  void setUser(String userJson) {
    _user.value = User.fromJson(userJson);
  }

  void setUserFromModel(User user) {
    _user.value = user;
  }
}
