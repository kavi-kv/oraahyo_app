import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/constants/color.dart';
import 'package:oraah_app/src/features/controllers/others/deviceSpecController.dart';
import 'package:oraah_app/src/features/controllers/others/themeController.dart';

import '../../../controllers/others/navigation_controller.dart';

class CategoryCards extends StatelessWidget {
  const CategoryCards({
    super.key,
    required this.categoriesList,
    required this.deviceController,
  });

  final List<String> categoriesList;
  final DeviceSpacController deviceController;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDark = brightness == Brightness.dark;
    
    return Wrap(
      direction: Axis.horizontal,
      children: categoriesList.map((category) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.find<NavigationController>().changeRoute(category);
              },
              child: Container(
                height: deviceController.deviceHeight * 0.2,
                width: deviceController.deiceWidth * 0.5,
                child: Card(
                  margin: const EdgeInsets.all(10),
                  color:  themeController.isDarkMode.value ? tWhiteSnow : tDarkPurple,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(category),
            ),
          ],
        );
      }).toList(),
    );
  }
}
