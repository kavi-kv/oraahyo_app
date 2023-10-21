import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});
  
  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == 'dark';
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(child: Lottie.asset("assets/lottie/splash.json",height: 30)),
          Text("⭕raahyo",style: Theme.of(context).textTheme.titleSmall,)
        ],
      ),
      duration: 3000,
      splashIconSize: 200,
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      backgroundColor: isDark ? Colors.black : Colors.white,
      nextScreen: const MainScreen(),
    );
  }
}
