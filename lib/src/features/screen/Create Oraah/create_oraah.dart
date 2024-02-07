import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oraah_app/src/features/controllers/others/deviceSpecController.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:oraah_app/src/features/screen/Create%20Oraah/edit_icons_func.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CreateOraah extends StatelessWidget {
  const CreateOraah({super.key});

  @override
  Widget build(BuildContext context) {
    double sliderValue = 16.0;
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
                              color: Colors.grey[200],
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
                              color: Colors.grey[200],
                            ),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () {},
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
                        Container(
                          height: 75,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.logo_dev_sharp,
                                    size: 25,
                                  )),
                              Text(
                                "Unsplash",
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: const Text("Image"),
                      // alignment: Alignment.bottomCenter,
                    )
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
                    Slider(
                        value: sliderValue,
                        max: 100,
                        divisions: 5,
                        label: sliderValue.round().toString(),
                        onChanged: (val) {
                          sliderValue = val;
                        }),
                    const SizedBox(
                      child: Text("Size"),
                      // alignment: Alignment.bottomCenter,
                    )
                  ],
                ));
          }),
      EditIconFunc(icon: Icons.color_lens, label: 'Background', onTap: () {}),
      EditIconFunc(
          icon: Icons.format_paint_sharp, label: 'Text Color', onTap: () {}),
      EditIconFunc(icon: Icons.text_fields, label: 'Font', onTap: () {}),
      EditIconFunc(icon: Icons.opacity_sharp, label: 'Opacity', onTap: () {}),
      EditIconFunc(icon: Icons.save, label: 'Save', onTap: () {}),
      EditIconFunc(
          icon: Icons.branding_watermark, label: 'Watermark', onTap: () {}),
    ];

    String fsQuote = quotes.first["Text"] ?? "No Quote";
    String fsAuther = quotes.first["author"] ?? "No Author";
    final deviceController = DeviceSpacController(context);
    bool isDarkMode = deviceController.brightnessLight == Brightness.dark;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //? => Oraah Area
          const Spacer(),
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
                    child: Image.network(
                      'https://images.unsplash.com/photo-1682686581220-689c34afb6ef?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 28,
                child: Center(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.85,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 16, left: 10),
                    // color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //? => Oraah Text
                        GestureDetector(
                          onTap: () {},
                          child: AutoSizeText(
                            fsQuote,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.apply(color: Colors.white, heightDelta: 0.5),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //? => Authror of the Oraah Text
                        GestureDetector(
                          child: const Text(''),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          //? => Editting Area
          const Spacer(),
          Stack(
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
                                    icon: Icon(editIconFunc.icon, size: 28),
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
          )
        ],
      ),
    );
  }

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
