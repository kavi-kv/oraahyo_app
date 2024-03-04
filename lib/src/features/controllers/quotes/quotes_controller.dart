import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oraah_app/src/common_widgets/api_address.dart';
import 'package:oraah_app/src/features/model/quotes/authorsModel.dart';
import 'package:oraah_app/src/repository/quotes_repo/quotes_repo.dart';
// import 'package:screenshot/screenshot.dart';
import '../../model/quotes/quotesModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as flutter;
import 'dart:io';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:auto_size_text/auto_size_text.dart';

class QuotesController extends GetxController {
  static QuotesController get instance => Get.find();
  // final BuildContext context;
  RxList<QuoteModel> quotes = <QuoteModel>[].obs;
  RxList<QuoteModel> quotesByCategory = <QuoteModel>[].obs;
  RxList<QuoteModel> quotesByAuthor = <QuoteModel>[].obs;
  RxList<QuoteModel> storyQuotes = <QuoteModel>[].obs;
  RxList<AuthorsModel> listOfAuthors = <AuthorsModel>[].obs;
  RxBool isCategoryValid = false.obs;
  RxString authorName = ''.obs;
  RxBool isCardClicked = false.obs;
  RxBool isLoading = true.obs;
  RxBool isAuthersLoading = false.obs;
  final random = Random();
  RxList<RxBool> isIconVisibleList = <RxBool>[].obs;
  RxList<GlobalKey> containerKeys = <GlobalKey>[].obs;
  RxDouble deviceWidth = 0.0.obs;
  RxDouble deviceHeight = 0.0.obs;
  var repository = QuotesRepository();
  RxInt quotesList = 0.obs;
  List<String> tabs = [
    "All",
    "Newest",
    "Popular",
    "Latest",
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // fetchQuotes();
    fetchListOfAuthers();
    // checkAndFetchQuotes();
    fetchStoryQuotes();
  }

  @override
  void dispose() {
    super.dispose();
    // fetchQuotes();
  }

  /* Controll quotes icon visibilty */
  void IconsVisibilityState(int itemCount) {
    isIconVisibleList.assignAll(List.generate(itemCount, (index) => false.obs));
  }

  // Future<void> checkAndFetchQuotes() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? lastFetchTimeString = prefs.getString('lastFetchTime');

  //   DateTime lastTime;

  //   if (lastFetchTimeString != null) {
  //     lastTime = DateTime.parse(lastFetchTimeString);
  //   } else {
  //     lastTime = DateTime.now().subtract(const Duration(days: 1));
  //   }

  //   DateTime now = DateTime.now();
  //   if (now.difference(lastTime).inHours >= 24) {
  //     await fetchStoryQuotes();
  //   }
  // }

  Future<void> fetchStoryQuotes() async {
    try {
      isLoading.value = true;
      List<QuoteModel> allQuotes = await repository.fetchQuotes();

      if (allQuotes.isNotEmpty) {
        Set<int> index = {};
        int numOfQuotesToFetch = min(5, allQuotes.length);
        while (index.length < numOfQuotesToFetch) {
          int randomIndex = random.nextInt(allQuotes.length);
          index.add(randomIndex);
        }

        List<QuoteModel> randomQuotes =
            index.map((quote) => allQuotes[quote]).toList();
        storyQuotes.value = randomQuotes;
      } else {
        flutter.log("No Available Quotes");
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastFetchTime', DateTime.now().toIso8601String());
    } catch (error) {
      flutter.log("Error on fetching Daily quotes");
    }
    isLoading.value = false;
  }

  Future<void> fetchQuotes() async {
    try {
      isLoading.value = true;
      quotes.value = await repository.fetchQuotes();
      IconsVisibilityState(quotes.length);
    } catch (err) {
      flutter.log("Error: $err");
    }
    isLoading.value = false;
  }

  // bool isFavorite()

  Future<void> fetchQuotesByCategory(String category) async {
    isLoading.value = true;
    try {
      quotesByCategory.value = await repository.byCategory(category);
    } catch (error) {
      flutter.log("Error $error");
    }
    isLoading.value = false;
  }

  Future<void> fetchListOfAuthers() async {
    isLoading.value = true;
    try {
      listOfAuthors.value = await repository.authorsList();
      flutter.log("Authers Fetched successfully");
    } catch (err) {
      flutter.log("Error $err");
    }

    isLoading.value = false;
  }

  Future<void> fetchByAuthor(String authorName) async {
    isLoading.value = true;
    try {
      quotesByAuthor.value = await repository.byAuthor(authorName);
      flutter.log("Successfully fetched autherName: $authorName by quotes");
    } catch (err) {
      flutter.log("Error: $err");
    }
    isLoading.value = false;
  }

  Future<void> isCategoryExists() async {
    isLoading.value = true;
    try {
      isCategoryValid.value = await repository.isCategoryExists();
    } catch (err) {
      flutter.log("Error: $err");
    }
  }

  void copyTextToClipboard(String quote, BuildContext context) {
    Clipboard.setData(ClipboardData(text: quote));

    ElegantNotification.success(
      description: const AutoSizeText(
        "Copied to clipboard",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
      ),
      height: 60,
      animation: AnimationType.fromRight,
      showProgressIndicator: false,
      displayCloseButton: false,
    ).show(context);
  }

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
      //? For dark mode, avoid generating white or closely related colors
      return colorBrightness > lightBrightnessThreshold;
    } else {
      //? For light mode, avoid generating black or closely related colors
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
