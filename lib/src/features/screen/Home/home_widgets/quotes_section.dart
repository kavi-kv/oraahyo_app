import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraah_app/src/features/controllers/deviceSpecController.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/quotes_card.dart';
import 'package:screenshot/screenshot.dart';
import '../../../controllers/quotes/quotes_image_controller.dart';

class QuotesSection extends StatelessWidget {
  const QuotesSection({
    super.key,
    required this.deviceScreenHeight,
    required this.deviceScreenWidth,
    required QuotesController quotesController,
    required this.brightness,
    required this.imageController,
  }) : _quotesController = quotesController;

  final double deviceScreenHeight;
  final double deviceScreenWidth;
  final QuotesController _quotesController;
  final Brightness brightness;
  final QuotesImageController imageController;

  @override
  Widget build(BuildContext context) {
    // final QuotesController _quotesController = Get.find<QuotesController>();
    // final QuotesImageController _quotesImageController =
    //     Get.find<QuotesImageController>();
    final deviceSpacController = Get.put(DeviceSpacController(context));
    // final height = deviceSpacController.deviceHeight * 0.98;
    // double width = deviceSpacController.deiceWidth * 0.95;

    return Obx(
      () => SizedBox(
        height: deviceSpacController.deviceHeight * 0.95,
        // width: deviceSpacController.deiceWidth * 0.85,
        child: ListView.builder(
          itemCount: _quotesController.quotes.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            ScreenshotController screenshotController = ScreenshotController();
            return SizedBox(
              height: 250,
              width: 150,
              child: Center(
                child: Container(
                  width: deviceScreenWidth,
                  child: QuotesCard(
                    index: index,
                    imageController: imageController,
                    quotesController: _quotesController,
                    deviceScreenHeight: deviceScreenHeight,
                    deviceScreenWidth: deviceScreenWidth,
                    categoryAuthor: _quotesController.quotes[index].quoteAuther,
                    category: _quotesController.quotes[index].quoteText,
                    // quotesLength: _quotesController.quotes.length,
                    screenshotController: screenshotController,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
