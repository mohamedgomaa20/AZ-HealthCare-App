import 'package:az_health_care/features/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatelessWidget {
  static const routeName = "onBoardingView";

  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator(),

    ));
  }
}
