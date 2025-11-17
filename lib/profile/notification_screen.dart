import 'package:bhulexapp/colors/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../colors/order_fonts.dart';

// Define a global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItemData> _allNotifications = [];
  List<NotificationItemData> _displayedNotifications = [];
  bool _isLoading = true;
  bool _hasMore = true; // Indicates if there are more items to load
  final int _initialLoadCount = 9; // Number of items to load initially
  int _currentLoadCount = 9; // Number of items currently loaded

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // Load dummy notifications
    _loadDummyNotifications();
  }

  void _loadDummyNotifications() {
    _allNotifications = List.generate(
      20,
      (index) => NotificationItemData(
        message: "New Message ",
        text: "You have received one new message",
        timeAgo: "${index + 1} min ago",
        icon: Icons.notifications, // Using a default icon
        appRedirectionUrl: "https://example.com",
        recordId: "ID_${index + 1}",
      ),
    );

    _displayedNotifications = _allNotifications
        .take(_initialLoadCount)
        .toList();
    _isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshNotifications() async {
    setState(() {
      _isLoading = true;
      _currentLoadCount = _initialLoadCount; // Reset to initial load count
      _displayedNotifications = [];
    });
    await Future.delayed(Duration(seconds: 1)); // Simulate refresh delay
    _loadDummyNotifications();
  }

  void _loadMore() {
    setState(() {
      final remainingNotifications = _allNotifications
          .skip(_currentLoadCount)
          .toList();
      final newLoadCount = _currentLoadCount + _initialLoadCount;
      _displayedNotifications.addAll(
        remainingNotifications.take(_initialLoadCount),
      );
      _currentLoadCount = newLoadCount;
      _hasMore = remainingNotifications.length > _initialLoadCount;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_hasMore && !_isLoading) {
        _loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          "Notification",
          style: AppFontStyle2.blinker(
            fontWeight: FontWeight.w600,
            fontSize: width * 0.045,
            color: Color(0xFF36322E),
          ),
        ),

        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Divider(color: Colorfile.border, height: 0),
        ),
      ),
      body: _isLoading
          ? _buildShimmer()
          : _displayedNotifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center content vertically
                children: [
                  Image.asset(
                    "assets/images/Frame.png", // Replace with your image path
                    width: 90, // Adjust size as needed
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20), // Space between lines
                  Text(
                    "No Notifications",
                    textAlign: TextAlign.center,
                    style: AppFontStyle2.blinker(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF353B43),
                    ),
                  ),
                  SizedBox(height: 5), // Space between lines
                  Text(
                    "We’ll let you know when there will be\n something to update you.",
                    textAlign: TextAlign.center,
                    style: AppFontStyle2.blinker(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF797979),
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _refreshNotifications,
              child: Scrollbar(
                thickness: 10.0,
                radius: Radius.circular(8.0),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: 30.0, right: 15, left: 15),
                  itemCount: _displayedNotifications.length,
                  itemBuilder: (context, index) {
                    final notification = _displayedNotifications[index];
                    return NotificationItem(
                      message: notification.message,
                      text: notification.text,
                      timeAgo: notification.timeAgo,
                      icon: notification.icon,
                      appRedirectionUrl: notification.appRedirectionUrl,
                      recordId: notification.recordId,
                    );
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.grey[300]),
            title: Container(color: Colors.grey[300], height: 16.0),
            subtitle: Container(color: Colors.grey[300], height: 14.0),
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
          ),
        );
      },
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String message;
  final String text;

  final String timeAgo;
  final IconData icon;
  final String appRedirectionUrl;
  final String recordId;

  const NotificationItem({
    Key? key,
    required this.message,
    required this.text,
    required this.timeAgo,
    required this.icon,
    required this.appRedirectionUrl,
    required this.recordId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {},
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Row: Icon, Message, and Time Ago
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFEEEDE), // Background color added
                            border: Border.all(
                              color: Color(0xFFDFE6F8),
                              width: 0.5,
                            ),
                          ),
                          child: Image.asset(
                            'assets/Group.png', // Replace with your actual image path
                            width: 35,
                            height: 35,
                          ),
                        ),
                        SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // First Row: Icon, Message, and Time Ago
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      message,
                                      style: AppFontStyle2.blinker(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF353B43),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    timeAgo, // Time ago on the left side
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFA0A0A0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Padding(
                                padding: const EdgeInsets.only(right: 9.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: text,
                                    style: AppFontStyle2.blinker(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF7C7C7C),
                                      height: 20 / 11,
                                    ),
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Second Line: Additional Text
                    const SizedBox(height: 8),
                    // Divider
                    Container(
                      child: Divider(
                        color: Color(0xFFD9D9D9),
                        thickness: 1, // Adjust thickness if needed
                      ),
                    ),
                  ],
                ),
              ),
              // Divider
              Container(
                child: Divider(
                  color: Color(0xFFD9D9D9),
                  thickness: 1, // Adjust thickness if needed
                ),
              ),
              // Optional Arrow Icon for Navigation (Uncomment if needed)
              // Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItemData {
  final String message;
  final String text;
  final String timeAgo;
  final IconData icon;
  final String appRedirectionUrl;
  final String recordId;

  NotificationItemData({
    required this.message,
    required this.text,
    required this.timeAgo,
    required this.icon,
    required this.appRedirectionUrl,
    required this.recordId,
  });
}
