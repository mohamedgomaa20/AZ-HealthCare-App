import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/network/local/cache_helper.dart';
 import '../../shared/components/components.dart';
import '../../shared/styles/constants.dart';
import '../get_started/get_started_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boardingItems = [
    BoardingModel(
      image: "assets/images/onboard_1.png",
      title: "Welcome to AZ Healthcare",
      body:
          "Your personal AI-powered healthcare companion, ready to assist you anytime, anywhere.",
    ),
    BoardingModel(
      image: "assets/images/onboard_2.jpg",
      title: "AI-Powered Diagnosis",
      body:
          "Get instant medical insights and preliminary diagnoses using advanced AI technology.",
    ),
    BoardingModel(
      image: "assets/images/onboard_3.png",
      title: "24/7 Medical Support",
      body:
          "Access medical advice and support around the clock, whenever you need it.",
    ),
    BoardingModel(
      image: "assets/images/onboard_4.jpg",

      title: "Your Health Journey",
      body:
          "Track your health progress and get personalized recommendations for a healthier life.",
    ),
  ];

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
                        BuildBoardingItem(model: boardingItems[index]),
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

class BuildBoardingItem extends StatelessWidget {
  final BoardingModel model;

  const BuildBoardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Image.asset(model.image, width: double.infinity, height: 420),
          Text(
            textAlign: TextAlign.center,
            model.title,
            style: TextStyle(
              fontSize: 23,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text(
            textAlign: TextAlign.center,
            model.body,
            style: TextStyle(fontSize: 17, color: Colors.grey

            // ,fontStyle: FontStyle.italic
            ),
          ),
        ],
      ),
    );
  }
}

/*


import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  final VoidCallback onStart;

  OnBoardingScreen({required this.onStart});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'assets/oo.png',
      title: 'Welcome to the App!',
      description: 'This is the first page of onboarding.',
    ),
    OnboardingPage(
      image: 'assets/gg.png',
      title: 'Stay Connected',
      description: 'Connect with your friends and family.',
    ),
    OnboardingPage(
      image: 'assets/op.png',
      title: 'Manage Your Tasks',
      description: 'Keep track of your tasks efficiently.',
    ),
    OnboardingPage(
      image: 'assets/uu.png',
      title: 'Get Started Now!',
      description: 'Join us and start your journey.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return OnboardingPageContent(page: _pages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage < _pages.length - 1)
                  TextButton(
                    onPressed: widget.onStart,
                    child: Text('Skip', style: TextStyle(color: Colors.white)),
                  ),
                Row(
                  children: List.generate(_pages.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor:
                        _currentPage == index ? Colors.white : Colors.grey,
                      ),
                    );
                  }),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _pages.length - 1) {
                      _pageController.animateToPage(
                        _currentPage + 1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      widget.onStart();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      _currentPage == _pages.length - 1
                          ? 'Get Started'
                          : 'Next',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingPageContent extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageContent({required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(page.image),
        SizedBox(height: 16.0),
        Text(
          page.title,
          style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

 */
