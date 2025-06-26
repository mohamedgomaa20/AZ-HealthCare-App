import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

 import '../../../../../../core/widgets/space_widget.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [VerticalSpace(10), Text("Sign Up View Body",style: AppTextStyles.semiBold28,)],
      ),
    );
  }
}

// class LoginViewBody extends StatefulWidget {
//   const LoginViewBody({Key? key}) : super(key: key);
//
//   @override
//   State<LoginViewBody> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<LoginViewBody> {
//   final controller = PageController();
//   int currentPage = 0;
//
//   final pages = [
//     OnboardingPageModel(
//       image: AppImages.onboardImage1,
//       title: "Welcome to A2Z Healthcare",
//       description:
//           "Your personal AI-powered healthcare companion, ready to assist you anytime, anywhere made by Azhar Group.",
//     ),
//     OnboardingPageModel(
//       image: AppImages.onboardImage2,
//       title: "Features",
//       description:
//           "Step Tracker, Calories Tracking, Water Intake Tracker, Medication Reminder, Medication History, Blood Pressure Prediction (AI-powered), Accident Alert (sends location and alert to emergency contacts).",
//     ),
//     OnboardingPageModel(
//       image: AppImages.onboardImage3,      title: "VIP Features",
//       description:
//           "Ability to order medicine directly via the app with faster delivery and exclusive service. Request doctor consultations remotely through the app.",
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFFFCDD2), Color(0xFFB71C1C)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               flex: 10,
//               child: PageView.builder(
//                 controller: controller,
//                 itemCount: pages.length,
//                 onPageChanged: (index) {
//                   setState(() {
//                     currentPage = index;
//                   });
//                 },
//                 itemBuilder:
//                     (context, index) =>
//                         OnboardingPageWidget(model: pages[index]),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: SmoothPageIndicator(
//                 controller: controller,
//                 count: pages.length,
//                 effect: ExpandingDotsEffect(
//                   activeDotColor: Colors.black,
//                   dotColor: Colors.grey.shade300,
//                   dotHeight: 10,
//                   dotWidth: 10,
//                 ),
//               ),
//             ),
//             if (currentPage == 2)
//               Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // TODO: navigate to Get Start screen & save onboarding completed
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       minimumSize: const Size.fromHeight(50),
//                     ),
//                     child: const Text(
//                       "Get Start",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OnboardingPageModel {
//   final String image, title, description;
//
//   OnboardingPageModel({
//     required this.image,
//     required this.title,
//     required this.description,
//   });
// }

// class OnboardingPageWidget extends StatelessWidget {
//   final OnboardingPageModel model;
//
//   const OnboardingPageWidget({super.key, required this.model});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(model.image, height: 250),
//           const SizedBox(height: 32),
//           Text(
//             model.title,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             model.description,
//             style: const TextStyle(fontSize: 16),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
