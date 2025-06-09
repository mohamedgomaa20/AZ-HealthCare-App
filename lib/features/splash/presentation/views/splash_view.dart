import 'package:az_health_care/features/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';

import '../../../on_boarding/presentation/views/on_boarding_view.dart';

class SplashView extends StatefulWidget {
  static const routeName = "splashView";

  const SplashView({super.key});


  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    executeNavigation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashViewBody());
  }
  void executeNavigation(){
    Future.delayed(Duration(seconds: 3),() {
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    },);

  }
}



