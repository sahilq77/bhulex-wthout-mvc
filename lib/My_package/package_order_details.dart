import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bhulexapp/My_package/order_package_details.dart';
import 'package:bhulexapp/My_package/package_details_new.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:bhulexapp/controller/order/my_order_controller.dart';
import 'package:bhulexapp/investigate_reports_form/mortage_report.dart';
import 'package:bhulexapp/investigate_reports_form/registered_document.dart';
import 'package:bhulexapp/investigate_reports_form/rera%20builder.dart';
import 'package:bhulexapp/language/hindi.dart';
import 'package:bhulexapp/legal_advisory_forms/adhikar_abhilekh.dart';
import 'package:bhulexapp/legal_advisory_forms/courtcases.dart';
import 'package:bhulexapp/legal_advisory_forms/investigate.dart';
import 'package:bhulexapp/legal_advisory_forms/legaldrafts.dart';
import 'package:bhulexapp/network/url.dart';
import 'package:bhulexapp/no%20internet.dart';
import 'package:bhulexapp/old_records_form/old%20extract1.dart';
import 'package:bhulexapp/quicke_services_forms/digitally_sign1.dart';
import 'package:bhulexapp/quicke_services_forms/digitally_sign_property_card.dart';
import 'package:bhulexapp/quicke_services_forms/indexII_search.dart';
import 'package:bhulexapp/quicke_services_forms/rera_certificate.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class PackageService extends StatefulWidget {
  final String package_Id;
  final String customerid;
  final String lead_id;
  final String? tbl_name;
  final String? package_lead_id;
  final String? serviceLeadId;

  const PackageService({
    Key? key,
    required this.package_Id,
    required this.lead_id,
    required this.customerid,
    this.package_lead_id,
    this.serviceLeadId,
    this.tbl_name,
  }) : super(key: key);

  @override
  _PackageServiceState createState() => _PackageServiceState();
}

class _PackageServiceState extends State<PackageService> {
  Map<String, dynamic>? packageData;
  List<dynamic> services = [];
  bool isLoading = true;
  String? errorMessage;
  final OrderController orderController = Get.find<OrderController>();

