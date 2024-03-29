import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/Home.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/controllers/animations/animation_controller.dart';
import 'package:oraah_app/src/features/controllers/auth/auth_controller.dart';
import 'package:oraah_app/src/features/controllers/connection/network_controller.dart';
import 'package:oraah_app/src/features/controllers/others/navigation_controller.dart';
import 'package:oraah_app/src/features/controllers/others/themeController.dart';
import 'package:oraah_app/src/features/controllers/quotes/create_oraah_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_image_controller.dart';
import 'package:oraah_app/src/features/screen/Categories/category_navigations/navigation_layout.dart';
import 'package:oraah_app/src/features/screen/Favorites/favorites_screen.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'package:oraah_app/src/features/screen/others/no_internet_screen.dart';
import 'package:oraah_app/src/features/screen/splash_screen.dart';
import 'package:oraah_app/src/repository/quotes_repo/quotes_repo.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';
import 'src/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<MobileNetworkController>(MobileNetworkController(), permanent: true);
  Get.put<QuotesController>(QuotesController());
  Get.put<QuotesImageController>(QuotesImageController());
  Get.put<UserController>(UserController());
  Get.put<AuthController>(AuthController());

  Get.lazyPut<FavoriteController>(() => FavoriteController());
  Get.lazyPut<QuotesRepository>(() => QuotesRepository());

  Get.lazyPut<NavigationController>(() => NavigationController());

  Get.lazyPut<ThemeController>(() => ThemeController());

  Get.put<CreateOraahController>(CreateOraahController(), permanent: false);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final MobileNetworkController networkController =
        Get.find<MobileNetworkController>();
    return Obx(() {
      return GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/navigation-layout', page: () => NavigationLayout()),
        ],
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: networkController.isConnected
            ? const Splash()
            : const NoInternetScreen(),
      );
    });
  }
}
