import 'package:flutter/material.dart';
import 'package:oraah_app/src/constants/text_strings.dart';
import 'package:oraah_app/src/features/controllers/navigation_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes_controller.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/model/quotes/authorsModel.dart';
import 'package:oraah_app/src/features/screen/Categories/widgets/byAuthors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraah_app/src/features/controllers/deviceSpecController.dart';

class ListOfAuthers extends StatelessWidget {
  const ListOfAuthers({
    super.key,
    required this.quotesController,
  });

  final QuotesController quotesController;

  @override
  Widget build(BuildContext context) {
    List<AuthorsModel> authorsModel = quotesController.listOfAuthors
        .where((auther) => auther.authorName != "Unknown")
        .toList();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.95,
                child: authersView(context, quotesController, authorsModel)),
          ],
        ),
      ),
    );
  }
}

Widget authersView(
    BuildContext context, QuotesController quotesController, authorsModel) {
  List<AuthorsModel> autherCount = quotesController.listOfAuthors
      .where((count) => count.count > 3)
      .toList();

  return ListView.builder(
      itemCount: quotesController.listOfAuthors.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: ListTile(
            title: Text(
              quotesController.listOfAuthors[index].authorName,
              // autherNames[index].authorName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Text(
              quotesController.listOfAuthors[index].count.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            tileColor: Theme.of(context).cardColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: () {
              Get.to(() => quotesController.isLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.flickr(
                        rightDotColor: Colors.black,
                        leftDotColor: const Color(0xfffd0079),
                        size: 30,
                      ),
                    )
                  : ByAuthors(
                      name: quotesController.listOfAuthors[index].authorName));
            },
          ),
        );
      });
}
