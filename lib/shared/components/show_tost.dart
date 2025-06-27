import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/utils/app_colors.dart';

class ToastHelper {
  static showToast({required String msg, required ToastStates state}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = AppColors.primaryColor;
      break;
    case ToastStates.ERROR:
      color = AppColors.redColor;
      break;
    case ToastStates.WARNING:
      color = AppColors.amberColor;
      break;
  }
  return color;
}
