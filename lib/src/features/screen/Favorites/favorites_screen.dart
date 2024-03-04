import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/controllers/others/deviceSpecController.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  // final favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    final favoriteController = Get.find<FavoriteController>();
    // final userId = userController.user.id;s

    // final QuotesController _quotesController = Get.find<QuotesController>();
    // final QuotesImageController _quotesImageController =
    //     Get.find<QuotesImageController>();
    // final deviceController = Get.put(DeviceSpacController(context));
    final mediaQuey = MediaQuery.of(context);
    final deviceScreenWidth = mediaQuey.size.width;
    final deviceScreenHeight = mediaQuey.size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() => favoriteController.isLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.flickr(
                        rightDotColor: const Color(0xFF000000),
                        leftDotColor: const Color(0xfffd0079),
                        size: 30,
                      ),
                    )
                  : favoriteController.favorites.isEmpty
                      ? Center(
                          child: Image.asset('assets/images/No_data_rafiki.png',
                              height: deviceScreenHeight * 0.65,
                              width: deviceScreenWidth * 0.75),
                        )
                      : ListView.builder(
                          itemCount: favoriteController.favorites.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.only(
                                  left: 10, top: 12, bottom: 10, right: 10),
                              elevation: 3,
                              child: SizedBox(
                                height: 250,
                                // width: deviceScreenWidth * 0.7,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: deviceScreenHeight * 0.30,
                                      width: deviceScreenWidth * 0.98,
                                      // decoration: BoxDecoration(color: Colors.redAccent),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.5),
                                              BlendMode.darken),
                                          child: Image.network(
                                            favoriteController
                                                .favorites[index].imgUrl,
                                            fit: BoxFit.cover,
                                            height: deviceScreenHeight * 0.25,
                                            width: deviceScreenWidth * 0.95,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 20,
                                      top: 10,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: deviceScreenWidth * 0.95,
                                            child: Container(
                                              height: deviceScreenHeight * 0.20,
                                              width: deviceScreenWidth * 0.95,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16, top: 30),
                                              child: Center(
                                                child: AutoSizeText(
                                                  favoriteController
                                                      .favorites[index]
                                                      .quoteTxt,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.apply(
                                                          color: Colors.white,
                                                          heightDelta: 0.15),
                                                  maxLines: 10,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              width: deviceScreenWidth * 0.85,
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                " - ${favoriteController.favorites[index].author} ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                              // : const Text(""),
                                              ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: -5,
                                      right: 0,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.share,
                                                size: 20, color: Colors.white),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              // imageController.saveImgToGalary(context);
                                              // imageController.saveImgToGalary(
                                              //     screenshotController);
                                              // imageController.captureAndSaveImage(
                                              //     repaintBoundaryKey);
                                            },
                                            icon: const Icon(Icons.download,
                                                size: 20, color: Colors.white),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              favoriteController.removeFav(
                                                  favoriteController
                                                      .favorites[index].id,
                                                  userController.user.id);
                                              // favoriteController.addQuotesToFav(
                                              //     userController.user.id,
                                              //     _quotesController
                                              //         .quotes[index].quoteText,
                                              //     imageController.photos[index]
                                              //         .urls?["small"],
                                              //     _quotesController.quotes[index]
                                              //             .quoteAuther ??
                                              //         "Unknown");
                                              // print(
                                              //     'User Id Saved: ${userController.user.id}');
                                              // print(
                                              //     'Quote Text: ${_quotesController.quotes[index].quoteText} \n Author: ${_quotesController.quotes[index].quoteAuther}');
                                            },
                                            icon: const Icon(Icons.favorite,
                                                size: 20, color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
            )
          ],
        ));
  }
}
