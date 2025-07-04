// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'constants.dart';
// import 'colors.dart';
//
// ThemeData lightMode() => ThemeData(
//   useMaterial3: false,
//   primaryColor:kPrimaryColor,
//   // primarySwatch: kPrimaryColor,
//   scaffoldBackgroundColor: Colors.white,
//   fontFamily: "jannah",
//   textTheme: TextTheme(
//     bodyMedium: TextStyle(
//       fontSize: 18,
//       fontWeight: FontWeight.w600,
//       color: Colors.black,
//     ),
//   ),
//   appBarTheme: AppBarTheme(
//     titleSpacing: 20,
//     systemOverlayStyle: SystemUiOverlayStyle(
//       statusBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.dark,
//     ),
//     backgroundColor: Colors.white,
//     elevation: 0,
//     titleTextStyle: TextStyle(
//       color: Colors.black,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//     iconTheme: IconThemeData(color: Colors.black),
//   ),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     type: BottomNavigationBarType.fixed,
//     unselectedItemColor: Colors.grey,
//     backgroundColor: Colors.white,
//
//     selectedItemColor:kPrimaryColor,
//   ),
// );
//
// ThemeData darkMode() => ThemeData(
//   useMaterial3: false,
//   fontFamily: "jannah",
//
//   textTheme: TextTheme(
//     bodyMedium: TextStyle(
//       fontSize: 18,
//       fontWeight: FontWeight.w600,
//       color: Colors.white,
//     ),
//   ),
//
//   // primarySwatch: defaultColor,
//   scaffoldBackgroundColor: kPrimaryColor,
//
//   inputDecorationTheme: InputDecorationTheme(
//     labelStyle: WidgetStateTextStyle.resolveWith((states) {
//       if (states.contains(MaterialState.focused)) {
//         return TextStyle(color: kPrimaryColor);
//       }
//       return TextStyle(color: Colors.white);
//     }),
//     floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
//       if (states.contains(WidgetState.focused)) {
//         return TextStyle(color: kPrimaryColor);
//       }
//       return TextStyle(color: Colors.grey[400]);
//     }),
//     prefixIconColor: WidgetStateColor.resolveWith((states) {
//       if (states.contains(WidgetState.focused) ||
//           states.contains(WidgetState.pressed)) {
//         return kPrimaryColor;
//       }
//       return Colors.white;
//     }),
//     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.grey[700]!),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: kPrimaryColor, width: 2),
//       borderRadius: BorderRadius.circular(12),
//     ),
//   ),
//
//   appBarTheme: AppBarTheme(
//     titleSpacing: 20,
//
//     // actionsIconTheme: IconThemeData(color: Colors.white),
//     systemOverlayStyle: SystemUiOverlayStyle(
//       statusBarColor: Color(0xff232323),
//       statusBarBrightness: Brightness.light,
//       statusBarIconBrightness: Brightness.light,
//     ),
//     backgroundColor: kPrimaryColor,
//     elevation: 0,
//     titleTextStyle: TextStyle(
//       color: Colors.white,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//     iconTheme: IconThemeData(color: Colors.white),
//   ),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     type: BottomNavigationBarType.fixed,
//     selectedItemColor: kPrimaryColor,
//     unselectedItemColor: Colors.grey,
//     backgroundColor: kPrimaryColor,
//   ),
//
// );
