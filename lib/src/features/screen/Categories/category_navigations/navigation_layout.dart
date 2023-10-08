import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:oraah_app/src/features/screen/Categories/widgets/authors.dart';
import 'package:oraah_app/src/features/screen/Categories/widgets/quotes_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
    final brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedRoute),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(LineAwesomeIcons.arrow_left)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: GetBuilder<NavigationController>(
          builder: (controller) {
            final route = Get.find<NavigationController>().selectedRoute.value;
            switch (route) {
              case "Qoraayasha":
                return Obx(() => _quotesController.isLoading.value
                    ? Center(
                        child: LoadingAnimationWidget.flickr(
                          rightDotColor: Colors.black,
                          leftDotColor: const Color(0xfffd0079),
                          size: 30,
                        ),
                      )
                    : SizedBox(
                        height: deviceSpacController.deviceHeight * 0.95,
                        child: ListOfAuthers(
                          quotesController: _quotesController,
                        ),
                      ));
              case "Farxada":
                _quotesController.fetchQuotesByCategory("Farxada");
                return Obx(
                  () => SizedBox(
                    height: deviceSpacController.deviceHeight * 0.95,
                    // width: deviceSpacController.deiceWidth * 0.85,
                    child: ListView.builder(
                      itemCount: _quotesController.quotesByCategory.length,
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
                                categoryAuthor: _quotesController.quotesByCategory[index].quoteAuther,
                                category: _quotesController
                                    .quotesByCategory[index].quoteText,
                              ),
                            ),
                          )),
                    ),
                  ),
                );
              case "Halgan":
                return Container(
                  child: Text("Strugle Page"),
                );
              case "Mood":
                return Container(
                  child: Text("Mood Page"),
                );
              case "Nolosha":
                _quotesController.fetchQuotesByCategory("Nolosha");
                return Obx(
                  () => SizedBox(
                    height: deviceSpacController.deviceHeight * 0.95,
                    // width: deviceSpacController.deiceWidth * 0.85,
                    child: ListView.builder(
                      itemCount: _quotesController.quotesByCategory.length,
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
                                categoryAuthor: _quotesController.quotesByCategory[index].quoteAuther,
                                category: _quotesController
                                    .quotesByCategory[index].quoteText,
                              ),
                            ),
                          )),
                    ),
                  ),
                );
              case "Dhiirigalin":
                return Container(
                  child: Center(child: Text("Motivations Page, Coming Soon")),
                );
              case "Qalin Jabinta":
                return Container(
                  child: Center(child: Text("Graduations Page, Coming Soon")),
                );
              case "Xikmad":
                _quotesController.fetchQuotesByCategory("Xikmad");
                return Obx(
                  () => SizedBox(
                    height: deviceSpacController.deviceHeight * 0.95,
                    // width: deviceSpacController.deiceWidth * 0.85,
                    child: ListView.builder(
                      itemCount: _quotesController.quotesByCategory.length,
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
                                categoryAuthor: _quotesController.quotesByCategory[index].quoteAuther,
                                category: _quotesController
                                    .quotesByCategory[index].quoteText,
                              ),
                            ),
                          )),
                    ),
                  ),
                );
              case "Safarka":
                _quotesController.fetchQuotesByCategory("Safar");
                return Obx(
                  () => SizedBox(
                    height: deviceSpacController.deviceHeight * 0.95,
                    // width: deviceSpacController.deiceWidth * 0.85,
                    child: ListView.builder(
                      itemCount: _quotesController.quotesByCategory.length,
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
                                categoryAuthor: _quotesController.quotesByCategory[index].quoteAuther,
                                category: _quotesController
                                    .quotesByCategory[index].quoteText,
                              ),
                            ),
                          )),
                    ),
                  ),
                );
              case "Dagaal":
                _quotesController.fetchQuotesByCategory("Dagaal");
                return Obx(
                  () => SizedBox(
                    height: deviceSpacController.deviceHeight * 0.95,
                    // width: deviceSpacController.deiceWidth * 0.85,
                    child: ListView.builder(
                      itemCount: _quotesController.quotesByCategory.length,
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
                                categoryAuthor: _quotesController.quotesByCategory[index].quoteAuther,
                                category: _quotesController
                                    .quotesByCategory[index].quoteText,
                              ),
                            ),
                          )),
                    ),
                  ),
                );
              default:
                return Container(
                  child: Text("Default"),
                );
            }
          },
        ));
  }
}
