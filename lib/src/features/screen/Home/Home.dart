import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/quotes/create_oraah_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import '../../../constants/text_strings.dart';
import '../../controllers/others/deviceSpecController.dart';
import '../../controllers/quotes/quotes_controller.dart';
import '../../controllers/quotes/quotes_image_controller.dart';
import '../../controllers/others/tab_controllers.dart';
import 'home_widgets/home_tab_bar.dart';
import 'home_widgets/quotes_of_the_day.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  
  Widget build(BuildContext context) {
     final quotesController = Get.put(QuotesController());
     final imageController = Get.put(QuotesImageController());
      final tabController = Get.put(PageTabControllers());
      Get.lazyPut(()=> FavoriteController());
      // Get.lazyPut(()=> CreateOraahController());

     final deviceController = Get.put(DeviceSpacController(context));
    final mediaQuey = MediaQuery.of(context);
    final deviceScreenWidth = mediaQuey.size.width;
    final deviceScreenHeight = mediaQuey.size.height;
    // final brightness = mediaQuey.platformBrightness;
    return Scaffold(
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
      const SizedBox(
        height: 10,
      ),

      //?: Quote of the day Section
      Container(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          oXigashoyinka,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),

      QuotesOfTheDay(
          quotesController: quotesController, brightness: deviceController.brightness),
      // SizedBox(
      //   height: 3,
      // ),

      Divider(),
      HomeTabBar(tabController: tabController.tabController, deviceScreenHeight: deviceScreenHeight, deviceScreenWidth: deviceScreenWidth, quotesController: quotesController, brightness: deviceController.brightness, imageController: imageController,tabsList: tabController.tabs,),
      SizedBox(
        height: 5,
      ),

            ],
            // ),
          ),
      // ),
    );
  }
}