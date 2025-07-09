import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/services/cache_helper.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../Auth/presentation/views/login/login_view.dart';
import '../../../../get_start/presentation/views/get_start_view.dart';

class OnBoardingActionsSection extends StatelessWidget {
  final int totalPages;
  final int currentIndex;
  final PageController pageController;

  const OnBoardingActionsSection({
    super.key,
    required this.currentIndex,
    required this.totalPages,

    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final isLast = currentIndex == totalPages - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: ConditionalBuilder(
        condition: isLast,
        builder:
            (context) => CustomButton(
              text: 'Get Started',
              onPressed: () {
                CacheHelper.saveData(key: kIsOnBoardingScreen, value: true);
                Navigator.pushReplacementNamed(context, GetStartView.routeName);
              },
            ),
        fallback:
            (context) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Skip',
                    backgroundColor: AppColors.darkGray,
                    onPressed: () {
                      CacheHelper.saveData(
                        key: kIsOnBoardingScreen,
                        value: true,
                      );
                      Navigator.pushReplacementNamed(
                        context,
                        GetStartView.routeName,
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: 'Continue',
                    onPressed: () {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 900),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    },
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
