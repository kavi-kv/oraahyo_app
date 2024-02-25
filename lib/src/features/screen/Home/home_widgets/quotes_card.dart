import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';

// import 'package:screenshot/screenshot.dart';
import '../../../controllers/quotes/quotes_controller.dart';
import '../../../controllers/quotes/quotes_image_controller.dart';

class QuotesCard extends StatelessWidget {
  const QuotesCard({
    super.key,
    required this.imageController,
    required QuotesController quotesController,
    required this.deviceScreenHeight,
    required this.deviceScreenWidth,
    required this.index,
    this.category,
    this.quotesLength,
    this.categoryAuthor,
    // required this.screenshotController,
    // required this.imageUrl,
  }) : _quotesController = quotesController;

  final int index;
  final QuotesImageController imageController;
  final QuotesController _quotesController;
  final double deviceScreenHeight;
  final double deviceScreenWidth;
  final String? category;
  final String? categoryAuthor;
  final int? quotesLength;
  // final ScreenshotController screenshotController;

  UserController get userController => Get.find<UserController>();
  FavoriteController get favoriteController => Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    // final favoriteController = Get.find<FavoriteController>();
    final GlobalKey repaintBoundaryKey = GlobalKey();

    return SizedBox(
      height: 250,
      width: 150,
      child: Obx(
        () => imageController.photos.isEmpty || _quotesController.quotes.isEmpty
            ? Center(
                child: LoadingAnimationWidget.flickr(
                  rightDotColor: Colors.black,
                  leftDotColor: const Color(0xfffd0079),
                  size: 30,
                ),
              )
            : Stack(
                children: [
                  GestureDetector(
                    onTap: () => {
                      _quotesController.isIconVisibleList[index].value =
                          !_quotesController.isIconVisibleList[index].value
                    },
                    child: Card(
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          const Color(0xFF000000)
                                              .withOpacity(0.5),
                                          BlendMode.darken),
                                      child: Image.network(
                                        imageController
                                            .photos[index].urls?["small"],
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
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: deviceScreenWidth * 0.95,
                                        child: Container(
                                          height: deviceScreenHeight * 0.20,
                                          width: deviceScreenWidth * 0.95,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 25, top: 5),
                                          child: 
                                          // Obx(
                                          //   () => !imageController
                                          //               .isLoading.value |
                                          //           !_quotesController
                                          //               .isLoading.value
                                          //       ? 
                                                AutoSizeText(
                                                    " \" $category\" ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.apply(
                                                            color:
                                                                Colors.white),
                                                    maxLines: 10,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                // : Center(
                                                //     child:
                                                //         LoadingAnimationWidget
                                                //             .flickr(
                                                //       rightDotColor:
                                                //           Colors.black,
                                                //       leftDotColor: const Color(
                                                //           0xfffd0079),
                                                //       size: 30,
                                                //     ),
                                                //   ),
                                          
                                        ),
                                      ),
                                      Container(
                                        width: deviceScreenWidth * 0.90,
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        alignment: Alignment.bottomLeft,
                                        child: Obx(
                                          () => !imageController.isLoading.value
                                              ? Text(
                                                  " - $categoryAuthor ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : const Text(""),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ),
                          _quotesController.isIconVisibleList[index].value
                              ? Positioned(
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
                                          imageController.captureAndSaveImage(
                                              repaintBoundaryKey);
                                        },
                                        icon: const Icon(Icons.download,
                                            color: Colors.white),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          var quoteId = _quotesController
                                              .quotes[index].quoteId;
                                          if (favoriteController.isFavorite(
                                              _quotesController
                                                  .quotes[index].quoteId)) {
                                            print(
                                                "Quote With the Id: $quoteId already exists.");
                                            return;
                                          } else {
                                            favoriteController.addQuotesToFav(
                                                _quotesController
                                                    .quotes[index].quoteId,
                                                userController.user.id,
                                                _quotesController
                                                    .quotes[index].quoteText,
                                                imageController.photos[index]
                                                    .urls?["small"],
                                                _quotesController.quotes[index]
                                                        .quoteAuther ??
                                                    "Unknown");
                                          }

                                          print(
                                              'Quote ID: ${_quotesController.quotes[index].quoteId}');
                                          print(
                                              'User Id Saved: ${userController.user.id}');
                                          print(
                                              'Quote Text: ${_quotesController.quotes[index].quoteText} \n Author: ${_quotesController.quotes[index].quoteAuther}');
                                        },
                                        icon: Icon(Icons.favorite,
                                            color:
                                                favoriteController.isFavorite(
                                                        _quotesController
                                                            .quotes[index]
                                                            .quoteId)
                                                    ? Colors.red
                                                    : Colors.white),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _quotesController.copyTextToClipboard(
                                              _quotesController
                                                  .quotes[index].quoteText);

                                          // favoriteController.readFav(
                                          //     userController.user.id);
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
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
