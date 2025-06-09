import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/network/local/cache_helper.dart';
 import '../../features/on_boarding/domain/models/boarding_model.dart';
import '../../features/on_boarding/presentation/views/widgets/page_view_item.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/constants.dart';
import '../get_started/get_started_screen.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {


  var boardController = PageController();

  bool isLast = false;

  void skipOnBoarding(context) {
    CacheHelper.setData(key: 'onBoarding', value: true)!.then((value) {
      if (value) {
        navigateTo(context, GetStartedScreen());
        // navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: boxDecorationForBackground,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemCount: boardingItems.length,
                itemBuilder:
                    (context, index) =>
                        PageViewItem(model: boardingItems[index]),
                onPageChanged: (int index) {
                  if (index == boardingItems.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 30.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!isLast)
                    defaultTextButton(
                      onPressed: () {
                        skipOnBoarding(context);
                      },
                      text: "skip",
                    ),
                  Spacer(),
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boardingItems.length,
                    effect: ExpandingDotsEffect(
                      expansionFactor: 4,
                      spacing: 5.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.white,
                    ),
                  ),
                  Spacer(),

                  ElevatedButton(
                    onPressed: () {
                      if (isLast) {
                        skipOnBoarding(context);
                      } else {
                        boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Text(
                        isLast ? 'Get Started' : 'Next',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

