import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


import '../../../controllers/quotes_controller.dart';
import '../../../controllers/quotes_image_controller.dart';

class QuotesCard extends StatelessWidget {
  const QuotesCard({
    super.key,
    required this.imageController,
    required QuotesController quotesController,
    required this.deviceScreenHeight,
    required this.deviceScreenWidth,
    required this.index,
    // required this.imageUrl,
  }) : _quotesController = quotesController;

  final int index;
  final QuotesImageController imageController;
  final QuotesController _quotesController;
  final double deviceScreenHeight;
  final double deviceScreenWidth;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: 150,
        child: Stack(
          children: [
            Obx(
              () => imageController.isLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.flickr(
                        rightDotColor: Colors.black,
                        leftDotColor: const Color(0xfffd0079),
                        size: 30,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _quotesController.isIconVisibleList[index].value =
                            !_quotesController.isIconVisibleList[index].value;
                      },
                      child: Card(
                        margin: EdgeInsets.only(left: 10, top: 20),
                        elevation: 5,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _quotesController
                                        .isIconVisibleList[index].value =
                                    !_quotesController
                                        .isIconVisibleList[index].value;
                              },
                              child: Container(
                                height: deviceScreenHeight * 0.25,
                                width: deviceScreenWidth * 0.95,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
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
                            ),
                            _quotesController.isIconVisibleList[index].value
                                ? Positioned(
                                    bottom: 0,
                                    right: 10,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.share,
                                              color: Colors.white),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // imageController.downloadAndSave(
                                            //     index,
                                            //     _quotesController.quotes[index],
                                            //     imageUrl);
                                          },
                                          icon: Icon(Icons.download,
                                              color: Colors.white),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.favorite,
                                              color: Colors.white),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.copy,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
            ),
            Positioned(
              left: 16,
              top: 20,
              child: SizedBox(
                width: deviceScreenWidth * 0.95,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _quotesController.isIconVisibleList[index].value =
                            !_quotesController.isIconVisibleList[index].value;
                      },
                      child: Container(
                        height: deviceScreenHeight * 0.20,
                        width: deviceScreenWidth * 0.95,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 16, right: 25, top: 5),
                        child: Obx(
                          () => !imageController.isLoading.value
                              ? AutoSizeText(
                                  " \"${_quotesController.quotes[index].quoteText}\" ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.apply(color: Colors.white),
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Container(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      alignment: Alignment.bottomLeft,
                      child: Obx(
                        () => !imageController.isLoading.value
                            ? Text(
                                " by- ${_quotesController.quotes[index].quoteAuther} ",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(""),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
