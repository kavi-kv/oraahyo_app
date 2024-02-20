import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
      {super.key, required this.text, required this.gradient, this.style});

  final String text;
  final Gradient gradient;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width * 0.9, bounds.height),
      ),
      child: Text(
        text,
        style: (style ?? const TextStyle()).copyWith(color: Colors.white),
      ),
    );
  }
}
