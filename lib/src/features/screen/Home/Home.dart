import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/others/themeController.dart';
import 'package:oraah_app/src/features/controllers/quotes/create_oraah_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/app_bar.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/daily_quotes.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/gradient_text.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/navigation_drawer.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/quotes_card.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/quotes_section.dart';
import '../../../constants/text_strings.dart';
import '../../controllers/others/deviceSpecController.dart';
import '../../controllers/quotes/quotes_controller.dart';
import '../../controllers/quotes/quotes_image_controller.dart';
import '../../controllers/others/tab_controllers.dart';
import 'home_widgets/home_tab_bar.dart';
import 'home_widgets/quotes_of_the_day.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    final quotesController = Get.put(QuotesController());
    final imageController = Get.put(QuotesImageController());
    final tabController = Get.put(PageTabControllers());
    Get.lazyPut(() => FavoriteController());
    // Get.lazyPut(()=> CreateOraahController());

    final deviceController = Get.put(DeviceSpacController(context));
    final mediaQuey = MediaQuery.of(context);
    final deviceScreenWidth = mediaQuey.size.width;
    final deviceScreenHeight = mediaQuey.size.height;
    // final brightness = mediaQuey.platformBrightness;
    return Scaffold(
      drawer: const NavigationsDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16, top: 7),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                    onPressed: () {
                      themeController.toggleTheme();
                    },
                    icon: Icon(
                      // themeController.isDarkMode.value ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                      themeController.isDarkMode.value
                          ? LineAwesomeIcons.sun
                          : LineAwesomeIcons.moon,
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                    )),
              )
            ],
            title: GradientText(
              text: oAppTitle,
              gradient: LinearGradient(
                colors: [
                  themeController.isDarkMode.value
                      ? Colors.white
                      : Colors.redAccent,
                  themeController.isDarkMode.value ? Colors.blue : Colors.blue,
                ],
              ),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pinned: true,
            centerTitle: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
                background: Padding(
              padding: const EdgeInsets.all(0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Obx(() => Swiper(
                          itemHeight: 400,
                          itemWidth: MediaQuery.of(context).size.width * 0.7,
                          loop: true,
                          autoplay: true,
                          autoplayDelay: 10000,
                          duration: 1500,
                          scrollDirection: Axis.horizontal,
                          pagination: const SwiperPagination(
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                color: Colors.grey,
                                activeColor: Colors.blue,
                                size: 10,
                                activeSize: 12,
                              )),
                          // control: const SwiperControl(),
                          itemBuilder: (context, index) {
                            if (imageController.storyPhotos.isNotEmpty &&
                                quotesController.storyQuotes.isNotEmpty) {
                              String imageUrl = imageController
                                  .storyPhotos[index].urls?['small'];
                              String txtUrl =
                                  quotesController.storyQuotes[index].quoteText;
                              return Stack(
                                children: [
                                  Obx(
                                    () => quotesController.isLoading.value
                                        ? Center(
                                            child:
                                                LoadingAnimationWidget.flickr(
                                              rightDotColor: Colors.black,
                                              leftDotColor:
                                                  const Color(0xfffd0079),
                                              size: 30,
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            height: 150,
                                            decoration: BoxDecoration(
                                                // image: NetworkImage(imageUrl),),
                                                // color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  // margin:
                                                  //     const EdgeInsets.symmetric(horizontal: 5),
                                                  child: ColorFiltered(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            const Color(
                                                                    0xFF000000)
                                                                .withOpacity(
                                                                    0.5),
                                                            BlendMode.darken),
                                                    child: Image.network(
                                                      imageUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ))),
                                  ),
                                  Positioned(
                                      top: 10,
                                      left: 16,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.80,
                                        child: Column(
                                          children: [
                                            Container(
                                              // color: Colors.amber,
                                              alignment: Alignment.center,
                                              height: 120,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.80,
                                              margin: const EdgeInsets.only(
                                                  right: 16, top: 10, left: 5),
                                              padding: const EdgeInsets.only(
                                                right: 16,
                                                top: 5,
                                              ),
                                              child: Center(
                                                child: AutoSizeText(
                                                  txtUrl,
                                                  textAlign: TextAlign.center,
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
                                          ],
                                        ),
                                      ))
                                ],
                              );
                            } else {
                              return const Text("Data IS empty");
                            }
                          },
                          itemCount: imageController.storyPhotos.length,
                          layout: SwiperLayout.DEFAULT,
                        )),
                  ),
                ),
              ),
            )),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => Obx(
              () => SizedBox(
                height: 250,
                width: 150,
                child: QuotesCard(
                  index: index,
                  imageController: imageController,
                  quotesController: quotesController,
                  deviceScreenHeight: deviceScreenHeight,
                  deviceScreenWidth: deviceScreenWidth,
                  categoryAuthor: index < quotesController.quotes.length
                      ? quotesController.quotes[index].quoteAuther
                      : "Default Author",
                  category: index < quotesController.quotes.length
                      ? quotesController.quotes[index].quoteText
                      : "Default Quote",
                  // quotesLength: _quotesController.quotes.length,
                  // screenshotController: screenshotController,
                ),
              ),
            ),
            childCount: quotesController.quotes.length,
          ))
        ],
      ),
    );
  }
}
