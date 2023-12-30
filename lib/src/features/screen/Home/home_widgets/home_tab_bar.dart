import 'package:flutter/material.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/quotes_section.dart';
import '../../../controllers/quotes/quotes_controller.dart';
import '../../../controllers/quotes/quotes_image_controller.dart';
import 'package:lottie/lottie.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    Key? key,
    required TabController tabController,
    required this.deviceScreenHeight,
    required this.deviceScreenWidth,
    required QuotesController quotesController,
    required this.brightness,
    required this.imageController,
    required this.tabsList,
  })  : _tabController = tabController,
        _quotesController = quotesController;

  final TabController _tabController;
  final double deviceScreenHeight;
  final double deviceScreenWidth;
  final QuotesController _quotesController;
  final Brightness brightness;
  final QuotesImageController imageController;
  final List<String> tabsList;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: <Widget>[
          TabBar.secondary(
            controller: _tabController,
            tabs: tabsList.map((String tabName) {
              return Tab(child: Text(tabName,style: Theme.of(context).textTheme.bodyMedium,),);
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                QuotesSection(
                  deviceScreenHeight: deviceScreenHeight,
                  deviceScreenWidth: deviceScreenWidth,
                  quotesController: _quotesController,
                  brightness: brightness,
                  imageController: imageController,
                ),
                Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Center(
                    // child: Lottie.asset("assets/lottie/not_ready.json"),
                    child: Lottie.asset("assets/lottie/not_ready.json"),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Center(
                      child: Lottie.asset("assets/lottie/not_ready.json")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
