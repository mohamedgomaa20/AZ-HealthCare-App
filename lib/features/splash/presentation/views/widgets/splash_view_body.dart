 import 'package:az_health_care/core/utils/app_images.dart';
import 'package:az_health_care/features/home/presentation/views/home_layout.dart';
import 'package:az_health_care/features/splash/presentation/views/widgets/animated_image_widget.dart';
import 'package:az_health_care/features/splash/presentation/views/widgets/animated_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/services/cache_helper.dart';
import '../../../../get_start/presentation/views/get_start_view.dart';
import '../../../../on_boarding/presentation/views/on_boarding_view.dart';

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
    executeNavigation();
    _initAnimationController();
    _initAnimations();
    animationController.forward();
    super.initState();
  }

  void startWidget() {
    bool isOnBoardingScreen =
        CacheHelper.getData(key: kIsOnBoardingScreen) ?? false;
    String token = CacheHelper.getData(key: kToken) ?? "";

    if (isOnBoardingScreen) {
      if (token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, HomeLayout.routeName);
      } else {
        Navigator.pushReplacementNamed(context, GetStartView.routeName);
      }
    } else {
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    }
  }

  void executeNavigation() {

    Future.delayed(Duration(seconds: 3), () async {
      await animationController.reverse();
      startWidget();
    });
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
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    slideText = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

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
        builder:
            (context, child) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedImageWidget(
                  opacity: fadeInImage,
                  position: slideImage,
                  imagePath: AppImages.onboardImage1,
                ),
                const SizedBox(height: 24),
                AnimatedTextWidget(
                  opacity: fadeInText,
                  position: slideText,
                  text: "A2Z Care",
                ),
              ],
            ),
      ),
    );
  }
}
