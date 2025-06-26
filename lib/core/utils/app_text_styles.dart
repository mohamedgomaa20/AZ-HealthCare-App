import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const TextStyle regular16 = TextStyle(fontSize: 16);


  static const TextStyle bold24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle semiBold28 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle semiBold18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ); // يُستخدم في شاشة SignUp لعنوان "UserName" و "Email" و "Create Password"

  static const TextStyle semiBold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ); // يُستخدم في الحقول مثل Label الحقول أو الأزرار الثانوية

  static const TextStyle medium14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ); // يُستخدم في النصوص التوضيحية داخل الحقول أو أسفلها

  static const TextStyle regular12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ); // يُستخدم للنصوص الصغيرة مثل "or continue with"

  static const TextStyle regular14Grey = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  ); // يُستخدم في Placeholder داخل الحقول مثل "Email" و "Create Password"

  static const TextStyle titleWhite24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ); // يُستخدم في شاشة Welcome لعنوان "Welcome to A2Z Care!"

  static const TextStyle redLink14 = TextStyle(
    fontSize: 14,
    color: Colors.red,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  ); // يُستخدم في شاشة SignUp لرابط "Sign in" و "Terms & Conditions"

  static const TextStyle inputLabelWhite = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ); // يُستخدم لتسميات الحقول في نموذج التسجيل مثل "Email"

  static const TextStyle welcomeHeadline = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ); // يُستخدم كعنوان رئيسي في شاشة الترحيب

  static const TextStyle welcomeSubtitle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    height: 1.4,
    textBaseline: TextBaseline.alphabetic,
  ); // يُستخدم كنص توضيحي في شاشة Welcome أسفل العنوان

}
