import 'dart:io';

import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:bhulexapp/no%20internet.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controller/order/order_details_controller.dart';

class DocumentDetail extends StatelessWidget {
  final String customerId;
  final String leadId;
  final String tblName;
  final String documentId;
  final String documentName;
  final String file;
  final OrderDetailsController controller = Get.find<OrderDetailsController>();
  final LanguageController languageController = Get.find<LanguageController>();

  DocumentDetail({
    required this.customerId,
    required this.leadId,
    required this.tblName,
    required this.documentId,
    required this.documentName,
    required this.file,
  }) {
    _checkAndLoadData();
  }

  // Method to check connectivity and load data or navigate to NoInternetPage
  Future<void> _checkAndLoadData() async {
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      Get.to(
        () => NoInternetPage(
          onRetry: () {
            _checkAndLoadData(); // Retry loading data
          },
        ),
      );
    }
  }

  // Check connectivity
  Future<bool> _checkConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      bool isConnected = !connectivityResult.contains(ConnectivityResult.none);
      if (isConnected) {
        try {
          final result = await InternetAddress.lookup(
            'google.com',
          ).timeout(Duration(seconds: 5));
          isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
        } catch (e) {
          isConnected = false;
        }
      }
      return isConnected;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            languageController.isToggled.value
                ? "ऑर्डर स्थिती"
                : "Order Status",
            style: AppFontStyle2.blinker(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder:
          //         (context) => OrderDetail(
          //           order: {
          //             'customerId': '1', // Replace with actual customer ID
          //             'orderId': '12345', // Replace with actual order ID
          //             'tbl_name':
          //                 'orders', // Replace with actual table name
          //             'status': 'Pending', // Replace with actual status
          //           },
          //         ),
          //   ),
          // ),
        ),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: Obx(
        () =>
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Padding(
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
                                  "Order ID : $leadId",
                                  style: AppFontStyle2.blinker(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Order Confirmed",
                                    style: AppFontStyle2.blinker(
                                      color: const Color(0xFF149845),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (controller.orderDetails.isNotEmpty) ...[
                              _buildRow(
                                "First Name",
                                controller.orderDetails[0].customerName
                                    .split(" ")
                                    .first,
                              ),
                              // _buildRow(
                              //   "Last Name",
                              //   controller.orderDetails[0].customerName
                              //               .split(" ")
                              //               .length >
                              //           1
                              //       ? controller.orderDetails[0].customerName
                              //           .split(" ")
                              //           .sublist(1)
                              //           .join(" ")
                              //       : "",
                              // ),
                              _buildRow(
                                "Email ID",
                                controller.orderDetails[0].email,
                              ),
                              _buildRow(
                                "Mobile Number",
                                controller.orderDetails[0].mobileNumber,
                              ),
                              _buildRow(
                                "Application Date",
                                DateFormat('dd-MM-yyyy').format(
                                  controller.orderDetails[0].applicationDate,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    String downloadKey =
                                        '$customerId-$documentId';

                                    // Check if already downloaded
                                    if (controller
                                            .downloadStatus[downloadKey] ==
                                        true) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'This document can only be downloaded once',
                                            style: AppFontStyle.poppins(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                      return;
                                    }

                                    // Show confirmation dialog
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          title: Text(
                                            'Download Confirmation',
                                            style: AppFontStyle2.blinker(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF36322E),
                                            ),
                                          ),
                                          content: Text(
                                            'Are you sure you want to download this document? You can only download it once.',
                                            style: AppFontStyle.poppins(
                                              fontSize: 14,
                                              color: const Color(0xFF36322E),
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(
                                                  dialogContext,
                                                ).pop();
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: AppFontStyle2.blinker(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.of(
                                                  dialogContext,
                                                ).pop();

                                                bool success = await controller
                                                    .downloadFile(
                                                      customerId,
                                                      documentId,
                                                      tblName,
                                                    );
                                                if (success) {
                                                  await controller
                                                      .downloadDocument(file);
                                                  controller
                                                          .downloadStatus[downloadKey] =
                                                      true; // Mark as downloaded

                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Document downloaded successfully',
                                                        style:
                                                            AppFontStyle.poppins(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                      backgroundColor:
                                                          const Color(
                                                            0xFF4CAF50,
                                                          ),
                                                      duration: const Duration(
                                                        seconds: 3,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Text(
                                                'Download',
                                                style: AppFontStyle2.blinker(
                                                  color: const Color(
                                                    0xFFF57C03,
                                                  ),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Your document is ready to download',
                                    style: AppFontStyle2.blinker(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF57C03),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    Color finalValueColor =
        (label == "Status")
            ? const Color(0xFF16A34A)
            : (valueColor ?? const Color(0xFF36322E));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppFontStyle2.blinker(
                fontSize: 15,
                fontWeight: isBold ? FontWeight.w500 : FontWeight.w400,
                color: const Color(0xFF36322E),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const Text(":", style: TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: AppFontStyle2.blinker(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: finalValueColor,
              ),
              softWrap: true,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
