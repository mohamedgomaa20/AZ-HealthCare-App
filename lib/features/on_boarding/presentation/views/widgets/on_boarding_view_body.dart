import 'package:az_health_care/features/on_boarding/presentation/views/widgets/custom_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../domain/models/boarding_model.dart';
import 'on_boarding_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentIndex = 0;
  bool isLast = false;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);

    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.round();
      });
      if (currentIndex == boardingItems.length - 1) {
        setState(() {
          isLast = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Visibility(
            visible: currentIndex != boardingItems.length - 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: kHorizontalPadding),
                  child: Text("Skip", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
          Expanded(child: OnBoardingPageView(pageController: pageController)),
          CustomIndicator(
            count: boardingItems.length,
            pageController: pageController,
          ),
          SizedBox(height: 25),
          Visibility(
            visible: currentIndex != boardingItems.length - 1,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
              ),
              child: CustomButton(buttonText: 'Get Started', onPressed: () {}),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
