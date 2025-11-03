// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:my_bhulekh_app/Order/order_package_details.dart';
// import 'package:my_bhulekh_app/Order/package_details_new.dart';
// import 'package:my_bhulekh_app/controller/order/language%20controller.dart';
// import 'package:my_bhulekh_app/investigate_reports_form/mortage_report.dart';
// import 'package:my_bhulekh_app/investigate_reports_form/registered_document.dart';
// import 'package:my_bhulekh_app/investigate_reports_form/rera%20builder.dart';
// import 'package:my_bhulekh_app/language/hindi.dart';
// import 'package:my_bhulekh_app/legal_advisory_forms/adhikar_abhilekh.dart';
// import 'package:my_bhulekh_app/legal_advisory_forms/courtcases.dart';
// import 'package:my_bhulekh_app/legal_advisory_forms/investigate.dart';
// import 'package:my_bhulekh_app/legal_advisory_forms/legaldrafts.dart';
// import 'package:my_bhulekh_app/network/url.dart' show URLS;
// import 'package:my_bhulekh_app/old_records_form/old%20extract1.dart';
// import 'package:my_bhulekh_app/quicke_services_forms/digitally_sign1.dart';
// import 'package:my_bhulekh_app/quicke_services_forms/digitally_sign_property_card.dart';
// import 'package:my_bhulekh_app/quicke_services_forms/indexII_search.dart';
// import 'package:my_bhulekh_app/quicke_services_forms/rera_certificate.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DynamicPackageService extends StatefulWidget {
//   final String packageId;
//   final String customerId;
//   final String leadId;
//   final String? tblName;
//   final String? packageLeadId;

//   const DynamicPackageService({
//     Key? key,
//     required this.packageId,
//     required this.leadId,
//     required this.customerId,
//     this.packageLeadId,
//     this.tblName,
//   }) : super(key: key);

//   @override
//   _DynamicPackageServiceState createState() => _DynamicPackageServiceState();
// }

// class _DynamicPackageServiceState extends State<DynamicPackageService> {
//   Map<String, dynamic>? packageData;
//   List<Map<String, dynamic>> services = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     print('DynamicPackageService initialized with:');
//     print('package_lead_id: ${widget.packageLeadId}');
//     print('lead_id: ${widget.leadId}');
//     print('tbl_name: ${widget.tblName}');
//     print('customerid: ${widget.customerId}');
//     print('package_Id: ${widget.packageId}');
//     super.initState();
//     fetchservicestatus();
//   }

//   Future<void> fetchservicestatus() async {
//     setState(() => isLoading = true);
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? customerId = prefs.getString('customer_id');

//     var requestBody = {
//       "customer_id": customerId,
//       "package_id": widget.packageId,
//       "lead_id": widget.leadId,
//     };

//     final String url = URLS().check_form_filled_statusapiurl;

//     log("URL: $url");
//     log("Customer ID: $customerId");
//     log("Package ID: ${widget.packageId}");
//     log("Request Body: ${jsonEncode(requestBody)}");

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json; charset=UTF-8'},
//         body: jsonEncode(requestBody),
//       );

