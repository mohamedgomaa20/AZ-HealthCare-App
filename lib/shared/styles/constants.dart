import 'package:dartz/dartz_streaming.dart';

import '../../core/helper_functions/cache_helper.dart';

String? token;

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      // navigateAndFinish(context, LoginScreen());
    }
  });
}
 void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
