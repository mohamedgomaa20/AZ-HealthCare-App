import 'package:az_health_care/features/on_boarding/presentation/views/widgets/page_view_item.dart';
import 'package:flutter/material.dart';

 import '../../../domain/models/boarding_model.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key});
  // const OnBoardingPageView({super.key, required this.boardingController});
  // final PageController boardingController ;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // controller: boardingController,
      itemBuilder: (context, index) => PageViewItem(model: boardingItems[index]),
      itemCount: boardingItems.length,
      physics: const BouncingScrollPhysics(),
    );
  }
}