//       log("Response Status Code: ${response.statusCode}");
//       log("Response Body: ${response.body}");

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         setState(() {
//           if (responseData['status'] == "true" && responseData['data'].isNotEmpty) {
//             packageData = responseData['data'][0];
//             services = List<Map<String, dynamic>>.from(packageData!['services'] ?? []);
//           }
//         });
//       } else {
//         print("Error: Server responded with status code ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching services: $e");
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   String _getTblName(String service) {
//     print('Input service: "$service"');
//     final normalizedService = service.trim().toLowerCase();
//     switch (normalizedService) {
//       case 'digitally signed 7/12 extract':
//         return 'tbl_seven_twelve';
//       case '8a extract':
//       case 'digitally signed 8a extract':
//         return 'tbl_eighta_extract';
//       case 'e-mutation extract':
//       case 'digitally signed e-mutation extract':
//         return 'tbl_e_mutation_extract';
//       case 'bhu naksha':
//       case 'bhu naksha map':
//         return 'tbl_bhu_naksha';
//       case 'index second search':
//       case 'index ii search':
//         return 'tbl_index_second_search';
//       case 'rera certificate':
//         return 'tbl_rera_certificate';
//       case 'property card':
//         return 'tbl_property_card';
//       case 'old 7/12 extract':
//         return 'tbl_old_seven_twelve';
//       case 'old 8a extract':
//         return 'tbl_old_eighta_extract';
//       case 'old e-mutation extract':
//         return 'tbl_old_e_mutation_extract';
//       case 'old bhu naksha':
//         return 'tbl_old_bhu_naksha';
//       case 'mortgage report':
//         return 'tbl_mortgage_report';
//       case 'ceersai report':
//       case 'cersai reports':
//         return 'tbl_ceersai_report';
//       case 'rera builder documents':
//         return 'tbl_rera_builder_documents';
//       case 'registered document':
//         return 'tbl_registered_document';
//       case 'title investigation report':
//         return 'tbl_title_investigation_report';
//       case 'legal drafts':
//         return 'tbl_legal_drafts';
//       case 'court cases':
//         return 'Court Cases/Orders Search';
//       case 'adhikar abhilekh':
//         return 'tbl_adhikar_abhilekh';
//       default:
//         print('Default case triggered for: "$service"');
//         return service.toLowerCase().replaceAll(' ', '_');
//     }
//   }

//   void _navigateToServiceForm(BuildContext context, Map<String, dynamic> service) {
//     final String id = "";
//     final String packageId = widget.packageId;
//     final String? packageLeadId = widget.packageLeadId;
//     final String serviceName = service['service_name'] ?? 'Unknown Service';
//     final String tblName = _getTblName(serviceName);
//     final String serviceNameInLocal = service['service_name_in_local_language'] ?? serviceName;
//     final LanguageController languageController = Get.find<LanguageController>();
//     final bool isToggled = languageController.isToggled.value;
//     final String serviceLeadId = service['lead_id']?.toString() ?? widget.leadId;

//     print('Service Name: "$serviceName"');
//     print('Table Name: "$tblName"');
//     print('Service Lead ID: "$serviceLeadId"');

//     final int formStatus = service['form_status'] ?? 0;
//     final String leadStatus = service['lead_status']?.toString() ?? "0";

//     if (formStatus == 1 && leadStatus == "2") {
//       log('Form navigation blocked: form_status=$formStatus, lead_status=$leadStatus');
//       return;
//     }

//     if (formStatus == 1) {
//       log('Navigating to order details: form_status=$formStatus, lead_status=$leadStatus');
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => OrderpackageDetail(
//             lead_id: serviceLeadId,
//             tbl_name: tblName,
//             order: {
//               "serviceName": isToggled ? serviceNameInLocal : serviceName,
//               "status": getStatusDetails(leadStatus, isToggled)["text"],
//               "customerId": widget.customerId,
//               "tbl_name": tblName,
//             },
//             customerid: widget.customerId,
//             package_Id: widget.packageId,
//           ),
//         ),
//       );
//       return;
//     } else if (leadStatus == "2") {
//       log('Navigation blocked: lead_status=$leadStatus');
//       return;
//     } else {
//       log('Navigation allowed to form: form_status=$formStatus, lead_status=$leadStatus');
//     }

//     Widget targetScreen;
//     switch (tblName) {
//       case "tbl_seven_twelve":
//       case "tbl_eighta_extract":
//       case "tbl_e_mutation_extract":
//       case "tbl_bhu_naksha":
//         targetScreen = DigitallySign1(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "tbl_index_second_search":
//         targetScreen = IndexSearch1(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "tbl_rera_certificate":
//         targetScreen = ReraCertificate(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "tbl_property_card":
//         targetScreen = propertyCard(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "tbl_old_seven_twelve":
//       case "tbl_old_eighta_extract":
//       case "tbl_old_e_mutation_extract":
//       case "tbl_old_bhu_naksha":
//         targetScreen = oldextract1(
//           id: id,
//           package_lead_id: packageLeadId ?? widget.leadId,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//         );
//         break;
//       case "tbl_mortgage_report":
//         targetScreen = MortgageReports(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "tbl_ceersai_report":
//         targetScreen = MortgageReports(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "tbl_rera_builder_documents":
//         targetScreen = RERA_Builder(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "tbl_registered_document":
//         targetScreen = RegisteredDocument(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "tbl_title_investigation_report":
//         targetScreen = Investigation(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "tbl_legal_drafts":
//         targetScreen = Legaldrafts(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "Court Cases/Orders Search":
//         targetScreen = Courtcases(
//           id: id,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           packageId: packageId,
//           lead_id: serviceLeadId,
//           customer_id: widget.customerId,
//           package_lead_id: packageLeadId ?? widget.leadId,
//         );
//         break;
//       case "tbl_adhikar_abhilekh":
//         targetScreen = Adhikar_Abhilekh(
//           id: id,
//           package_lead_id: packageLeadId ?? widget.leadId,
//           packageId: packageId,
//           serviceName: serviceName,
//           tblName: tblName,
//           isToggled: isToggled,
//           serviceNameInLocalLanguage: serviceNameInLocal,
//           lead_id: serviceLeadId,
//           customerid: widget.customerId,
//         );
//         break;
//       default:
//         log('No matching case for tblName: "$tblName"');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               languageController.isToggled.value
//                   ? "या निवडीसाठी सेवा उपलब्ध नाही: $tblName"
//                   : "Service not available for this selection: $tblName",
//             ),
//           ),
//         );
//         return;
//     }
//     log('Navigating to form: $tblName');
//     Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen)).then((value) {
//       fetchservicestatus();
//     });
//   }

//   Map<String, dynamic> getStatusDetails(String leadStatus, bool isToggled) {
//     final Map<String, Map<String, Map<String, String>>> statusTranslations = {
//       "0": {"en": {"text": "Pending"}, "local": {"text": "प्रलंबित"}},
//       "1": {"en": {"text": "Order Confirmed"}, "local": {"text": "ऑर्डर पुष्ट"}},
//       "2": {"en": {"text": "Approved"}, "local": {"text": "मान्य"}},
//       "3": {"en": {"text": "Rejected"}, "local": {"text": "नाकारले"}},
//     };

//     final language = isToggled ? 'local' : 'en';
//     final status = statusTranslations[leadStatus] ?? {"en": {"text": "Unknown"}, "local": {"text": "अज्ञात"}};

//     switch (leadStatus) {
//       case "0":
//         return {"text": status[language]!["text"], "color": Colors.orange.shade100, "textColor": const Color(0xFFEA580C)};
//       case "1":
//         return {"text": status[language]!["text"], "color": Colors.green.shade100, "textColor": const Color(0xFF149845)};
//       case "2":
//         return {"text": status[language]!["text"], "color": Colors.green.shade100, "textColor": const Color(0xFF149845)};
//       case "3":
//         return {"text": status[language]!["text"], "color": Colors.red.shade100, "textColor": const Color(0xFFD32F2F)};
//       default:
//         return {"text": status[language]!["text"], "color": Colors.grey.shade100, "textColor": Colors.grey};
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final LanguageController languageController = Get.find<LanguageController>();

//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(() => Text(
//               languageController.isToggled.value ? "सेवा तपशील" : "Service Details",
//               style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xFF36322E), fontSize: 20),
//             )),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PackageScreen(
//                   customerId: widget.customerId,
//                   package_id: widget.packageId,
//                   tbl_name: widget.tblName,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       backgroundColor: const Color(0xFFF8F8F8),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(top: 15),
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.grey.shade300),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.1),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "${languageController.isToggled.value ? 'लीड आयडी' : 'Lead ID'} : ${widget.leadId}",
//                               style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 color: Colors.blue.shade100,
//                               ),
//                               child: Text(
//                                 packageData != null
//                                     ? (languageController.isToggled.value
//                                         ? packageData!['package_name_in_local_language']?.trim() ?? 'Unknown'
//                                         : packageData!['package_name'] ?? 'Unknown')
//                                     : 'Loading...',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.blue.shade900,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         services.isEmpty
//                             ? const Center(child: Text("No services available"))
//                             : SingleChildScrollView(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                                   children: services.map((service) {
//                                     final String leadStatus = service['lead_status']?.toString() ?? "0";
//                                     final statusDetails = getStatusDetails(leadStatus, languageController.isToggled.value);

//                                     return Padding(
//                                       padding: const EdgeInsets.symmetric(vertical: 4.0),
//                                       child: ElevatedButton(
//                                         onPressed: () => _navigateToServiceForm(context, service),
//                                         style: ElevatedButton.styleFrom(
//                                           foregroundColor: Colors.white,
//                                           backgroundColor: Colors.green,
//                                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                                         ),
//                                         child: Text(
//                                           languageController.isToggled.value
//                                               ? (service['service_name_in_local_language'] ?? 'Unknown')
//                                               : (service['service_name'] ?? 'Unknown'),
//                                           style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//     );
//   }
// }