import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_image_controller.dart';

class DailyQuotes extends StatelessWidget {
  const DailyQuotes(
      {super.key,
      required QuotesController quotesController,
      required this.imageController})
      : _quotesController = quotesController;

  final QuotesController _quotesController;
  final QuotesImageController imageController;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 300,
              child: Swiper(
                itemHeight: 100,
                itemWidth: MediaQuery.of(context).size.width * 0.7,
                loop: true,
                duration: 1200,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  String imageUrl = imageController.photos[index].urls?['small'];
                  return Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 80,
                      decoration: BoxDecoration(
                          // image: NetworkImage(imageUrl),),
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                           borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      )));
                },
                itemCount: _quotesController.quotes.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
