import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oraah_app/src/features/controllers/connection/network_controller.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No internet connection!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.find<MobileNetworkController>().checkConnectivity(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
