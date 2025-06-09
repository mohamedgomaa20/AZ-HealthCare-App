import 'package:az_health_care/features/on_boarding/presentation/views/widgets/custom_indicator.dart';
import 'package:az_health_care/features/on_boarding/presentation/views/widgets/on_boarding_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper_functions/cache_helper.dart';
import '../../../../modules/on_boarding/on_boarding_screen.dart';
import '../../../../shared/components/components.dart';
import '../../domain/models/boarding_model.dart';

class OnBoardingView extends StatelessWidget {
  static const routeName = "onBoardingView";

  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingViewBody(),
    );
  }
}

// class OnBoardingView extends StatefulWidget {
//   static const routeName = "onBoardingView";
//
//   const OnBoardingView({super.key});
//
//   @override
//   State<OnBoardingView> createState() => _OnBoardingViewState();
// }

// class _OnBoardingViewState extends State<OnBoardingView> {
//
//
//   var boardController = PageController();
//
//   bool isLast = false;
//
//   void skipOnBoarding(context) {
//     CacheHelper.setData(key: 'onBoarding', value: true)!.then((value) {
//       if (value) {
//         // navigateAndFinish(context, SocialLoginScreen());
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           defaultTextButton(
//             onPressed: () {
//               skipOnBoarding(context);
//             },
//             text: "skip",
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(),
//         child: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: PageView.builder(
//                   controller: boardController,
//                   physics: BouncingScrollPhysics(),
//                   itemCount: boardingItems.length,
//                   itemBuilder:
//                       (context, index) =>
//                           BuildBoardingItem(model: boardingItems[index]),
//                   onPageChanged: (int index) {
//                     if (index == boardingItems.length - 1) {
//                       setState(() {
//                         isLast = true;
//                       });
//                     } else {
//                       setState(() {
//                         isLast = false;
//                       });
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(height: 40),
//               Row(
//                 children: [
//                   CustomIndicator(
//                     count: boardingItems.length,
//                     pageController: boardController,
//                   ),
//                   Spacer(),
//                   FloatingActionButton(
//                     onPressed: () {
//                       if (isLast) {
//                         skipOnBoarding(context);
//                       } else {
//                         boardController.nextPage(
//                           duration: Duration(milliseconds: 750),
//                           curve: Curves.fastLinearToSlowEaseIn,
//                         );
//                       }
//                     },
//                     child: Icon(Icons.arrow_forward_ios),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
