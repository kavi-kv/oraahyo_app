import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget CustomLoading() => LoadingAnimationWidget.flickr(
      leftDotColor: Colors.black,
      rightDotColor: const Color(0xFFFD0079),
      size: 25,
    );
Widget errorIcon() => const Icon(
  Icons.image_not_supported_rounded,
  color: Colors.grey,
);
