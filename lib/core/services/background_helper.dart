// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
// import 'package:flutter_foreground_task/flutter_foreground_task.dart';
//
// class BackgroundHelper {
//   static Future<void> startForegroundService() async {
//     await FlutterForegroundTask.startService(
//       notificationTitle: 'Step Tracker Running',
//       notificationText: 'Tracking your steps in the background...',
//       callback: () {
//
//       },
//     );
//   }
//
//   static void openBatteryOptimizationSettings() {
//     const intent = AndroidIntent(
//       action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
//       flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
//     );
//     intent.launch();
//   }
//
//   static void openAppSettings() {
//     const intent = AndroidIntent(
//       action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
//       data: 'com.example.az_health_care',
//     );
//     intent.launch();
//   }
// }
//
//
// Future<void> initializeForegroundService() async {
//     FlutterForegroundTask.init(
//     androidNotificationOptions: AndroidNotificationOptions(
//       channelId: 'step_tracker_channel_id',
//       channelName: 'Step Tracker',
//       channelDescription: 'Tracking your steps in the background',
//       channelImportance: NotificationChannelImportance.LOW,
//       priority: NotificationPriority.LOW,
//       iconData: NotificationIconData(
//         resType: ResourceType.mipmap,
//         resPrefix: ResourcePrefix.ic,
//         name: 'launcher',
//       ),
//     ),
//     iosNotificationOptions: const IOSNotificationOptions(
//       showNotification: true,
//       playSound: false,
//     ),
//     foregroundTaskOptions: const ForegroundTaskOptions(
//       interval: 5000,
//       isOnceEvent: false,
//       autoRunOnBoot: true,
//       allowWakeLock: true,
//       allowWifiLock: true,
//     ),
//   );
// }
//
