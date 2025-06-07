import 'dart:ui';
import 'package:az_health_care/modules/login/login_screen.dart';
import 'package:flutter/material.dart';
 import '../network/local/cache_helper.dart';
import '../components/components.dart';


String? token;


BoxDecoration boxDecorationForBackground = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/background_screen.jpg'),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      Colors.white.withValues(alpha: 0.3),
      BlendMode.srcOver,
    ),
  ),
);

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
