// import 'dart:io';
//  import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static Future<void> initialize() async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: androidSettings);
//     await _notificationsPlugin.initialize(settings);
//   }
//
//   static Future<void> showSimpleNotification({
//     required String title,
//     required String body,
//     int id = 0,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'simple_channel',
//       'Simple Notifications',
//       channelDescription: 'Channel for simple notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//     const notificationDetails = NotificationDetails(android: androidDetails);
//     await _notificationsPlugin.show(id, title, body, notificationDetails);
//   }
//
//   static Future<void> showNetworkImageNotification({
//     required String imageUrl,
//     required String title,
//     required String body,
//     required String summary,
//     int id = 1,
//   }) async {
//     final response = await http.get(Uri.parse(imageUrl));
//     final bytes = response.bodyBytes;
//     final tempDir = await getTemporaryDirectory();
//     final filePath = '${tempDir.path}/net_img.jpg';
//     await File(filePath).writeAsBytes(bytes);
//
//     final bigPicture = BigPictureStyleInformation(
//       FilePathAndroidBitmap(filePath),
//       contentTitle: title,
//       summaryText: summary,
//     );
//
//     final androidDetails = AndroidNotificationDetails(
//       'network_image_channel',
//       'Network Image Notifications',
//       channelDescription: 'Channel for image from network',
//       styleInformation: bigPicture,
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     await _notificationsPlugin.show(
//       id,
//       title,
//       body,
//       NotificationDetails(android: androidDetails),
//     );
//   }
//
//   static Future<void> showLocalImageNotification({
//     required String drawableName,
//     required String title,
//     required String body,
//     required String summary,
//     int id = 2,
//   }) async {
//     final bigPicture = BigPictureStyleInformation(
//       DrawableResourceAndroidBitmap(drawableName),
//       contentTitle: title,
//       summaryText: summary,
//     );
//
//     final androidDetails = AndroidNotificationDetails(
//       'local_image_channel',
//       'Local Image Notifications',
//       channelDescription: 'Channel for image from app resources',
//       styleInformation: bigPicture,
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     await _notificationsPlugin.show(
//       id,
//       title,
//       body,
//       NotificationDetails(android: androidDetails),
//     );
//   }
// }
