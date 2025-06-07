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
  late AnimationController _controller;
  late Animation<double> _fadeInImage;
  late Animation<Offset> _slideImage;
  late Animation<Offset> _slideText;
  late Animation<double> _fadeInText;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
    _initAnimations();
    _controller.forward();
  }

  void _initAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  void _initAnimations() {
    _fadeInImage = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );

    _slideImage = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideText = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    _fadeInText = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedImageWidget(
              opacity: _fadeInImage,
              position: _slideImage,
              imagePath: 'assets/images/onboard_1.png',
            ),
            const SizedBox(height: 24),
            AnimatedTextWidget(
              opacity: _fadeInText,
              position: _slideText,
              text: "AZ Healthcare",
            ),
          ],
        ),
      ),
    );
  }
}
