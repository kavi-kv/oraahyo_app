import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/controllers/others/deviceSpecController.dart';
import 'package:oraah_app/src/features/controllers/others/themeController.dart';
import 'package:oraah_app/src/features/controllers/quotes/favorite_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_image_controller.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/custom_appbar.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/gradient_text.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';
import 'package:oraah_app/src/utils/theme/theme.dart';
import 'package:get/get.dart';
import '../../constants/text_strings.dart';
import 'Favorites/favorites_screen.dart';
import 'Home/Home.dart';
import 'Create Oraah/create_oraah.dart';
import 'Home/home_widgets/navigation_drawer.dart';
import 'Categories/Categories.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final screens = [
    const KeyedSubtree(key: ValueKey('Home'), child: Home()),
    const KeyedSubtree(key: ValueKey('Categories'), child: Categories()),
    KeyedSubtree(key: const ValueKey('CreateOraah'), child: CreateOraah()),
    KeyedSubtree(
        key: const ValueKey('FavoriteScreen'), child: FavoriteScreen()),
  ];
  final ThemeController themeController = Get.find<ThemeController>();
  // final  authService  = AuthService();
  @override
  void initState() {
    super.initState();
    AuthService().validateAndFetchUser();
    // Get.put<QuotesController>(QuotesController(), permanent: true);
    // Get.lazyPut<FavoriteController>(() => FavoriteController());
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      isDark = themeController.isDarkMode.value;
      return SafeArea(
        child: Scaffold(
          drawer: const NavigationsDrawer(),
          appBar: AppBar(
            // backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16, top: 7),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Obx(() => IconButton(
                    onPressed: () {
                      themeController.toggleTheme();
                    },
                    icon: Icon(
                      themeController.isDarkMode.value
                          ? LineAwesomeIcons.sun
                          : LineAwesomeIcons.moon,
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                    ))),
              )
            ],
            centerTitle: true,
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
          ),
          backgroundColor: Colors.transparent,
          body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: screens[index]),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
                indicatorColor: Colors.blue.shade100,
                labelTextStyle: MaterialStateProperty.all(const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500))),
            child: NavigationBar(
              backgroundColor: Colors.transparent,
              height: 60,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              animationDuration: const Duration(seconds: 3),
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: "Home",
                ),
                NavigationDestination(
                  icon: Icon(Icons.dashboard_customize_outlined),
                  label: "Categories",
                ),
                NavigationDestination(
                  icon: Icon(Icons.format_quote_outlined),
                  label: "Create Oraah",
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite_rounded),
                  label: "Favourite",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
