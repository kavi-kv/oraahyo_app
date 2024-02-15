import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:oraah_app/src/features/controllers/quotes/create_oraah_controller.dart';
import 'package:oraah_app/src/features/screen/Create%20Oraah/image_view.dart';

class UnsplashPage extends StatelessWidget {
  const UnsplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();

    final creatOraahController = Get.find<CreateOraahController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LineAwesomeIcons.arrow_left)),
        title: const Text("Select Image"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                // color: Colors.amber,
                borderRadius: BorderRadius.circular(0)),
            child: TextField(
              onChanged: (value) {
                creatOraahController.updateSearchQueryString(value);
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Search...',
                hintText: "Search Images....",
                fillColor: Colors.white,
                // border: const OutlineInputBorder(),
                // suffix: IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.search,
                //       color: Colors.white,
                //     )),
              ),
              controller: textController,
            ),
          ),
          Expanded(child: Obx(() {
            if (creatOraahController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 5),
                itemCount: creatOraahController.images.length,
                itemBuilder: (contex, index) {
                  final image = creatOraahController.images[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ImageView(image: image.urls?['regular']));
                    },
                    child: Container(
                      // height: 20,
                      // width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.transparent,
                          )),
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          image.urls?['regular'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                });
          }))
        ],
      ),
    );
  }
}
