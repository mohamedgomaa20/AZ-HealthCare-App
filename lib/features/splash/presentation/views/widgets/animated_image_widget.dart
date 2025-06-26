 import 'package:flutter/material.dart';

class AnimatedImageWidget extends StatelessWidget {
  final Animation<double> opacity;
  final Animation<Offset> position;
  final String imagePath;
  final double height;

  const AnimatedImageWidget({
    super.key,
    required this.opacity,
    required this.position,
    required this.imagePath,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: position,
        child: Image.asset(imagePath, height: height),
      ),
    );
  }
}
