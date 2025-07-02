class NotificationItem {
  final int id;
  final String userName;
  final String timestamp;
  final String message;
  final String coordinates;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.userName,
    required this.timestamp,
    required this.message,
    required this.coordinates,
    required this.isRead,
  });
}
