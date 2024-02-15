import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/controllers/quotes/create_oraah_controller.dart';
import 'package:oraah_app/src/features/screen/Create%20Oraah/create_oraah.dart';
import 'package:oraah_app/src/utils/widget_themes/elevated_button_themes.dart';

class ImageView extends StatelessWidget {
   ImageView({super.key, required this.image});
  final String image;

  final createOraahController = Get.find<CreateOraahController>();
  @override
  Widget build(BuildContext context) {
    // final createOraahController = CreateOraahController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.close)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width * 0.95,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                        child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!.toDouble()
                          : null,
                    ));
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text("Unsplash Photo"),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              height: 54,
              width: MediaQuery.of(context).size.width * 0.78,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: BorderSide.none,
                  ),
                  onPressed: () {
                    createOraahController.backgorundImage(image);
                    Get.to(() => CreateOraah());
                  },
                  child: Text(
                    "Select this image",
                    style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: Colors.black,
                        ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
