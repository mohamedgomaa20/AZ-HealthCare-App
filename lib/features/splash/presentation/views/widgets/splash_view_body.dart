// lib/views/splash_view_body.dart
import 'package:az_health_care/features/splash/presentation/views/widgets/widgets/animated_image_widget.dart';
import 'package:az_health_care/features/splash/presentation/views/widgets/widgets/animated_text_widget.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeInImage;
  late Animation<Offset> slideImage;
  late Animation<Offset> slideText;
  late Animation<double> fadeInText;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
    _initAnimations();
    animationController.forward();
  }

  void _initAnimationController() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  void _initAnimations() {
    fadeInImage = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );

    slideImage = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    slideText = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    fadeInText = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, __) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedImageWidget(
              opacity: fadeInImage,
              position: slideImage,
              imagePath: 'assets/images/onboard_1.png',
            ),
            const SizedBox(height: 24),
            AnimatedTextWidget(
              opacity: fadeInText,
              position: slideText,
              text: "AZ Healthcare",
            ),
          ],
        ),
      ),
    );
  }
}
