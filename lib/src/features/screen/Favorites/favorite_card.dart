import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_image_controller.dart';

// import 'package:screenshot/screenshot.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    // required this.imageController,
    // required QuotesController quotesController,
    required this.deviceScreenHeight,
    required this.deviceScreenWidth,
    required this.index,
    this.quotes,
    this.quotesLength,
    this.categoryAuthor,
    required this.favoriteController,
    // required this.userController,
    // required this.screenshotController,
    // required this.imageUrl,
  });

  final int index;
  // final QuotesImageController imageController;
  // final QuotesController _quotesController;
  final FavoriteController favoriteController;
  // final UserController userController;
  final double deviceScreenHeight;
  final double deviceScreenWidth;
  final String? quotes;
  final String? categoryAuthor;
  final int? quotesLength;

  // UserController get userController => Get.find<UserController>();
  // FavoriteController get favoriteController => Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    final GlobalKey repaintBoundaryKey = GlobalKey();

    return SizedBox(
        height: 250,
        width: 150,
        child: Stack(
          children: [
            Obx(
              () => favoriteController.isLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.flickr(
                        rightDotColor: Colors.black,
                        leftDotColor: const Color(0xfffd0079),
                        size: 30,
                      ),
                    )
                  : Card(
                      margin:
                          const EdgeInsets.only(left: 10, top: 20, right: 10),
                      elevation: 2,
                      child: Stack(
                        children: [
                          RepaintBoundary(
                            key: repaintBoundaryKey,
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
                                  left: 16,
                                  top: 0,
                                  child: SizedBox(
                                    width: deviceScreenWidth * 0.95,
                                    child: Column(
                                      children: [
                                        // Container(
                                        //   height: deviceScreenHeight * 0.20,
                                        //   width: deviceScreenWidth * 0.95,
                                        //   alignment: Alignment.center,
                                        //   padding: const EdgeInsets.only(
                                        //       left: 16, right: 25, top: 5),
                                        //   child: Obx(
                                        //     () => !userController.isLoading
                                        //         ? AutoSizeText(
                                        //             " \" $quotes\" ",
                                        //             style: Theme.of(context)
                                        //                 .textTheme
                                        //                 .bodyMedium
                                        //                 ?.apply(
                                        //                     color:
                                        //                         Colors.white),
                                        //             maxLines: 10,
                                        //             overflow:
                                        //                 TextOverflow.ellipsis,
                                        //           )
                                        //         : Container(),
                                        //   ),
                                        // ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 10),
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                                    " - $categoryAuthor ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                
                                          ),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.share,
                                      color: Colors.white),
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
                                      color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {
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
                                      color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // _quotesController.copyTextToClipboard(
                                    //     _quotesController
                                    //         .quotes[index].quoteText);

                                    // favoriteController
                                    //     .readFav(userController.user.id);
                                    // print(
                                    //     "Favorite Data: ${favoriteController.favorites[index].quoteTxt}");
                                    // print(
                                    //     "UserId In Quotes Card: ${userController.user.id}");
                                  },
                                  icon: const Icon(Icons.copy,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ));
  }
}
