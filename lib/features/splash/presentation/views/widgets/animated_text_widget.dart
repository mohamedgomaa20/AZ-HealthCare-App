 import 'package:flutter/material.dart';

import '../../../../../core/utils/app_text_styles.dart';

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
          textAlign: TextAlign.center,
          style: AppTextStyles.semiBold28,
        ),
      ),
    );
  }
}
