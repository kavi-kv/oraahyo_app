import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/others/navigation_controller.dart';
import 'package:oraah_app/src/features/controllers/others/themeController.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_image_controller.dart';
import 'package:oraah_app/src/features/screen/Categories/category_navigations/navigation_layout.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'package:oraah_app/src/features/screen/splash_screen.dart';
import 'package:oraah_app/src/repository/DI/dependancy_injection.dart';
import 'src/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.setUp();
  DependencyInjection.init();
  Get.put<NavigationController>(NavigationController());
  Get.put<QuotesController>(QuotesController());
  Get.put<QuotesImageController>(QuotesImageController());
  Get.put<ThemeController>(ThemeController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/navigation-layout', page: () => NavigationLayout()),
      ],
      
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
