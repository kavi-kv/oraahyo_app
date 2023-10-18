import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:oraah_app/src/features/screen/Categories/widgets/authors.dart';
import 'package:oraah_app/src/features/screen/Categories/widgets/quotes_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../controllers/deviceSpecController.dart';
import '../../../controllers/others/navigation_controller.dart';
import '../../../controllers/quotes/quotes_controller.dart';
import '../../../controllers/quotes/quotes_image_controller.dart';
import '../../Home/home_widgets/quotes_card.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';

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
                final isExisted = _quotesController.isCategoryValid.value;
                final isVisible = isExisted ? true : false;
                _quotesController.fetchQuotesByCategory("Farxada");
                return isExisted
                    ? Visibility(
                        visible: isVisible,
                        child: SizedBox(
                          height: deviceSpacController.deviceHeight * 0.95,
                          child: ListView.builder(
                            itemCount:
                                _quotesController.quotesByCategory.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              ScreenshotController screenshotController =
                                  ScreenshotController();
                              return SizedBox(
                                height: 250,
                                width: 150,
                                child: Center(
                                  child: Container(
                                    width: width,
                                    child: QuotesCard(
                                      index: index,
                                      imageController: _quotesImageController,
                                      quotesController: _quotesController,
                                      deviceScreenHeight: height,
                                      deviceScreenWidth: width,
                                      categoryAuthor: _quotesController
                                          .quotesByCategory[index].quoteAuther,
                                      category: _quotesController
                                          .quotesByCategory[index].quoteText,
                                      screenshotController:
                                          screenshotController,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Container(
                        child: Center(
                            child:
                                Lottie.asset('assets/lottie/sorry-404.json')),
                      ); //
              case "Halgan":
                final isExisted = _quotesController.isCategoryValid.value;
                final isVisible = isExisted ? true : false;
                _quotesController.fetchQuotesByCategory("Halgan");
                return isExisted
                    ? Visibility(
                        visible: isVisible,
                        child: SizedBox(
                          height: deviceSpacController.deviceHeight * 0.95,
                          child: ListView.builder(
                              itemCount:
                                  _quotesController.quotesByCategory.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                ScreenshotController screenshotController =
                                    ScreenshotController();
                                return SizedBox(
                                  height: 250,
                                  width: 150,
                                  child: Center(
                                    child: Container(
                                      width: width,
                                      child: QuotesCard(
                                        index: index,
                                        imageController: _quotesImageController,
                                        quotesController: _quotesController,
                                        deviceScreenHeight: height,
                                        deviceScreenWidth: width,
                                        categoryAuthor: _quotesController
                                            .quotesByCategory[index]
                                            .quoteAuther,
                                        category: _quotesController
                                            .quotesByCategory[index].quoteText,
                                        screenshotController:
                                            screenshotController,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    : Container(
                        child: Center(
                            child:
                                Lottie.asset('assets/lottie/sorry-404.json')),
                      ); // Return an empty container when isExisted is false

              case "Cabsida":
                final isExisted = _quotesController.isCategoryValid.value;
                final isVisible = isExisted ? true : false;
                _quotesController.fetchQuotesByCategory("Cabsi");
                return isExisted
                    ? Visibility(
                        visible: isVisible,
                        child: SizedBox(
                          height: deviceSpacController.deviceHeight * 0.95,
                          child: ListView.builder(
                              itemCount:
                                  _quotesController.quotesByCategory.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                ScreenshotController screenshotController =
                                    ScreenshotController();
                                return SizedBox(
                                  height: 250,
                                  width: 150,
                                  child: Center(
                                    child: Container(
                                      width: width,
                                      child: QuotesCard(
                                        index: index,
                                        imageController: _quotesImageController,
                                        quotesController: _quotesController,
                                        deviceScreenHeight: height,
                                        deviceScreenWidth: width,
                                        categoryAuthor: _quotesController
                                            .quotesByCategory[index]
                                            .quoteAuther,
                                        category: _quotesController
                                            .quotesByCategory[index].quoteText,
                                        screenshotController:
                                            screenshotController,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    : Container(
                        child: Center(
                            child:
                                Lottie.asset('assets/lottie/sorry-404.json')),
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
                        itemBuilder: (context, index) {
                          ScreenshotController screenshotController =
                              ScreenshotController();
                          return SizedBox(
                            child: Center(
                              child: Container(
                                width: width,
                                child: QuotesCard(
                                  index: index,
                                  imageController: _quotesImageController,
                                  quotesController: _quotesController,
                                  deviceScreenHeight: height,
                                  deviceScreenWidth: width,
                                  categoryAuthor: _quotesController
                                      .quotesByCategory[index].quoteAuther,
                                  category: _quotesController
                                      .quotesByCategory[index].quoteText,
                                  screenshotController: screenshotController,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              case "Dhiirigalin":
                final isExisted = _quotesController.isCategoryValid.value;
                final isVisible = isExisted ? true : false;
                _quotesController.fetchQuotesByCategory("Dhiirigalin");
                return isExisted
                    ? Visibility(
                        visible: isVisible,
                        child: SizedBox(
                          height: deviceSpacController.deviceHeight * 0.95,
                          child: ListView.builder(
                              itemCount:
                                  _quotesController.quotesByCategory.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                ScreenshotController screenshotController =
                                    ScreenshotController();
                                return SizedBox(
                                  child: Center(
                                    child: Container(
                                      width: width,
                                      child: QuotesCard(
                                        index: index,
                                        imageController: _quotesImageController,
                                        quotesController: _quotesController,
                                        deviceScreenHeight: height,
                                        deviceScreenWidth: width,
                                        categoryAuthor: _quotesController
                                            .quotesByCategory[index]
                                            .quoteAuther,
                                        category: _quotesController
                                            .quotesByCategory[index].quoteText,
                                        screenshotController:
                                            screenshotController,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    : Container(
                        child: Center(
                            child:
                                Lottie.asset('assets/lottie/sorry-404.json')),
                      );
              case "Qalin Jabinta":
                final isExisted = _quotesController.isCategoryValid.value;
                final isVisible = isExisted ? true : false;
                _quotesController.fetchQuotesByCategory("Qalin Jabinta");
                return isExisted
                    ? Visibility(
                        visible: isVisible,
                        child: SizedBox(
                          height: deviceSpacController.deviceHeight * 0.95,
                          child: ListView.builder(
                              itemCount:
                                  _quotesController.quotesByCategory.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                ScreenshotController screenshotController =
                                    ScreenshotController();
                                return SizedBox(
                                  child: Center(
                                    child: Container(
                                      width: width,
                                      child: QuotesCard(
                                        index: index,
                                        imageController: _quotesImageController,
                                        quotesController: _quotesController,
                                        deviceScreenHeight: height,
                                        deviceScreenWidth: width,
                                        categoryAuthor: _quotesController
                                            .quotesByCategory[index]
                                            .quoteAuther,
                                        category: _quotesController
                                            .quotesByCategory[index].quoteText,
                                        screenshotController:
                                            screenshotController,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    : Container(
                        child: Center(
                            child:
                                Lottie.asset('assets/lottie/sorry-404.json')),
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
                        itemBuilder: (context, index) {
                          ScreenshotController screenshotController =
                              ScreenshotController();
                          return SizedBox(
                            child: Center(
                              child: Container(
                                width: width,
                                child: QuotesCard(
                                  index: index,
                                  imageController: _quotesImageController,
                                  quotesController: _quotesController,
                                  deviceScreenHeight: height,
                                  deviceScreenWidth: width,
                                  categoryAuthor: _quotesController
                                      .quotesByCategory[index].quoteAuther,
                                  category: _quotesController
                                      .quotesByCategory[index].quoteText,
                                  screenshotController: screenshotController,
                                ),
                              ),
                            ),
                          );
                        }),
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
                        itemBuilder: (context, index) {
                          ScreenshotController screenshotController =
                              ScreenshotController();
                          return SizedBox(
                            child: Center(
                              child: Container(
                                width: width,
                                child: QuotesCard(
                                  index: index,
                                  imageController: _quotesImageController,
                                  quotesController: _quotesController,
                                  deviceScreenHeight: height,
                                  deviceScreenWidth: width,
                                  categoryAuthor: _quotesController
                                      .quotesByCategory[index].quoteAuther,
                                  category: _quotesController
                                      .quotesByCategory[index].quoteText,
                                  screenshotController: screenshotController,
                                ),
                              ),
                            ),
                          );
                        }),
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
                        itemBuilder: (context, index) {
                          ScreenshotController screenshotController =
                              ScreenshotController();
                          return SizedBox(
                            height: 250,
                            child: Center(
                              child: Container(
                                width: width,
                                child: QuotesCard(
                                  index: index,
                                  imageController: _quotesImageController,
                                  quotesController: _quotesController,
                                  deviceScreenHeight: height,
                                  deviceScreenWidth: width,
                                  categoryAuthor: _quotesController
                                      .quotesByCategory[index].quoteAuther,
                                  category: _quotesController
                                      .quotesByCategory[index].quoteText,
                                  screenshotController: screenshotController,
                                ),
                              ),
                            ),
                          );
                        }),
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
