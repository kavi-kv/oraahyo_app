import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/constants/color.dart';
import 'package:oraah_app/src/constants/color.dart';
import 'package:oraah_app/src/constants/color.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/model/user/user.dart';
import 'package:oraah_app/src/features/screen/Auth/login_screen.dart';
import 'package:oraah_app/src/features/screen/Auth/registration.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "⭕raahyo",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: isDark ? tWhiteSnow : tDarkPurple),
            ),
            const SizedBox(
              height: 10,
            ),
            LoadingAnimationWidget.flickr(
              size: 40,
              leftDotColor: Colors.red,
              rightDotColor: Colors.blue,
            ),
          ],
        ),
        duration: 2000,
        splashIconSize: 200,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRight,
        backgroundColor: isDark ? tDarkPurple : tBabbyPowder,
        nextScreen: const MainScreen());
  }
}
