import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/model/user/user.dart';
import 'package:oraah_app/src/features/screen/Auth/login_screen.dart';
import 'package:oraah_app/src/features/screen/Auth/registration.dart';
import 'package:oraah_app/src/services/api/auth_services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var userController = Get.find<UserController>();
    var authService = AuthService();

    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(
              child: Lottie.asset("assets/lottie/splash.json", height: 30)),
          Text(
            "⭕raahyo",
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      ),
      duration: 3000,
      splashIconSize: 200,
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      backgroundColor: isDark ? Colors.black : Colors.white,
      nextScreen: FutureBuilder<bool>(
        future: authService.validateToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width:
                    50.0, 
                height:
                    50.0,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  strokeWidth: 5.0,
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            print('Error validating token: ${snapshot.error}');
            return const LoginScreen(); // or some error screen
          }

          if (snapshot.data == true) {
            return const MainScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
