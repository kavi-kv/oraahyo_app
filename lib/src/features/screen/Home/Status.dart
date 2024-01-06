
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oraah_app/src/features/controllers/others/deviceSpecController.dart';


class CreateOraah extends StatelessWidget {
  const CreateOraah({super.key});

  @override
  Widget build(BuildContext context) {
     final deviceController = DeviceSpacController(context);
    bool isDarkMode = deviceController.brightnessLight == Brightness.dark;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              isDarkMode 
              ? 'assets/lottie/coming-soon-dark.json'
              : 'assets/lottie/coming-soon.json',
              width: MediaQuery.of(context).size.width * 0.85,
            ),
          ),
        ],
      ),
    );
  }
}