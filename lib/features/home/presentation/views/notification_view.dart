import 'package:az_health_care/features/home/presentation/views/widget/home_view_body.dart';
import 'package:az_health_care/features/home/presentation/views/widget/notification_view_body.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});
  static const routeName = "NotificationView";

  @override
  Widget build(BuildContext context) {
    return NotificationViewBody();
  }
}
