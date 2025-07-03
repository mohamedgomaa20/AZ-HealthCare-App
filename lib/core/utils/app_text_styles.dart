import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle regular10 = TextStyle(fontSize: 10);
  static const TextStyle regular14 = TextStyle(fontSize: 14);

  static const TextStyle regular16 = TextStyle(fontSize: 16);
  static const TextStyle bold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );

  static const TextStyle bold20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );
  static const TextStyle semiBold18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );
  static const TextStyle semiBold14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );
  static const TextStyle bold18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.white54Color,
  );
  static const TextStyle bold24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle bold22 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.white70Color,
  );
  static const TextStyle bold26 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle bold48 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );

  static const TextStyle semiBold28 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle bold28 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle bold30 = TextStyle(
    fontSize: 30,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle semiBold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );

  static const TextStyle medium14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle regular12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle regular14Grey = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  static const TextStyle titleWhite24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle redLink14 = TextStyle(
    fontSize: 14,
    color: Colors.red,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );

  static const TextStyle inputLabelWhite = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle welcomeHeadline = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle welcomeSubtitle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    height: 1.4,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle bold50PrimaryColor = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );

  static const TextStyle regular38White70 = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.normal,
    color: AppColors.white70Color,
  );
  static const TextStyle regular30White60 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.normal,
    color: AppColors.white60Color,
  );

  static const TextStyle regular25White54 = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.normal,
    color: AppColors.white54Color,
  );
  static const TextStyle regular20White30 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.white30Color,
  );
}
