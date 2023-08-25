

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oraah_app/src/features/screen/Home/home_widgets/quotes_page_view.dart';


import '../../../controllers/quotes_controller.dart';

class QuotesOfTheDay extends StatelessWidget {
  
  const QuotesOfTheDay({
    super.key,
    required QuotesController quotesController, required this.brightness,
  }) : _quotesController = quotesController;

  final QuotesController _quotesController;
  final Brightness brightness;
  
  
  
  @override
  Widget build(BuildContext context) { 
    final Map<int,Color> generatedColors = {};
    return Obx(
      () => SizedBox(
        height: 100,
        child: ListView.builder(
          itemCount: _quotesController.quotes.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              if(!generatedColors.containsKey(index)) {
                generatedColors[index] = _quotesController.randomColor(brightness);
              }

              final generatedColor = generatedColors[index]!;

              Get.to(()=> QuotesPageView(
                selectedQuote: _quotesController.quotes[index],
                selectedColor:   generatedColor
              ));
            },
            child: SizedBox(
              width: 100,
              height: 100,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(12),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: _quotesController.randomColor(brightness)),
                        
                    child: Center(
                      child: Text(
                        _quotesController.quotes[index].quoteText,
                        style: Theme.of(context).textTheme.bodySmall?.apply(color: Colors.white),    
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
