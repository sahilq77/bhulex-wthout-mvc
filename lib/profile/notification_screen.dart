import 'package:flutter/material.dart';
import 'package:bhulexapp/colors/custom_color.dart'; // Keep your custom colors
import 'package:bhulexapp/colors/order_fonts.dart'; // Your font styles
import 'package:intl/intl.dart'; // For formatting time (optional)

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Sample data – replace with your API later
  final List<NotificationItem> notifications = List.generate(
    15,
    (index) => NotificationItem(
      title: "New Message",
      message: "You have received one new message",
      time: DateTime.now().subtract(const Duration(minutes: 3)),
      isRead: index.isEven, // alternate read/unread for demo
    ),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colorfile.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF36322E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Notification",
          style: AppFontStyle2.blinker(
            fontWeight: FontWeight.w600,
            fontSize: width * 0.050,
            color: const Color(0xFF36322E),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colorfile.border, height: 1),
        ),
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No notifications yet",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: 12,
              ),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final noti = notifications[index];
                return NotificationTile(notification: noti);
              },
            ),
    );
  }
}

// Model
class NotificationItem {
  final String title;
  final String message;
  final DateTime time;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}

// Single Tile Widget
class NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isRead
            ? Colors.white
            : const Color(0xFFFFF8E1), // Light yellow for unread
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notification.isRead
              ? Colors.grey.shade200
              : const Color(0xFFFFC107),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bell Icon with dot for unread
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications,
                  color: const Color(0xFFEF6C00),
                  size: width * 0.07,
                ),
              ),
              if (!notification.isRead)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: AppFontStyle2.blinker(
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.045,
                    color: const Color(0xFF36322E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: width * 0.038,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatTime(notification.time),
                  style: TextStyle(
                    fontSize: width * 0.033,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
    } else {
      return DateFormat('dd MMM yyyy').format(dateTime);
    }
  }
}
