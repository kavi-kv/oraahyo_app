import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../controllers/deviceSpecController.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../controllers/quotes_controller.dart';
import '../../../controllers/quotes_image_controller.dart';
import '../../Home/home_widgets/quotes_card.dart';

class NavigationLayout extends StatelessWidget {
  NavigationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final QuotesController _quotesController = Get.find<QuotesController>();
    final QuotesImageController _quotesImageController =
        Get.find<QuotesImageController>();
    final deviceSpacController = Get.put(DeviceSpacController(context));
    final height = deviceSpacController.deviceHeight * 0.98;
    double width = deviceSpacController.deiceWidth * 0.95;
    final selectedRoute = Get.find<NavigationController>().selectedRoute.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedRoute),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.arrow_left)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: GetBuilder<NavigationController>(
        builder: (controller) {
          final route = Get.find<NavigationController>().selectedRoute.value;

        switch (route) {
          case "Authers":
            return SizedBox(
              height: deviceSpacController.deviceHeight * 0.95,
              // width: deviceSpacController.deiceWidth * 0.85,
              child: ListView.builder(
                itemCount: _quotesController.quotes.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Container(
                        width: width,
                        child: QuotesCard(
                          index: index,
                          imageController: _quotesImageController,
                          quotesController: _quotesController,
                          deviceScreenHeight: height,
                          deviceScreenWidth: width,
                          // imageUrl: _quotesImageController.photos[index].urls?["small"],
                        ),
                      ),
                    )),
              ),
            );
          case "Happy":
            return Container(
              child: Text("Happy Page"),
            );
          case "Strugle":
            return Container(
              child: Text("Strugle Page"),
            );
          case "Mood":
            return Container(
              child: Text("Mood Page"),
            );
          case "Life":
            return Container(
              child: Text("life Page"),
            );
          case "Motivations":
            return Container(
              child: Text("Motivations Page"),
            );
          case "Graduations":
            return Container(
              child: Text("Graduations Page"),
            );
          case "Wisdom":
            return Container(
              child: Text("Wisdom Page"),
            );
          case "Travel":
            return Container(
              child: Text("Travel Page"),
            );
          case "War":
            return Container(
              child: Text("War Page"),
            );
          default:
            return Container(
              child: Text("Default"),
            );
        }
        },
      )
    );
  }
}
