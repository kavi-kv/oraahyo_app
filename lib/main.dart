import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/controllers/auth/auth_controller.dart';
import 'package:oraah_app/src/features/controllers/others/navigation_controller.dart';
import 'package:oraah_app/src/features/controllers/others/themeController.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_image_controller.dart';
import 'package:oraah_app/src/features/screen/Categories/category_navigations/navigation_layout.dart';
import 'package:oraah_app/src/features/screen/Favorites/favorites_screen.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'package:oraah_app/src/features/screen/splash_screen.dart';
import 'package:oraah_app/src/repository/quotes_repo/quotes_repo.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';
import 'src/utils/theme/theme.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  
  Get.put<AuthController>(AuthController());
  Get.put<NavigationController>(NavigationController());
  Get.put<QuotesController>(QuotesController());
  Get.put<QuotesImageController>(QuotesImageController());
  Get.put<ThemeController>(ThemeController());
  Get.put<UserController>(UserController());
  Get.put<QuotesRepository>(QuotesRepository());
  await checkInitialLoginStatus();

  // Get.put<FavoriteController>(FavoriteController());
  

  runApp(const MyApp());
}

Future<void> checkInitialLoginStatus() async {
  var authService = AuthService();
  bool isLoggedIn = await authService.validateToken();
  var userController = Get.find<UserController>();
  // if (isLoggedIn) {
    // var userData = await AuthService().getUser();
    // userController.setUser(userData);
    // userController.initializeFavoriteController();
  // }

  userController.setLoggedIn(isLoggedIn);
  userController.setIsLoading(isLoggedIn);
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(() {
      return GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/navigation-layout', page: () => NavigationLayout()),
          // GetPage(
          //     name: '/favorite',
          //     page: () => const FavoriteScreen(),
          //     binding: BindingsBuilder(() {
          //       Get.put(FavoriteController());
          //     }))
        ],
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const Splash(),
      );
    });
  }
}