  @override
  void initState() {
    super.initState();
    fetchservicestatus();
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

  Future<void> fetchservicestatus() async {
    setState(() => isLoading = true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? customerId = prefs.getString('customer_id');

      var requestBody = {
        "customer_id": customerId,
        "package_id": widget.package_Id,
        "lead_id": widget.lead_id,
      };

      final String url = URLS().check_form_filled_statusapiurl;

      log("URL: $url");
      log("Customer ID: $customerId");
      log("Package ID: ${widget.package_Id}");
      log("Request Body: ${jsonEncode(requestBody)}");

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(requestBody),
      );

      log("Response Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == "true" &&
            responseData['data'].isNotEmpty) {
          packageData = responseData['data'][0];
          services = packageData!['services'] ?? [];
          log("Services assigned: $services");
        } else {
          services = [];
          log("No services found in response");
        }
      } else {
        errorMessage = "Server error: ${response.statusCode}";
        services = [];
      }
    } catch (e) {
      errorMessage = "Error fetching services: $e";
      services = [];
      log(errorMessage!);
    } finally {
      setState(() => isLoading = false);
    }
  }

  String _getTblName(String service) {
    log('Mapping service to tbl_name: $service');
    final normalizedService = service.trim().toLowerCase();
    switch (normalizedService) {
      case 'digitally signed 7/12 extract':
        return 'tbl_seven_twelve';
      case '8a extract':
      case 'digitally signed 8a extract':
        return 'tbl_eighta_extract';
      case 'e-mutation extract':
      case 'digitally signed e-mutation extract':
        return 'tbl_e_mutation_extract';
      case 'bhu naksha':
      case 'bhu naksha map':
        return 'tbl_bhu_naksha';
      case 'index second search':
      case 'index ii search':
        return 'tbl_index_second_search';
      case 'rera certificate':
        return 'tbl_rera_certificate';
      case 'digitally signed property card':
        return 'tbl_property_card';
      case 'old 7/12 extract':
        return 'tbl_old_seven_twelve';
      case 'old 8a extract':
        return 'tbl_old_eighta_extract';
      case 'old e-mutation extract':
        return 'tbl_old_e_mutation_extract';
      case 'old bhu naksha rural/urban':
        return 'tbl_old_bhu_naksha';
      case 'mortgage reports':
        return 'tbl_mortage_report';
      case 'ceersai report':
      case 'cersai reports':
        return 'tbl_ceersai_report';
      case 'rera builder documents':
        return 'tbl_rera_builder_documents';
      case 'registered document download':
        return 'tbl_registered_document';
      case 'title investigation report':
        return 'tbl_title_investigation_report';
      case 'legal drafts':
        return 'tbl_legal_drafts';
      case 'court cases/orders search':
        return 'tbl_court_cases';
      case 'adhikar abhilekh':
        return 'tbl_adhikar_abhilekh';
      default:
        log('No specific mapping found for: $service');
        return widget.tbl_name ??
            'tbl_${normalizedService.replaceAll(RegExp(r'[\s\/]+'), '_')}';
    }
  }

  void _navigateToServiceForm(
    BuildContext context,
    Map<String, dynamic> service,
  ) {
    final String id = "";
    final String packageId = widget.package_Id;
    final String? package_lead_id = widget.package_lead_id;

    final String serviceName = service['service_name'] ?? 'Unknown Service';
    final String tblName = _getTblName(serviceName);
    final String serviceNameInLocal =
        service['service_name_in_local_language'] ?? serviceName;
    final LanguageController languageController =
        Get.find<LanguageController>();
    final bool isToggled = languageController.isToggled.value;
    final String serviceLeadId = service['lead_id'] ?? widget.lead_id;
    log('Navigating with:');
    log('Service Name: $serviceName');
    log('Table Name: $tblName');
    log('Service Lead ID: $serviceLeadId');

    final int formStatus = service['form_status'] ?? 0;
    final String leadStatus = packageData?['lead_status']?.toString() ?? "0";

    if (formStatus == 1 && leadStatus == "2") {
      log(
        'Form navigation blocked: form_status=$formStatus, lead_status=$leadStatus',
      );
      return;
    }

    if (formStatus == 1) {
      log('Navigating to OrderpackageDetail with tbl_name: $tblName');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderpackageDetail(
            lead_id: serviceLeadId,
            tbl_name: tblName,
            order: {
              "serviceName": serviceNameInLocal.isEmpty && isToggled
                  ? serviceNameInLocal
                  : localizationOrderStrings.getServiceName(
                      serviceName,
                      isToggled,
                    ),
              "status": getStatusDetails(leadStatus, isToggled)["text"],
              "customerId": orderController.customerId.value,
              "tbl_name": tblName,
            },
            customerid: widget.customerid,
            package_Id: widget.package_Id,
          ),
        ),
      );
      return;
    } else if (leadStatus == "2") {
      log('Navigation blocked: lead_status=$leadStatus');
      return;
    }

    Widget targetScreen;
    switch (tblName) {
      case "tbl_seven_twelve":
      case "tbl_eighta_extract":
      case "tbl_e_mutation_extract":
      case "tbl_bhu_naksha":
        targetScreen = DigitallySign1(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_index_second_search":
        targetScreen = IndexSearch1(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_rera_certificate":
        targetScreen = ReraCertificate(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_property_card":
        targetScreen = propertyCard(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_old_seven_twelve":
      case "tbl_old_eighta_extract":
      case "tbl_old_e_mutation_extract":
      case "tbl_old_bhu_naksha":
        targetScreen = oldextract1(
          id: id,
          package_lead_id: package_lead_id ?? widget.lead_id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
        );
        break;
      case "tbl_mortage_report":
        targetScreen = MortgageReports(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_ceersai_report":
        targetScreen = MortgageReports(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_rera_builder_documents":
        targetScreen = RERA_Builder(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_registered_document":
        targetScreen = RegisteredDocument(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_title_investigation_report":
        targetScreen = Investigation(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_legal_drafts":
        targetScreen = Legaldrafts(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_court_cases":
        targetScreen = Courtcases(
          id: id,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          packageId: packageId,
          lead_id: serviceLeadId,
          customer_id: widget.customerid,
          package_lead_id: package_lead_id ?? widget.lead_id,
        );
        break;
      case "tbl_adhikar_abhilekh":
        targetScreen = Adhikar_Abhilekh(
          id: id,
          package_lead_id: package_lead_id ?? widget.lead_id,
          packageId: packageId,
          serviceName: serviceName,
          tblName: tblName,
          isToggled: isToggled,
          serviceNameInLocalLanguage: serviceNameInLocal,
          lead_id: serviceLeadId,
          customerid: widget.customerid,
        );
        break;
      default:
        log('No matching form for tblName: $tblName');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              languageController.isToggled.value
                  ? "या निवडीसाठी सेवा उपलब्ध नाही: $tblName"
                  : "Service not available for this selection: $tblName",
            ),
          ),
        );
        return;
    }
    log('Navigating to form: $tblName');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    ).then((value) => fetchservicestatus());
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
    final status =
        statusTranslations[leadStatus] ??
        {
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
    final LanguageController languageController =
        Get.find<LanguageController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            languageController.isToggled.value
                ? "सेवा तपशील"
                : "Service Details",
            style: AppFontStyle2.blinker(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF36322E),
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PackageScreen(
                customerId: widget.customerid,
                package_id: widget.package_Id,
                tbl_name: widget.tbl_name,
                leadId: widget.lead_id,
                customerid: '',
                // customerid: '',
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${languageController.isToggled.value ? 'लीड आयडी' : 'Lead ID'} : ${widget.lead_id}",
                              style: AppFontStyle2.blinker(
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue.shade100,
                              ),
                              child: Text(
                                packageData != null
                                    ? languageController.isToggled.value
                                          ? packageData!['package_name_in_local_language']
                                                .trim()
                                          : packageData!['package_name']
                                    : 'Loading...',
                                style: AppFontStyle2.blinker(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        services.isEmpty
                            ? const Center(child: Text("No services available"))
                            : SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: services.map((service) {
                                    final String serviceLeadId =
                                        service['lead_id'] ?? widget.lead_id;
                                    final String serviceTblName = _getTblName(
                                      service['service_name'] ??
                                          'Unknown Service',
                                    );
                                    final statusDetails = getStatusDetails(
                                      packageData?['lead_status']?.toString() ??
                                          "0",
                                      languageController.isToggled.value,
                                    );

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4.0,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          log(
                                            'Service Lead ID: $serviceLeadId',
                                          );
                                          log(
                                            'Service Table Name: $serviceTblName',
                                          );
                                          if (service['form_status'] == 1 &&
                                              service['lead_status'] == "2") {
                                            log(
                                              "Navigating to OrderpackageDetail: form_status = ${service['form_status']} lead_status = ${packageData?['lead_status']}",
                                            );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => OrderpackageDetail(
                                                  lead_id: serviceLeadId,
                                                  tbl_name: serviceTblName,
                                                  order: {
                                                    "serviceName":
                                                        languageController
                                                            .isToggled
                                                            .value
                                                        ? service['service_name_in_local_language'] ??
                                                              'Unknown Service'
                                                        : service['service_name'] ??
                                                              'Unknown Service',
                                                    "status":
                                                        statusDetails["text"],
                                                    "customerId":
                                                        widget.customerid,
                                                    "tbl_name": serviceTblName,
                                                  },
                                                  customerid: widget.customerid,
                                                  package_Id: widget.package_Id,
                                                ),
                                              ),
                                            );
                                          } else {
                                            log(
                                              "Navigating to form: form_status = ${service['form_status']}",
                                            );
                                            _navigateToServiceForm(
                                              context,
                                              service,
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 6,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          languageController.isToggled.value
                                              ? (service['service_name_in_local_language'] ??
                                                    'Unknown Service')
                                              : (service['service_name'] ??
                                                    'Unknown Service'),
                                          style: AppFontStyle2.blinker(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
