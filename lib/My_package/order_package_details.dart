import 'dart:developer';
import 'dart:io';

import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/language/hindi.dart';
import 'package:bhulexapp/no%20internet.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/order/order_details_controller.dart';
import '../controller/order/language controller.dart';
import '../Order/DocumentDetail.dart';

class OrderpackageDetail extends StatelessWidget {
  final Map<String, String> order;
  final String customerid;
  final String? lead_id;
  final String? tbl_name;
  final String package_Id;
  final OrderDetailsController controller = Get.put(OrderDetailsController());
  final LanguageController languageController = Get.find<LanguageController>();

  OrderpackageDetail({
    super.key,
    required this.order,
    required this.tbl_name,
    required this.customerid,
    required this.package_Id,
    this.lead_id,
  }) {
    _checkAndLoadData();
  }

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
      return;
    }

    // Validate and fetch order details
    String effectiveLeadId = lead_id ?? order['orderId'] ?? '';
    String effectiveCustomerId = order['customerId'] ?? customerid;
    String effectiveTblName = tbl_name ?? '';

    if (effectiveLeadId.isEmpty || effectiveCustomerId.isEmpty || effectiveTblName.isEmpty) {
      log('Error: Missing required parameters - leadId: $effectiveLeadId, customerId: $effectiveCustomerId, tblName: $effectiveTblName');
      return;
    }

    log('Fetching order details with leadId: $effectiveLeadId, customerId: $effectiveCustomerId, tblName: $effectiveTblName');
    await controller.fetchOrderDetails(
      effectiveCustomerId,
      effectiveLeadId,
      effectiveTblName,
    );
  }

  // Check connectivity
  Future<bool> _checkConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      bool isConnected = !connectivityResult.contains(ConnectivityResult.none);
      if (isConnected) {
        try {
          final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 5));
          isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
        } catch (e) {
          isConnected = false;
          log('Connectivity check failed: $e');
        }
      }
      return isConnected;
    } catch (e) {
      log('Error checking connectivity: $e');
      return false;
    }
  }

  Map<String, dynamic> getStatusDetails(String leadStatus, bool isToggled) {
    final Map<String, Map<String, Map<String, String>>> statusTranslations = {
      "0": {
        "en": {"text": "Pending"},
        "local": {"text": "प्रलंबित"},
      },
      "1": {
        "en": {"text": "Order Confirmed"},
        "local": {"text": "ऑर्डर पुष्ट"},
      },
      "2": {
        "en": {"text": "Approved"},
        "local": {"text": "मान्य"},
      },
      "3": {
        "en": {"text": "Rejected"},
        "local": {"text": "नाकारले"},
      },
    };

    final language = isToggled ? 'local' : 'en';
    final status = statusTranslations[leadStatus] ?? {
      "en": {"text": "Unknown"},
      "local": {"text": "अज्ञात"},
    };

    switch (leadStatus) {
      case "0":
        return {
          "text": status[language]!["text"],
          "color": Colors.orange.shade100,
          "textColor": const Color(0xFFEA580C),
        };
      case "1":
        return {
          "text": status[language]!["text"],
          "color": Colors.green.shade100,
          "textColor": const Color(0xFF149845),
        };
      case "2":
        return {
          "text": status[language]!["text"],
          "color": Colors.green.shade100,
          "textColor": const Color(0xFF149845),
        };
      case "3":
        return {
          "text": status[language]!["text"],
          "color": Colors.red.shade100,
          "textColor": const Color(0xFFD32F2F),
        };
      default:
        return {
          "text": status[language]!["text"],
          "color": Colors.grey.shade100,
          "textColor": Colors.grey,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            languageController.isToggled.value ? "ऑर्डर स्थिती" : "Order Status",
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
        ),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: RefreshIndicator(
        onRefresh: () async {
          String effectiveLeadId = lead_id ?? order['orderId'] ?? '';
          String effectiveCustomerId = order['customerId'] ?? customerid;
          String effectiveTblName = tbl_name ?? '';

          if (effectiveLeadId.isEmpty || effectiveCustomerId.isEmpty || effectiveTblName.isEmpty) {
            log('Error: Missing required parameters for refresh - leadId: $effectiveLeadId, customerId: $effectiveCustomerId, tblName: $effectiveTblName');
            return;
          }

          await controller.fetchOrderDetails(
            effectiveCustomerId,
            effectiveLeadId,
            effectiveTblName,
          );
        },
        child: Obx(
          () => controller.isLoading.value
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
                                  "${languageController.isToggled.value ? 'ऑर्डर आयडी' : 'Order ID'} : ${lead_id ?? order['orderId'] ?? 'N/A'}",
                                  style: AppFontStyle2.blinker(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                                if (controller.orderDetails.isNotEmpty)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getStatusDetails(
                                        controller.orderDetails[0].leadStatus,
                                        languageController.isToggled.value,
                                      )['color'],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      getStatusDetails(
                                        controller.orderDetails[0].leadStatus,
                                        languageController.isToggled.value,
                                      )['text'],
                                      style: AppFontStyle2.blinker(
                                        color: getStatusDetails(
                                          controller.orderDetails[0].leadStatus,
                                          languageController.isToggled.value,
                                        )['textColor'],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (controller.orderDetails.isNotEmpty) ...[
                              _buildRow(
                                languageController.isToggled.value
                                    ? (controller.orderDetails[0].package_name?.isNotEmpty ?? false
                                        ? "पॅकेज नाव"
                                        : "सेवा नाव")
                                    : (controller.orderDetails[0].package_name?.isNotEmpty ?? false
                                        ? "Package Name"
                                        : "Service Name"),
                                controller.orderDetails[0].package_name?.isNotEmpty ?? false
                                    ? (languageController.isToggled.value
                                        ? (controller.orderDetails[0].package_name_in_local_language?.isNotEmpty ?? false
                                            ? controller.orderDetails[0].package_name_in_local_language ?? ""
                                            : controller.orderDetails[0].package_name ?? "")
                                        : controller.orderDetails[0].package_name ?? "")
                                    : (languageController.isToggled.value
                                        ? (controller.orderDetails[0].serviceNameLocal != null
                                            ? controller.orderDetails[0].serviceNameLocal!
                                            : localizationOrderdetailsStrings.getServiceName(
                                                controller.orderDetails[0].serviceName ?? "",
                                                true,
                                              ))
                                        : (controller.orderDetails[0].serviceName ?? "")),
                              ),
                              _buildRow(
                                languageController.isToggled.value ? "ग्राहकाचे नाव" : "Customer Name",
                                controller.orderDetails[0].customerName,
                              ),
                              _buildRow(
                                languageController.isToggled.value ? "मोबाइल नंबर" : "Mobile Number",
                                controller.orderDetails[0].mobileNumber,
                              ),
                              _buildRow(
                                languageController.isToggled.value ? "ईमेल" : "Email",
                                controller.orderDetails[0].email,
                              ),
                              _buildRow(
                                languageController.isToggled.value ? "अर्जाची तारीख" : "Application Date",
                                controller.orderDetails[0].applicationDate.toString(),
                              ),
                            ],
                            const SizedBox(height: 16),
                            Text(
                              languageController.isToggled.value ? "उपलब्ध दस्तऐवज" : "Available Documents",
                              style: AppFontStyle2.blinker(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (controller.orderDetails.isEmpty)
                              Text(
                                languageController.isToggled.value
                                    ? "कोणतेही दस्तऐवज उपलब्ध नाहीत"
                                    : "No Documents Available",
                                style: AppFontStyle2.blinker(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              )
                            else
                              ...controller.orderDetails.map(
                                (doc) => GestureDetector(
                                  onTap: () {
                                    if (doc.isView != "1") {
                                      String cleanedUrl = "${controller.filePath.value}${doc.file}".replaceAll(RegExp(r'\\+'), '/');
                                      log("Navigating to DocumentDetail with URL: $cleanedUrl, leadId: ${lead_id ?? order['orderId'] ?? 'N/A'}");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DocumentDetail(
                                            customerId: order['customerId'] ?? customerid,
                                            leadId: lead_id ?? order['orderId'] ?? '',
                                            tblName: tbl_name ?? order['tbl_name'] ?? '',
                                            documentId: doc.documentId,
                                            documentName: cleanedUrl,
                                            file: doc.file,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey.shade300),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                doc.file,
                                                style: AppFontStyle2.blinker(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              doc.tags,
                                              style: AppFontStyle2.blinker(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.chevron_right,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        if (doc.isView == "1")
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    languageController.isToggled.value
                                                        ? "आधीच डाउनलोड केले"
                                                        : "Already Downloaded",
                                                    style: AppFontStyle2.blinker(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    languageController.isToggled.value
                                                        ? "डाउनलोड तारीख: ${doc.download_date}"
                                                        : "Download Date: ${doc.download_date}",
                                                    style: AppFontStyle2.blinker(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
    Color finalValueColor = (label == (languageController.isToggled.value ? "स्थिती" : "Status"))
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
                fontSize: 16,
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
                fontSize: 16,
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