import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:oraah_app/src/features/controllers/quotes/create_oraah_controller.dart';
import 'package:oraah_app/src/features/screen/Create%20Oraah/edit_icons_func.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:oraah_app/src/features/screen/Create%20Oraah/unsplash_page.dart';

class CreateOraah extends StatelessWidget {
  CreateOraah({super.key});

  final createOraahController = Get.find<CreateOraahController>();
  // final myAnimationController = Get.put(MyAnimationController());
  // final deviceController = Get.find<DeviceSpacController>();
  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    bool isDark = platformBrightness == Brightness.dark;

    List<EditIconFunc> iconList = [
      EditIconFunc(
          icon: Icons.image,
          label: 'Add Image',
          onTap: () {
            displayBottomSheet(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: 75,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  !isDark ? Colors.grey[200] : Colors.black12,
                            ),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      LineAwesomeIcons.camera,
                                      size: 25,
                                    )),
                                Text(
                                  "Camera",
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            )),
                        Container(
                            height: 75,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  !isDark ? Colors.grey[200] : Colors.black12,
                            ),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      createOraahController
                                          .pickImageFromGallery();
                                      // print("File Name: ${createOraahController.selectedGalleryImage}");
                                    },
                                    icon: const Icon(
                                      Icons.photo_outlined,
                                      size: 25,
                                    )),
                                Text(
                                  "Gallery",
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            Get.off(() => UnsplashPage(),
                                transition: Transition.circularReveal,
                                duration: const Duration(seconds: 1));
                          },
                          child: Container(
                            height: 75,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  !isDark ? Colors.grey[200] : Colors.black12,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/unsplash_icon.png',
                                  scale: 3,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Unsplash",
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text("Image")
                  ],
                ));
          }),
      EditIconFunc(
          icon: Icons.photo_size_select_small_rounded,
          label: 'Size',
          onTap: () {
            displayBottomSheet(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(
                      () => Slider(
                          value: createOraahController.sliderValue.value,
                          max: 25,
                          divisions: 20,
                          label: createOraahController.sliderValue.value
                              .round()
                              .toString(),
                          onChanged: (val) {
                            createOraahController.sliderValue.value = val;
                          }),
                    ),
                    const SizedBox(
                      child: Text("Size"),
                      // alignment: Alignment.bottomCenter,
                    )
                  ],
                ));
          }),
      EditIconFunc(
          icon: Icons.color_lens,
          label: 'Background',
          onTap: () {
            pickColol(context, "Pick Background Color");
          }),
      EditIconFunc(
          icon: Icons.format_paint_sharp,
          label: 'Text Color',
          onTap: () {
            pickColol(context, "Pick Text Color");
          }),
      EditIconFunc(
          icon: Icons.text_fields,
          label: 'Font',
          onTap: () {
            displayBottomSheet(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: createOraahController.fontsNames.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    createOraahController.fontFamily.value =
                                        createOraahController.fontsNames[index];
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 75,
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white54,
                                      ),
                                      child: Center(
                                        child: Text("Aa",
                                            style: TextStyle(
                                                fontFamily:
                                                    createOraahController
                                                        .fontsNames[index],
                                                fontSize: 16,
                                                color: Colors.black)),
                                      )),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      child: Text("Fonts"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ));
          }),
      EditIconFunc(
          icon: Icons.opacity_sharp,
          label: 'Opacity',
          onTap: () {
            displayBottomSheet(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(
                      () => Slider(
                          value: createOraahController.opacityValue.value,
                          max: 1,
                          divisions: 5,
                          label: createOraahController.opacityValue.value
                              .round()
                              .toString(),
                          onChanged: (val) {
                            createOraahController.opacityValue.value = val;
                          }),
                    ),
                    const SizedBox(
                      child: Text("Opacity"),
                      // alignment: Alignment.bottomCenter,
                    )
                  ],
                ));
          }),
      EditIconFunc(icon: Icons.save, label: 'Save', onTap: () {}),
      EditIconFunc(
          icon: Icons.branding_watermark, label: 'Watermark', onTap: () {}),
    ];

    // String fsQuote = createOraahController.quotes.first["Text"] ?? "No Quote";
    // String fsAuther = createOraahController.quotes.first["author"] ?? "No Author";
    // final deviceController = DeviceSpacController(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //? => Oraah Area
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.format_align_left),
                onPressed: () {},
                color: Colors.grey,
              ),
              IconButton(
                icon: const Icon(Icons.format_align_right),
                onPressed: () {},
                color: Colors.grey,
              ),
              IconButton(
                icon: const Icon(Icons.format_align_center),
                onPressed: () {},
                color: Colors.grey,
              ),
              Obx(
                () => IconButton(
                  icon: Icon(
                    createOraahController.isEditingText.value
                        ? Icons.check
                        : Icons.edit_document,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    createOraahController.toggleEditing();
                    if (!createOraahController.isEditingText.value) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 350,
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: Card(
                      elevation: 2,
                      // color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      child: Obx(
                        () => Opacity(
                          opacity: createOraahController.opacityValue.value,
                          child: createOraahController
                                      .selectedGalleryImage.value !=
                                  null
                              ? Image.file(
                                  createOraahController
                                      .selectedGalleryImage.value!,
                                  fit: BoxFit.cover,
                                )
                              : createOraahController.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : createOraahController
                                              .backgorundImage.value ==
                                          ""
                                      ? Image.network(
                                          'https://images.unsplash.com/photo-1682686581220-689c34afb6ef?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          createOraahController
                                              .backgorundImage.value,
                                          fit: BoxFit.cover,
                                        ),
                        ),
                      )),
                ),
              ),
              Positioned(
                top: 60,
                left: 28,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 16, left: 10),
                    // color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //? => Oraah Text
                        Obx(() => createOraahController.isEditingText.value
                            ? TextField(
                                controller:
                                    createOraahController.textEditingController,
                                onSubmitted: (newValue) {
                                  createOraahController.initialText.value =
                                      newValue;
                                  createOraahController.isEditingText.value =
                                      true;
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                style: const TextStyle(color: Colors.white),
                                // maxLength: 50,
                                maxLines: 8,
                              )
                            : Obx(() => InkWell(
                                  onTap: () {
                                    createOraahController.isEditingText.value =
                                        true;
                                    createOraahController
                                        .editorVisibility.value = false;
                                    // createOraahController.toggleEditing();
                                  },
                                  child: AutoSizeText(
                                      createOraahController.textEditingController.text,
                                      style: TextStyle(
                                        fontSize: createOraahController
                                            .sliderValue.value,
                                        fontFamily: createOraahController
                                            .fontFamily.value,
                                        color: createOraahController
                                            .textColor.value,
                                        height: 1.8,
                                      )),
                                ))),
                        //? => Authror of the Oraah Text
                        // GestureDetector(
                        //     child: Obx(
                        //   () => Text(createOraahController.fsAuthor.value,
                        //       style: TextStyle(
                        //           fontSize:
                        //               createOraahController.sliderValue.value,
                        //           color:
                        //               createOraahController.textColor.value,
                        //           fontFamily: createOraahController
                        //               .fontFamily.value)),
                        // )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          //? => Editting Area
          const Spacer(),
          Obx(() => AnimatedOpacity(
                opacity:
                    createOraahController.editorVisibility.value ? 1.0 : 0.0,
                duration: const Duration(seconds: 3),
                child: Visibility(
                  visible: createOraahController.editorVisibility.value,
                  child: Stack(
                    children: [
                      SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.96,
                          child: const Card(
                            elevation: 12,
                          )),
                      Positioned(
                        top: 0,
                        right: 3,
                        left: 3,
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            // alignment: WrapAlignment.spaceBetween,
                            children: iconList
                                .map((editIconFunc) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(editIconFunc.icon,
                                                size: 28),
                                            onPressed: editIconFunc.onTap,
                                          ),
                                          Text(
                                            editIconFunc.label,
                                            style: const TextStyle(fontSize: 9),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  // Color color = createOraahController.textColor.value;
  Widget buildColorPicker() => ColorPicker(
        pickerColor: createOraahController.textColor.value,
        labelTypes: const [],
        onColorChanged: (color) =>
            createOraahController.textColor.value = color,
      );

  void pickColol(BuildContext context, String title) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              title,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildColorPicker(),
                TextButton(
                  child: Text(
                    "Select",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ));

  Future displayBottomSheet(BuildContext context, Widget content) async {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        height: 200,
        child: Center(
          child: content,
        ),
      ),
    );
  }
}
