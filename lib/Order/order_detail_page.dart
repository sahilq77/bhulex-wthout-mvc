import 'package:bhulexapp/Order/download_document_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, String> order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details - ID: ${order['orderId']}',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
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
                    Text(
                      'Order Details',
                      style: GoogleFonts.blinker(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: const Color(0xFF36322E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow('Order ID', order['orderId']!),
                    const SizedBox(height: 12),
                    _buildDetailRow('First Name', order['firstName']!),
                    const SizedBox(height: 12),
                    _buildDetailRow('Last Name', order['lastName']!),
                    const SizedBox(height: 12),
                    _buildDetailRow('Email ID', order['email']!),
                    const SizedBox(height: 12),
                    _buildDetailRow('Mobile Number', order['mobile']!),
                    const SizedBox(height: 12),
                    _buildDetailRow('Status', order['status']!),
                    const SizedBox(height: 12),
                    _buildDetailRow('Note', order['note']!),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DownloadDocumentPage(order: order),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$label:',
            style: GoogleFonts.blinker(
              fontSize: 16,
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
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF36322E),
            ),
          ),
        ),
      ],
    );
  }
}
