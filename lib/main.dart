import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/navigation_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes_image_controller.dart';
import 'package:oraah_app/src/features/screen/Categories/category_navigations/navigation_layout.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'src/utils/theme/theme.dart';

void main() async {

  Get.put<NavigationController>(NavigationController());
  Get.put<QuotesController>(QuotesController());
  Get.put<QuotesImageController>(QuotesImageController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      initialRoute: '/',
      getPages: [

        GetPage(name: '/navigation-layout', page: ()=> NavigationLayout()),
      ],

      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home:  const MainScreen(),
    );
  }
}

