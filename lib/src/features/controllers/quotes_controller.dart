import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:screenshot/screenshot.dart';
import '../model/quotes/quotesModel.dart';

class QuotesController extends GetxController {
  static QuotesController get instance => Get.find();
  // final BuildContext context;
  RxList<QuoteModel> quotes = <QuoteModel>[].obs;
  RxBool isCardClicked = false.obs;
  final random = Random();
  RxList<RxBool> isIconVisibleList = <RxBool>[].obs;
  RxList<GlobalKey> containerKeys = <GlobalKey>[].obs;
  RxDouble deviceWidth = 0.0.obs;
  RxDouble deviceHeight = 0.0.obs;
  final String EthIpV4 = "192.168.189.62";
  final String WIpV4 = "192.168.100.7";
  RxInt quotesList = 0.obs;
  List<String> tabs = [
    "All",
    "Newest",
    "Popular",
    "Latest",
  ].obs;

  // QuotesController(this.context);


/* Controll quotes icon visibilty */
  void IconsVisibilityState(int itemCount) {
    isIconVisibleList.assignAll(List.generate(itemCount, (index) => false.obs));
  }


  /* Fetch quotes text from backend database from the server */
  Future<void> fetchQuotes() async {
    final url = "http://" + EthIpV4 + ":5005/xikmado/quotes";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jsonData =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        quotes.assignAll(jsonData.map((item) => QuoteModel.fromJson(item)));
        print("Quotes data is : ${jsonData}");
      } else {
        print('Request failed with status code: ${response.statusCode}');
      }

      IconsVisibilityState(quotes.length);
    } catch (error) {
      print("Error: ${error}");
    }
  }

  /* Copy quotes as a text into your clipboard */
  void copyTextToClipboard(String quote) {
  Clipboard.setData(ClipboardData(text: quote));

  Get.snackbar(
    "",
    "",
    snackPosition: SnackPosition.BOTTOM, 
    backgroundColor: Colors.transparent, 
    colorText: Colors.white, 
    duration: Duration(seconds: 3), 
    barBlur: 0.0,
    snackStyle: SnackStyle.GROUNDED,
    margin: EdgeInsets.all(16.0),
    messageText: Text(
      "Copied to Clipboard",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        
      ),
    )
  );
}




  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
    // quotesList =  quotes.length as RxInt ;
    // containerKeys = List.generate(quotes.length, (index) => GlobalKey());
  }

  @override
  void dispose() {
    super.dispose();
    fetchQuotes();
  }

  /* Function for fetching local data */
  // Future<void> loadQuotes() async {
  //   String data = await rootBundle.loadString('assets/data/oraahyo.json');
  //   List<Map<String, dynamic>> jsonData =
  //       List<Map<String, dynamic>>.from(json.decode(data)['quotes']);
  //   quotes.assignAll(jsonData.map((item) => QuoteModel.fromJson(item)));

  //   IconsVisibilityState(quotes.length);
  // }

  Color randomColor(Brightness brightness) {
    final random = Random();
    Color color;
    do {
      color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
    } while (_isNotSuitable(color, brightness));
    return color;
  }

  bool _isNotSuitable(Color color, Brightness brightness) {
    final colorBrightness = _calculateColorBrightness(color);

    const darkBrightnessThreshold = 0.4;
    const lightBrightnessThreshold = 0.6;

    if (brightness == Brightness.dark) {
      // For dark mode, avoid generating white or closely related colors
      return colorBrightness > lightBrightnessThreshold;
    } else {
      // For light mode, avoid generating black or closely related colors
      return colorBrightness > darkBrightnessThreshold;
    }
  }

  double _calculateColorBrightness(Color color) {
    final brightness = sqrt(
      0.299 * pow(color.red, 2) +
          0.587 * pow(color.green, 2) +
          0.114 * pow(color.blue, 2),
    );

    return brightness / 255.0;
  }
}
