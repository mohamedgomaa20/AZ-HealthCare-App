import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_colors.dart';

class ToastHelper {
  static showToast({
    required String msg,
    required ToastStates state,
    ToastGravity? gravity,
  }) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showToast2({
    required BuildContext context,
    required String msg,
    required ToastStates state,
    double bottomOffset = 20,
    int? duration,

  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: duration ?? 3),
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      elevation: 0,
      margin: EdgeInsets.only(bottom: bottomOffset),
      content: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: chooseToastColor(state),
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: const BoxConstraints(maxWidth: 300, minWidth: 50),
          child: Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

enum ToastStates { SUCCESS, ERROR, WARNING, INFO }

Color chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return AppColors.successColor;
    case ToastStates.ERROR:
      return AppColors.errorColor;
    case ToastStates.WARNING:
      return AppColors.warningColor;
    case ToastStates.INFO:
      return AppColors.infoColor;
  }
}
