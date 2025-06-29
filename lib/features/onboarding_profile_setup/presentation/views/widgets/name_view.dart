import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../data/profile_setup_cubit/onboarding_profile_setup_cubit.dart';

class NameView extends StatelessWidget {
  const NameView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = OnboardingProfileSetupCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "What's your name?",
            style: AppTextStyles.bold30,
            textAlign: TextAlign.center,
          ),
          const Spacer(),

          TextField(
            controller: cubit.nameController,
            onChanged: cubit.updateName,
            textAlign: TextAlign.center,
            style: AppTextStyles.bold28,
            cursorColor: Theme.of(context).primaryColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 35,
              ),
              hintText: 'Mohamed',
              filled: true,
              fillColor: AppColors.buttonColor,
              hintStyle: TextStyle(color: AppColors.grayColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppColors.grayColor, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
          ),

          const Spacer(),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../../../../../core/utils/app_colors.dart';
//
// class NameView extends StatefulWidget {
//   final Function(String) onNameEntered;
//   final String? initialName;
//
//   const NameView({super.key, required this.onNameEntered, this.initialName});
//
//   @override
//   State<NameView> createState() => _NameViewState();
// }
//
// class _NameViewState extends State<NameView> {
//   late TextEditingController nameController;
//
//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController(text: widget.initialName ?? '');
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "What's your name?",
//             style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const Spacer(),
//
//           TextField(
//             controller: nameController,
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 26,
//             ),
//             cursorColor: Theme.of(context).primaryColor,
//             decoration: const InputDecoration(
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 35,
//               ),
//               hintText: 'Mohamed',
//               filled: true,
//               fillColor: AppColors.buttonColor,
//               hintStyle: TextStyle(color: AppColors.grayColor),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//                 borderSide: BorderSide(color: AppColors.grayColor, width: 2.0),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: AppColors.primaryColor,
//                   width: 2.0,
//                 ),
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//               ),
//             ),
//             keyboardType: TextInputType.name,
//             textCapitalization: TextCapitalization.words,
//             inputFormatters: [
//               LengthLimitingTextInputFormatter(50), // maximum length
//             ],
//           ),
//
//           const Spacer(),
//           const SizedBox(height: 60),
//         ],
//       ),
//     );
//   }
// }

// import 'package:az_health_care/core/constants.dart';
// import 'package:az_health_care/core/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class NameView extends StatefulWidget {
//   final ValueChanged<String> onNameSubmitted;
//   final String? initialName;
//
//   const NameView({super.key, required this.onNameSubmitted, this.initialName});
//
//   @override
//   State<NameView> createState() => _NameViewState();
// }
//
// class _NameViewState extends State<NameView> {
//   late TextEditingController _nameController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.initialName);
//     _nameController.addListener(_onNameChanged);
//   }
//
//   @override
//   void dispose() {
//     _nameController.removeListener(_onNameChanged);
//     _nameController.dispose();
//     super.dispose();
//   }
//
//   void _onNameChanged() {
//     widget.onNameSubmitted(_nameController.text);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "What's your name?",
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 40),
//           const Spacer(flex: 2),
//
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             decoration: BoxDecoration(
//               color: AppColors.buttonColor,
//               // color: AppColors.grayColor[850],
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.2),
//                   spreadRadius: 2,
//                   blurRadius: 10,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: TextField(
//               controller: _nameController,
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               cursorColor: Theme.of(context).primaryColor,
//               decoration: const InputDecoration(
//                 hintText: 'Mohamed',
//                 hintStyle: TextStyle(color: AppColors.grayColor),
//                 border: InputBorder.none,
//               ),
//               keyboardType: TextInputType.name,
//               textCapitalization: TextCapitalization.words,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(50), // maximum length
//               ],
//             ),
//           ),
//
//           const Spacer(flex: 3),
//         ],
//       ),
//     );
//   }
// }
