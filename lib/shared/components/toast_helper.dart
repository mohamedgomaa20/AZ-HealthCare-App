import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  static void showToast(
      BuildContext context,
      String message, {
        Color color = Colors.black87,
        IconData? icon,
        ToastGravity gravity = ToastGravity.BOTTOM,
      }) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // 🔹 يجعل العرض بقدر المحتوى فقط
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8.0),
          ],
          Flexible( // 🔹 يسمح للنص بأن يكون داخل الحدود دون أن يمتد العرض لكامل الشاشة
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              softWrap: true,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: const Duration(seconds: 3),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class ToastHelper {
//   static void showToast(
//     BuildContext context,
//     String message, {
//     Color color = Colors.black87,
//     IconData? icon,
//     ToastGravity gravity = ToastGravity.BOTTOM,
//   }) {
//     FToast fToast = FToast();
//     fToast.init(context);
//
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.0),
//         color: color,
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (icon != null) ...[
//             Icon(icon, color: Colors.white),
//             const SizedBox(width: 8.0),
//           ],
//           Expanded(
//             child: Text(
//               message,
//               textAlign: TextAlign.center, // توسيط النص بالكامل
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//
//     fToast.showToast(
//       child: toast,
//       gravity: gravity,
//       toastDuration: const Duration(seconds: 3),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class ToastHelper {
//   static void showToast(
//       BuildContext context,
//       String message, {
//         Color color = Colors.black87,
//       }) {
//     FToast fToast = FToast();
//     fToast.init(context);
//
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.0),
//         color: color,
//       ),
//       child: IntrinsicWidth(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.info, color: Colors.white),
//                 SizedBox(width: 8.0),
//                 Expanded(
//                   child: Text(
//                     message,
//                     textAlign: TextAlign.center, // توسيط النص بالكامل
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//

//   }
// }
