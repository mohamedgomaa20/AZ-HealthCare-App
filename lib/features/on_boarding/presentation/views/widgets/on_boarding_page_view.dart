import 'package:az_health_care/features/on_boarding/presentation/views/widgets/page_view_item.dart';
import 'package:flutter/material.dart';

import '../../../data/models/boarding_model.dart';


class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});
   final PageController pageController ;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemBuilder: (context, index) => PageViewItem(model: boardingItems[index]),
      itemCount: boardingItems.length,
      physics: const BouncingScrollPhysics(),
    );
  }
}
