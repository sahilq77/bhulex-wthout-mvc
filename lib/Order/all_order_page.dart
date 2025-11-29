import 'package:bhulexapp/Order/download_document_page.dart'
    show DownloadDocumentPage;
import 'package:bhulexapp/Order/order_detail_page.dart';
import 'package:bhulexapp/bottom_navigation/main_bottom_navigation.screen.dart';
import 'package:bhulexapp/controller/bottom_navigation/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Note: Add this to your pubspec.yaml:
// dependencies:
//   google_fonts: ^6.2.1

class OrderCardsPage extends StatefulWidget {
  const OrderCardsPage({super.key});

  @override
  _OrderCardsPageState createState() => _OrderCardsPageState();
}

class _OrderCardsPageState extends State<OrderCardsPage> {
  static const List<Map<String, String>> dummyOrders = [
    {
      'orderId': '1001',
      'firstName': 'Aarav',
      'lastName': 'Sharma',
      'email': 'aarav.sharma@gmail.com',
      'mobile': '9123456789',
      'status': 'Pending',
      'note': 'Deliver before weekend',
    },
    {
      'orderId': '1002',
      'firstName': 'Priya',
      'lastName': 'Verma',
      'email': 'priya.verma@gmail.com',
      'mobile': '9876543210',
      'status': 'Approved',
      'note': 'Call before delivery',
    },
    {
      'orderId': '1003',
      'firstName': 'Rohan',
      'lastName': 'Patel',
      'email': 'rohan.patel@gmail.com',
      'mobile': '9555123456',
      'status': 'Rejected',
      'note': 'Incorrect address',
    },
    {
      'orderId': '1004',
      'firstName': 'Ananya',
      'lastName': 'Reddy',
      'email': 'ananya.reddy@gmail.com',
      'mobile': '9445566778',
      'status': 'Order Confirmed',
      'note': 'Express delivery',
    },
  ];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate initial loading
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshOrders() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomController = Get.put(BottomNavigationController());
    return WillPopScope(
      onWillPop: () async {
        print(
          'Main: WillPopScope triggered, current route: ${Get.currentRoute}, selectedIndex: ${bottomController.selectedIndex.value}',
        );

        print('Main: Navigating to home');
        bottomController.selectedIndex.value = 0;
        bottomController.goToHome();
        return false; // Prevent app exit
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Orders',
            style: GoogleFonts.blinker(color: Colors.black87, fontSize: 20),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(color: Colors.grey.shade300, height: 1),
          ),
        ),
        backgroundColor: const Color(0xFFFDFDFD),
        body: RefreshIndicator(
          onRefresh: _refreshOrders,
          child: _isLoading
              ? ListView.builder(
                  itemCount: 4, // Show 4 skeleton cards
                  itemBuilder: (context, index) => const SkeletonCard(),
                )
              : ListView.builder(
                  itemCount: dummyOrders.length,
                  itemBuilder: (context, index) {
                    final order = dummyOrders[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Color(0xFFE5E7EB),
                          width: 1,
                        ),
                      ),
                      color: const Color(0xFFFFFFFF),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order ID: ${order['orderId']}',
                                  style: GoogleFonts.blinker(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: const Color(0xFF36322E),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _statusColor(
                                      order['status'],
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    order['status']!,
                                    style: GoogleFonts.blinker(
                                      color: _statusColor(order['status']),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            IntrinsicWidth(
                              stepWidth: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailRow(
                                    'First Name',
                                    order['firstName']!,
                                  ),
                                  const SizedBox(height: 8),
                                  _buildDetailRow(
                                    'Last Name',
                                    order['lastName']!,
                                  ),
                                  const SizedBox(height: 8),
                                  _buildDetailRow('Email ID', order['email']!),
                                  const SizedBox(height: 8),
                                  _buildDetailRow(
                                    'Mobile Number',
                                    order['mobile']!,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (order['status'] == 'Approved')
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailsPage(order: order),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFDFDFD),
                                    side: const BorderSide(
                                      color: Color(0xFF36322E),
                                      width: 1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                  ),
                                  child: Text(
                                    'View Details',
                                    style: GoogleFonts.blinker(
                                      color: const Color(0xFF36322E),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            else if (order['status'] == 'Order Confirmed')
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DownloadDocumentPage(order: order),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF26500),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                  ),
                                  child: Text(
                                    'Your document is ready to download',
                                    style: GoogleFonts.blinker(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            else
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEFFE0),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFEBEDAF),
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  'Note: Your order is being processed. Thank you for your patience! We\'ll notify once it is confirmed.',
                                  style: GoogleFonts.blinker(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '$label:',
            style: GoogleFonts.blinker(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF36322E),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: GoogleFonts.blinker(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF36322E),
            ),
          ),
        ),
      ],
    );
  }

  Color _statusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'order confirmed':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      color: const Color(0xFFFFFFFF),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 100, height: 16, color: Colors.grey.shade200),
                Container(width: 80, height: 16, color: Colors.grey.shade200),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 14,
                        color: Colors.grey.shade200,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 150,
                        height: 14,
                        color: Colors.grey.shade200,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 40,
              color: Colors.grey.shade200,
            ),
          ],
        ),
      ),
    );
  }
}
