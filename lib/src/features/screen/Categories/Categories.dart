import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/screen/Categories/widgets/category_cards.dart';


import '../../controllers/category_controller.dart';
import '../../controllers/deviceSpecController.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    
    final deviceController = Get.put(DeviceSpacController(context));
    final categoryController = Get.put(CategoriesController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("Categories",style: Theme.of(context).textTheme.titleLarge,)),
            SizedBox(height: 10,),
            CategoryCards(categoriesList: categoryController.categoriesList, deviceController: deviceController),
          ],
        ),
      ),
    );
  }
}

