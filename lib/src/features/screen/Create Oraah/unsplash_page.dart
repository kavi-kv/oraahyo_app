import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:oraah_app/src/common_widgets/custom_page_route.dart';
import 'package:oraah_app/src/features/controllers/animations/animation_controller.dart';
// import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:oraah_app/src/features/controllers/quotes/create_oraah_controller.dart';
import 'package:oraah_app/src/features/screen/Create%20Oraah/image_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class UnsplashPage extends StatelessWidget {
  UnsplashPage({super.key});

  // final myAnimationController = Get.put(MyAnimationController());
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();

    final creatOraahController = Get.find<CreateOraahController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LineAwesomeIcons.arrow_left)),
        title: const Text("Select Image"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 60,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  // color: Colors.amber,
                  borderRadius: BorderRadius.circular(0)),
              child: TextField(
                // onChanged: (value) {
                //   creatOraahController.updateSearchQueryString(value);
                // },
                onSubmitted: (value) {
                  creatOraahController.updateSearchQueryString(value);
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Search...',
                  hintText: "Search Images....",
                  fillColor: Colors.white,

                ),
                textInputAction: TextInputAction.search,
                controller: textController,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Obx(() {
                if (creatOraahController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return AnimationLimiter(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 5),
                      itemCount: creatOraahController.images.length,
                      itemBuilder: (contex, index) {
                        final image = creatOraahController.images[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () =>
                                  ImageView(image: image.urls?['regular']),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 600),
                            );
                          },
                          child: AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: 2,
                            duration: const Duration(milliseconds: 500),
                            child: FlipAnimation(
                              // verticalOffset: 50,
                              delay: const Duration(milliseconds: 275),
                              child: SizedBox(
                                height: 180,
                                child: Card(
                                  elevation: 2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      image.urls?['regular'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
