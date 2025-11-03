import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApprovedOrder extends StatelessWidget {
  final Map<String, String> order;

  // Constructor to receive order data
  ApprovedOrder({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order",
          style: AppFontStyle.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order ID : ${order['orderId']}",
                            style: AppFontStyle.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildRow("First Name", order['firstName'] ?? ""),
                      //_buildRow("Last Name", order['lastName'] ?? ""),
                      _buildRow("Email ID", order['email'] ?? ""),
                      _buildRow("Mobile Number", order['mobile'] ?? ""),
                      _buildRow("Status", order['status'] ?? ""),
                      _buildRow(
                        "Application Date",
                        order['applicationdate'] ?? "",
                        // DateFormat('dd-MM-yyyy').format(controller.orderDetails[0].applicationDate),
                      ),
                    ],
                  ),
                ),
                // Documents section
                const SizedBox(height: 5),
                Text(
                  "Documents :",
                  style: AppFontStyle.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                _buildDocumentRow("Old 7/12 Extract"),
                _buildDocumentRow("Old 8A Extract"),
                _buildDocumentRow("Property Card"),
              ],
            ),
          ),
          // Positioned note at the bottom
          Positioned(
            left: 20,
            right: 20,
            bottom: 100,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFEEEDE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Note : This document will be available for download only once.",
                style: AppFontStyle.poppins(
                  fontSize: 10,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppFontStyle.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF36322E),
              ),
            ),
          ),
          const Text(":", style: TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: AppFontStyle.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF36322E),
              ),
              softWrap: true,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentRow(String documentName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            "$documentName",
            style: AppFontStyle.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF36322E),
            ),
          ),
        ],
      ),
    );
  }
}
