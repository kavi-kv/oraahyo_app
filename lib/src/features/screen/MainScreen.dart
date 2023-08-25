import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/text_strings.dart';
import 'Categories/Users.dart';
import 'Home/Home.dart';
import 'Home/Status.dart';
import 'Home/home_widgets/navigation_drawer.dart';
import 'Categories/Categories.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

   int index = 0;
   final Screens = [
    Home(),
    Categories(),
    Status(),
    User()
   ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            oAppTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 16, top: 7),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(LineAwesomeIcons.sun)),
            )
          ],
        ),
        drawer: NavigationsDrawer(),
        body: Screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.blue.shade100,
            labelTextStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 14,fontWeight: FontWeight.w500)
            )
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            height: 60,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            animationDuration: Duration(seconds: 3),
            selectedIndex: index,
            onDestinationSelected: (index) => 
                setState(()=> this.index = index),
            destinations: [
              NavigationDestination(icon: Icon(Icons.home_outlined), 
              label: "Home",
              ),
              NavigationDestination(icon: Icon(Icons.dashboard_customize_outlined), 
              label: "Categories",
              ),
              NavigationDestination(icon: Icon(Icons.post_add_outlined), 
              label: "Status",
              ),
              NavigationDestination(icon: Icon(Icons.person), 
              label: "User",
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

