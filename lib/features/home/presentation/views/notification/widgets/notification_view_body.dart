import 'package:flutter/material.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationsPage();
  }
}

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationItem> notifications = [
    NotificationItem(
      id: 1,
      userName: 'John Doe',
      timestamp: '04:31 01 july',
      message: 'I\'m at Golden Gate Park',
      coordinates: '122.4194- ,37.7749',
      isRead: false,
    ),
    NotificationItem(
      id: 2,
      userName: 'John Doe',
      timestamp: '04:31 01 july',
      message: 'I\'m at Golden Gate Park',
      coordinates: '122.4194- ,37.7749',
      isRead: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return _buildNotificationCard(notifications[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Color(0xFFff4757),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
         color:
            notification.isRead
                ? Color(0xFF2ed573).withOpacity(0.15)
                : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              notification.isRead
                  ? Color(0xFF2ed573).withOpacity(0.3)
                  : Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF4a69bd),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.location_on),
                ),

                SizedBox(width: 12),

                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.userName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        notification.timestamp,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                        notification.isRead
                            ? Color(0xFF2ed573)
                            : Color(0xFF4a90e2),
                        shape: BoxShape.circle,
                      ),

                    ),
                    SizedBox(height: 30,)
                  ],
                ),

              ],
            ),

            SizedBox(height: 12),

            // Notification content
            Text(
              notification.message,
              style: TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
            ),

            SizedBox(height: 8),

             Row(
              children: [
                Icon(Icons.location_on,size: 16,),
                SizedBox(width: 4),
                Text(
                  notification.coordinates,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

             Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    text: 'Delete',
                    icon: Icons.delete_outline,
                    color: Color(0xFFff4757),
                    onPressed: () => _deleteNotification(index),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    text: notification.isRead ? 'Read' : 'Mark Read',
                    icon: Icons.check,
                     color:
                        notification.isRead
                            ? Color(0xFF2ed573)
                            : Color(0xFF4a90e2),
                    onPressed: () => _markAsRead(index),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

   void _markAsRead(int index) {
    setState(() {
      notifications[index].isRead = true;
    });
  }

   Widget _buildActionButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification deleted'),
        backgroundColor: Color(0xFF2ed573),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

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
