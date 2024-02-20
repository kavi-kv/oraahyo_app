import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_controller.dart';
import 'package:oraah_app/src/features/controllers/quotes/quotes_image_controller.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required QuotesController quotesController,
      required this.imageController})
      : _quotesController = quotesController;

  final QuotesController _quotesController;
  final QuotesImageController imageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pinned: true,
            centerTitle: false,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
                background: Padding(
              padding: const EdgeInsets.all(0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Swiper(
                      itemHeight: 100,
                      itemWidth: MediaQuery.of(context).size.width * 0.7,
                      loop: true,
                      autoplay: true,
                      duration: 1200,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        String imageUrl =
                            imageController.photos[index].urls?['small'];
                        return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 80,
                            decoration: BoxDecoration(
                                // image: NetworkImage(imageUrl),),
                                // color: Colors.amber,
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  // margin:
                                  //     const EdgeInsets.symmetric(horizontal: 5),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                )));
                      },
                      itemCount: _quotesController.quotes.length,
                    ),
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
