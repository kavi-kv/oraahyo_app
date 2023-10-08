import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/deviceSpecController.dart';
import 'package:oraah_app/src/features/controllers/quotes_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes_image_controller.dart';
import 'package:oraah_app/src/features/model/quotes/authorsModel.dart';
import 'package:oraah_app/src/features/model/quotes/quotesModel.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/quotes_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ByAuthors extends StatefulWidget {
  const ByAuthors({super.key, required this.name});

  final String name;

  @override
  State<ByAuthors> createState() => _ByAuthorsState();
}

class _ByAuthorsState extends State<ByAuthors> {
  // late Future _data;
  final QuotesController quotesController = Get.find<QuotesController>();
  final QuotesImageController quotesImageController =
      Get.find<QuotesImageController>();
  @override
  void initState() {
    super.initState();
    // _data = quotesController.fetchByAuthor(widget.name);
    SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
      quotesController.fetchByAuthor(widget.name);
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
  //     quotesController.fetchByAuthor(widget.name);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final deviceSpacController = Get.put(DeviceSpacController(context));
    final height = deviceSpacController.deviceHeight * 0.98;
    double width = deviceSpacController.deiceWidth * 0.95;
    // final futureFunct = quotesController.fetchByAuthor(widget.name);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() => SizedBox(
            child: ListView.builder(
                itemCount: quotesController.quotesByAuthor.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return quotesController.isLoading.value
                      ? Center(
                          child: LoadingAnimationWidget.flickr(
                            rightDotColor: Colors.black,
                            leftDotColor: const Color(0xfffd0079),
                            size: 30,
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            width: width,
                            child: QuotesCard(
                              index: index,
                              imageController: quotesImageController,
                              quotesController: quotesController,
                              deviceScreenHeight: height,
                              deviceScreenWidth: width,
                              categoryAuthor: quotesController.quotesByAuthor[index].quoteAuther,
                              category: quotesController
                                  .quotesByAuthor[index].quoteText,
                            ),
                          ),
                        );
                }),
          )),
    );
  }
}
