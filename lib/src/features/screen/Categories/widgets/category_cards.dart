import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/deviceSpecController.dart';


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
                  margin: EdgeInsets.all(10),
                  color: Colors.amberAccent,
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
