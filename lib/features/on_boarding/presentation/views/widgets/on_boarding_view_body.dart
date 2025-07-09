import 'package:az_health_care/features/on_boarding/presentation/views/widgets/custom_indicator.dart';
import 'package:flutter/material.dart';

import '../../../data/models/boarding_model.dart';
import 'on_boarding_actions_section.dart';
import 'on_boarding_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.round();
      });
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
    return Column(
      children: [
        Expanded(child: OnBoardingPageView(pageController: pageController)),
        CustomIndicator(
          count: boardingItems.length,
          pageController: pageController,
        ),
        SizedBox(height: 15),
        Divider(),
        SizedBox(height: 15),

        OnBoardingActionsSection(
          currentIndex: currentIndex,
          totalPages: boardingItems.length,
          pageController: pageController,
        ),

        SizedBox(height: 20),
      ],
    );
  }
}
