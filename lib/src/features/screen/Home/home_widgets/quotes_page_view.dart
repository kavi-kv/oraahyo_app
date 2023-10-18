import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../controllers/quotes/quotes_controller.dart';
import '../../../model/quotes/quotesModel.dart';


class QuotesPageView extends StatefulWidget {
  final QuoteModel selectedQuote;
  final Color selectedColor;
  const QuotesPageView({
    Key? key,
    required this.selectedQuote,
    required this.selectedColor,
  }) : super(key: key);

  @override
  State<QuotesPageView> createState() => _QuotesPageViewState();
}

class _QuotesPageViewState extends State<QuotesPageView> {
  final quotesController = Get.put(QuotesController());
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = quotesController.quotes.indexOf(widget.selectedQuote);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(LineAwesomeIcons.alternate_long_arrow_left,
              color: Colors.white),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert_outlined, color: Colors.white),
          )
        ],
        backgroundColor: widget.selectedColor,
        elevation: 0,
      ),
      body: PageView.builder(
        itemCount: quotesController.quotes.length, // You only have one card
        scrollDirection: Axis.horizontal,
        controller: PageController(initialPage: currentIndex),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final swipedQuote = quotesController.quotes[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            margin: EdgeInsets.all(0),
            color: widget.selectedColor,
            child: Container(
              alignment: Alignment.center,
              height: 300,
              padding: EdgeInsets.all(12),
              child: Text(
                swipedQuote.quoteText,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.apply(color: Colors.white, heightFactor: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
