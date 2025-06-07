// lib/widgets/animated_text_widget.dart
import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatelessWidget {
  final Animation<double> opacity;
  final Animation<Offset> position;
  final String text;

  const AnimatedTextWidget({
    super.key,
    required this.opacity,
    required this.position,
    required this.text,
  });


  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: position,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
           ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
