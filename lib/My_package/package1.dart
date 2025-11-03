// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:dropdown_search/dropdown_search.dart';
// // import 'package:my_bhulekh_app/Order/order_list.dart';
// // import 'package:my_bhulekh_app/My_package/package_order_details.dart';
// // import 'package:my_bhulekh_app/My_package/package_order_details.dart'
// //     as ServicePackageDetails;
// // import 'package:my_bhulekh_app/Order/service_package_details.dart';
// // import 'package:my_bhulekh_app/colors/custom_color.dart';
// // import 'package:my_bhulekh_app/colors/order_fonts.dart';
// // import 'package:my_bhulekh_app/controller/package/my_package_controller.dart';
// // import 'package:my_bhulekh_app/profile/profile.dart';
// // import '../controller/order/language controller.dart';
// // import '../customfiles/bottom_navigation_controller.dart';
// // import '../homepage.dart';

// // class PackageScreen extends StatefulWidget {
// //   final String customerId; // Add customerId parameter
// //   final String package_id;
// //   final String? tbl_name;
// //   final String? leadId;
// //   const PackageScreen({
// //     Key? key,
// //     required this.customerId,
// //     required this.package_id,
// //     this.tbl_name,
// //     this.leadId,
// //     required String customerid,
// //   }) : super(key: key);

// //   @override
// //   _PackageScreenState createState() => _PackageScreenState();
// // }

// // class _PackageScreenState extends State<PackageScreen> {
// //   final BottomNavigationController navigationController =
// //       Get.find<BottomNavigationController>();
// //   final LanguageController languageController = Get.find<LanguageController>();
// //   final PackageOrderController packageController = Get.put(
// //     PackageOrderController(),
// //   );
// //   final ScrollController _scrollController = ScrollController();

// //   int _selectedIndex = 4;

// //   // @override
// //   // void initState() {
// //   //   super.initState();
// //   //   WidgetsBinding.instance.addPostFrameCallback((_) {
// //   //     packageController.fetchPackageOrders(
// //   //       customOffset: packageController.offset.value,
// //   //       isToggled: languageController.isToggled.value,
// //   //       leadId: widget.leadId,
// //   //     );
// //   //   });
// //   // @override
// //   // void initState() {
// //   //   super.initState();
// //   // WidgetsBinding.instance.addPostFrameCallback((_) {
// //   //   packageController.fetchPackageOrders(
// //   //     customOffset: packageController.offset.value,
// //   //     isToggled: languageController.isToggled.value,
// //   //     leadId: widget.leadId,
// //   //   );
// //   // });
// //   //   _scrollController.addListener(() {
// //   //     if (_scrollController.position.pixels >=
// //   //             _scrollController.position.maxScrollExtent - 100 &&
// //   //         !packageController.isLoadingMore.value) {
// //   //       packageController.fetchPackageOrders(
// //   //         customOffset: packageController.offset.value,
// //   //         isToggled: languageController.isToggled.value,
// //   //         leadId: widget.leadId,
// //   //       );
// //   //     }
// //   //   });
// //   //   // Pass customerId when fetching package orders
// //   //   //  packageController.fetchPackageOrders(customerId: widget.customerId);
// //   // }
// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       // Fetch with package_id and customerId to ensure the new package is included
// //       packageController
// //           .fetchPackageOrders(
// //             customOffset: 0, // Reset offset for fresh data
// //             isToggled: languageController.isToggled.value,
// //             leadId: widget.leadId,
// //             packageId: widget.package_id, // Add package_id
// //             customerId: widget.customerId, // Should be "147"// Add customerId
// //           )
// //           .then((_) {
// //             print(
// //               'Fetched ${packageController.allPackageOrders.length} packages',
// //             );
// //           });
// //     });

// //     _scrollController.addListener(() {
// //       if (_scrollController.position.pixels >=
// //               _scrollController.position.maxScrollExtent - 100 &&
// //           !packageController.isLoadingMore.value) {
// //         packageController.fetchPackageOrders(
// //           customOffset: packageController.offset.value,
// //           isToggled: languageController.isToggled.value,
// //           leadId: widget.leadId,
// //           packageId: widget.package_id, // Add package_id
// //           customerId: widget.customerId, // Should be "147"// Add customerId
// //         );
// //       }
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     super.dispose();
// //     print('PackageService opened with leadId: ${widget.leadId}');
// //   }

// //   void _showFilterDialog() {
// //     String? selectedPackageId;

// //     Get.dialog(
// //       AlertDialog(
// //         title: Text(
// //           languageController.isToggled.value
// //               ? 'पॅकेज फिल्टर करा'
// //               : 'Filter Packages',
// //           style: AppFontStyle.poppins(
// //             fontSize: 18,
// //             fontWeight: FontWeight.w500,
// //           ),
// //         ),
// //         content: Obx(
// //           () => DropdownSearch<String>(
// //             popupProps: PopupProps.menu(
// //               showSearchBox: true,
// //               searchFieldProps: TextFieldProps(
// //                 decoration: InputDecoration(
// //                   labelText:
// //                       languageController.isToggled.value
// //                           ? 'पॅकेज नाव शोधा'
// //                           : 'Search Package',
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             items:
// //                 packageController.allPackageOrders
// //                     .map((package) {
// //                       return languageController.isToggled.value
// //                           ? package.packageNameInLocalLanguage
// //                           : package.packageName;
// //                     })
// //                     .toSet()
// //                     .toList(),
// //             onChanged: (value) {
// //               final selectedPkg = packageController.allPackageOrders.firstWhere(
// //                 (pkg) =>
// //                     languageController.isToggled.value
// //                         ? pkg.packageNameInLocalLanguage == value
// //                         : pkg.packageName == value,
// //               );
// //               selectedPackageId = selectedPkg.packageId;
// //             },
// //             dropdownDecoratorProps: DropDownDecoratorProps(
// //               dropdownSearchDecoration: InputDecoration(
// //                 labelText:
// //                     languageController.isToggled.value
// //                         ? 'पॅकेज नाव निवडा'
// //                         : 'Select Package Name',
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Get.back(),
// //             child: Text(
// //               languageController.isToggled.value ? 'रद्द करा' : 'Cancel',
// //               style: AppFontStyle.poppins(color: Colors.grey),
// //             ),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               if (selectedPackageId != null) {
// //                 packageController.fetchPackageOrders(
// //                   customerId: widget.customerId,
// //                   customOffset: 0,
// //                   packageId: selectedPackageId,
// //                   isToggled: languageController.isToggled.value,
// //                 );
// //               }
// //               Get.back();
// //             },
// //             child: Text(
// //               languageController.isToggled.value ? 'लागू करा' : 'Apply',
// //               style: AppFontStyle.poppins(color: Colors.blue),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _onItemTapped(int index) {
// //     setState(() => _selectedIndex = index);
// //     switch (index) {
// //       case 0:
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(builder: (context) => HomePage2(customer_id: '')),
// //         );
// //         break;
// //       case 1:
// //         print("Customer Care tapped");
// //         break;
// //       case 2:
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder:
// //                 (context) => MyOrderScreen(
// //                   package_id: '',
// //                   customer_id: '', // Add customerId parameter
// //                 ),
// //           ),
// //         );
// //         break;
// //       case 3:
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder:
// //                 (context) =>
// //                     ProfilePage(isToggled: languageController.isToggled.value),
// //           ),
// //         );
// //         break;
// //       case 4:
// //         break;
// //     }
// //   }

// //   Map<String, dynamic> getStatusDetails(String leadStatus, bool isToggled) {
// //     final Map<String, Map<String, Map<String, String>>> statusTranslations = {
// //       "0": {
// //         "en": {"text": "Pending"},
// //         "local": {"text": "प्रलंबित"},
// //       },
// //       "1": {
// //         "en": {"text": "Order Confirmed"},
// //         "local": {"text": "ऑर्डर पुष्ट"},
// //       },
// //       "2": {
// //         "en": {"text": "Approved"},
// //         "local": {"text": "मान्य"},
// //       },
// //       "3": {
// //         "en": {"text": "Rejected"},
// //         "local": {"text": "नाकारले"},
// //       },
// //     };

// //     final language = isToggled ? 'local' : 'en';
// //     final status =
// //         statusTranslations[leadStatus] ??
// //         {
// //           "en": {"text": "Unknown"},
// //           "local": {"text": "अज्ञात"},
// //         };

// //     switch (leadStatus) {
// //       case "0":
// //         return {
// //           "text": status[language]!["text"],
// //           "color": Colors.orange.shade100,
// //           "textColor": const Color(0xFFEA580C),
// //         };
// //       case "1":
// //         return {
// //           "text": status[language]!["text"],
// //           "color": Colors.green.shade100,
// //           "textColor": const Color(0xFF149845),
// //         };
// //       case "2":
// //         return {
// //           "text": status[language]!["text"],
// //           "color": Colors.green.shade100,
// //           "textColor": const Color(0xFF149845),
// //         };
// //       case "3":
// //         return {
// //           "text": status[language]!["text"],
// //           "color": Colors.red.shade100,
// //           "textColor": const Color(0xFFD32F2F),
// //         };
// //       default:
// //         return {
// //           "text": status[language]!["text"],
// //           "color": Colors.grey.shade100,
// //           "textColor": Colors.grey,
// //         };
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Obx(
// //           () => Text(
// //             languageController.isToggled.value ? "पॅकेजेस" : "Package Order",
// //             style: AppFontStyle2.blinker(
// //               fontSize: 18,
// //               fontWeight: FontWeight.w600,
// //               color: const Color(0xFF36322E),
// //             ),
// //           ),
// //         ),
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
// //           onPressed: () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                 builder:
// //                     (context) => HomePage2(
// //                       customer_id: '',
// //                     ), // Replace with your HomePage2 widget
// //               ),
// //             );
// //           },
// //         ),
// //         //   icon: const Icon(Icons.arrow_back, color: Colors.black),
// //         //   onPressed: () => Navigator.pop(context),
// //         // ),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.filter_list, color: Colors.black),
// //             onPressed: _showFilterDialog,
// //           ),
// //           // IconButton(
// //           //   //icon: const Icon(Icons.refresh, color: Colors.black),
// //           //   onPressed: () async {
// //           //     await packageController.fetchPackageOrders(
// //           //       //  customerId: widget.customerId,
// //           //       customOffset: 0,
// //           //       packageId: null,
// //           //       isToggled: languageController.isToggled.value,
// //           //     );
// //           //   },
// //           // ),
// //         ],
// //       ),
// //       backgroundColor: const Color(0xFFF8F8F8),
// //       body: RefreshIndicator(
// //         onRefresh: () => packageController.refreshPackages(),
// //         child: Obx(
// //           () =>
// //               packageController.isLoading.value &&
// //                       packageController.allPackageOrders.isEmpty
// //                   ? const Center(child: CircularProgressIndicator())
// //                   : packageController.allPackageOrders.isEmpty
// //                   ? _buildNoDataScreen()
// //                   : ListView.builder(
// //                     physics: AlwaysScrollableScrollPhysics(),
// //                     controller: _scrollController,
// //                     padding: const EdgeInsets.all(20),
// //                     itemCount:
// //                         packageController.allPackageOrders.length +
// //                         (packageController.isLoadingMore.value ? 1 : 0),
// //                     itemBuilder: (context, index) {
// //                       if (index == packageController.allPackageOrders.length &&
// //                           packageController.isLoadingMore.value) {
// //                         return const Padding(
// //                           padding: EdgeInsets.all(8.0),
// //                           child: Center(child: CircularProgressIndicator()),
// //                         );
// //                       }

// //                       final package = packageController.allPackageOrders[index];
// //                       final statusDetails = getStatusDetails(
// //                         package.leadStatus,
// //                         languageController.isToggled.value,
// //                       );

// //                       return GestureDetector(
// //                         onTap: () {
// //                           // Example: Navigate using index 0, or you can pass a dynamic index
// //                           int selectedIndex =
// //                               0; // Change this dynamically if needed
// //                           print(
// //                             'Navigating to PackageService with customerId: ${widget.customerId}',
// //                           );
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder:
// //                                   (
// //                                     context,
// //                                   ) => ServicePackageDetails.PackageService(
// //                                     package_lead_id: package.id,
// //                                     package_Id: package.packageId,
// //                                     tbl_name:
// //                                         package.serviceNames.isNotEmpty
// //                                             ? package
// //                                                 .serviceNames[selectedIndex]
// //                                                 .tbl_name
// //                                             : null,
// //                                     lead_id: package.id,
// //                                     customerid:
// //                                         widget
// //                                             .customerId, // Should be "147", not "1"
// //                                   ),
// //                             ),
// //                           );
// //                         },
// //                         child: Container(
// //                           margin: const EdgeInsets.only(bottom: 15),
// //                           padding: const EdgeInsets.all(12),
// //                           decoration: BoxDecoration(
// //                             color: Colors.white,
// //                             borderRadius: BorderRadius.circular(10),
// //                             border: Border.all(color: Colors.grey.shade300),
// //                             boxShadow: [
// //                               BoxShadow(
// //                                 color: Colors.grey.withOpacity(0.1),
// //                                 spreadRadius: 2,
// //                                 blurRadius: 5,
// //                                 offset: const Offset(0, 3),
// //                               ),
// //                             ],
// //                           ),
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Row(
// //                                 mainAxisAlignment:
// //                                     MainAxisAlignment.spaceBetween,
// //                                 children: [
// //                                   Text(
// //                                     "${languageController.isToggled.value ? 'पॅकेज लीड आयडी' : 'Package Lead ID'} : ${package.id}",
// //                                     style: AppFontStyle2.blinker(
// //                                       fontWeight: FontWeight.w500,
// //                                       fontSize: 18,
// //                                     ),
// //                                   ),
// //                                   // Container(
// //                                   //   padding: const EdgeInsets.symmetric(
// //                                   //     horizontal: 12,
// //                                   //     vertical: 4,
// //                                   //   ),
// //                                   //   decoration: BoxDecoration(
// //                                   //     color: statusDetails["color"],
// //                                   //     borderRadius: BorderRadius.circular(8),
// //                                   //   ),
// //                                   //   child: Text(
// //                                   //     statusDetails["text"],
// //                                   //     style: GoogleFonts.poppins(
// //                                   //       color: statusDetails["textColor"],
// //                                   //       fontWeight: FontWeight.w500,
// //                                   //       fontSize: 14,
// //                                   //     ),
// //                                   //   ),
// //                                   // ),
// //                                   if (packageController
// //                                       .allPackageOrders
// //                                       .isNotEmpty)
// //                                     Container(
// //                                       padding: const EdgeInsets.symmetric(
// //                                         horizontal: 12,
// //                                         vertical: 4,
// //                                       ),
// //                                       decoration: BoxDecoration(
// //                                         color:
// //                                             getStatusDetails(
// //                                               package.leadStatus,
// //                                               languageController
// //                                                   .isToggled
// //                                                   .value,
// //                                             )['color'],
// //                                         borderRadius: BorderRadius.circular(8),
// //                                       ),
// //                                       child: Text(
// //                                         getStatusDetails(
// //                                           package.leadStatus,
// //                                           languageController.isToggled.value,
// //                                         )['text'],
// //                                         style: AppFontStyle2.blinker(
// //                                           color:
// //                                               getStatusDetails(
// //                                                 package.leadStatus,
// //                                                 languageController
// //                                                     .isToggled
// //                                                     .value,
// //                                               )['textColor'],
// //                                           fontWeight: FontWeight.w500,
// //                                           fontSize: 16,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 8),
// //                               _buildRow(
// //                                 languageController.isToggled.value
// //                                     ? "पॅकेज नाव"
// //                                     : "Package Name",
// //                                 languageController.isToggled.value
// //                                     ? package.packageNameInLocalLanguage
// //                                     : package.packageName,
// //                               ),
// //                               const SizedBox(height: 8),
// //                               Wrap(
// //                                 spacing: 6,
// //                                 runSpacing: 6,
// //                                 children:
// //                                     package.serviceNames.map((service) {
// //                                       return Container(
// //                                         padding: const EdgeInsets.symmetric(
// //                                           horizontal: 8,
// //                                           vertical: 2,
// //                                         ),
// //                                         decoration: BoxDecoration(
// //                                           color: const Color(0xFFF5F4F1),
// //                                           borderRadius: BorderRadius.circular(
// //                                             5,
// //                                           ),
// //                                           border: Border.all(
// //                                             color: const Color(0xFFE5E7EB),
// //                                           ),
// //                                         ),
// //                                         child: Text(
// //                                           languageController.isToggled.value
// //                                               ? service
// //                                                   .serviceNameInLocalLanguage
// //                                               : service.serviceName,
// //                                           style: AppFontStyle2.blinker(
// //                                             fontSize: 13,
// //                                             fontWeight: FontWeight.w400,
// //                                             color: const Color(0xFF757575),
// //                                           ),
// //                                         ),
// //                                       );
// //                                     }).toList(),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //         ),
// //       ),
// //       bottomNavigationBar: Container(
// //         decoration: const BoxDecoration(
// //           color: Color(0xFFFFFFFF),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Color(0x14000000),
// //               offset: Offset(2, 0),
// //               blurRadius: 25,
// //               spreadRadius: 0,
// //             ),
// //           ],
// //         ),
// //         child: Obx(
// //           () => BottomNavigationBar(
// //             type: BottomNavigationBarType.fixed,
// //             items: [
// //               BottomNavigationBarItem(
// //                 icon: const Icon(Icons.home),
// //                 label: languageController.isToggled.value ? 'होम' : 'Home',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: const Icon(Icons.support_agent_outlined),
// //                 label:
// //                     languageController.isToggled.value
// //                         ? 'ग्राहक सेवा'
// //                         : 'Customer Care',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: const Icon(Icons.edit_document),
// //                 label:
// //                     languageController.isToggled.value
// //                         ? 'माझी ऑर्डर'
// //                         : 'My Order',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: const Icon(Icons.person),
// //                 label:
// //                     languageController.isToggled.value
// //                         ? 'माझे प्रोफाइल'
// //                         : 'My Profile',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: const Icon(Icons.person),
// //                 label:
// //                     languageController.isToggled.value ? 'पॅकेजेस' : 'Packages',
// //               ),
// //             ],
// //             currentIndex: _selectedIndex,
// //             selectedItemColor: Colorfile.bordertheme,
// //             unselectedItemColor: Colorfile.lightgrey,
// //             onTap: _onItemTapped,
// //             showUnselectedLabels: true,
// //             showSelectedLabels: true,
// //             backgroundColor: Colors.transparent,
// //             elevation: 0,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildNoDataScreen() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.inbox, size: 80, color: Colors.grey.shade400),
// //           const SizedBox(height: 16),
// //           Text(
// //             languageController.isToggled.value
// //                 ? "कोणतेही पॅकेज सापडले नाहीत"
// //                 : "No Packages Found",
// //             style: AppFontStyle2.blinker(
// //               fontSize: 20,
// //               fontWeight: FontWeight.w500,
// //               color: Colors.grey.shade600,
// //             ),
// //           ),
// //           const SizedBox(height: 8),
// //           Text(
// //             languageController.isToggled.value
// //                 ? "असे दिसते की दाखवण्यासाठी कोणतेही पॅकेज नाहीत."
// //                 : "It seems there are no packages to display.",
// //             style: AppFontStyle2.blinker(
// //               fontSize: 16,
// //               color: Colors.grey.shade500,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildRow(String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 1.0),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           SizedBox(
// //             width: 120,
// //             child: Text(
// //               label,
// //               style: AppFontStyle2.blinker(
// //                 fontSize: 16,
// //                 fontWeight: FontWeight.w400,
// //                 color: const Color(0xFF36322E),
// //               ),
// //               textAlign: TextAlign.left,
// //             ),
// //           ),
// //           Text(":", style: AppFontStyle.poppins(fontSize: 16)),
// //           const SizedBox(width: 4),
// //           Expanded(
// //             child: Text(
// //               value,
// //               style: AppFontStyle2.blinker(
// //                 fontSize: 16,
// //                 fontWeight: FontWeight.w400,
// //                 color: const Color(0xFF36322E),
// //               ),
// //               softWrap: true,
// //               textAlign: TextAlign.left,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:dropdown_search/dropdown_search.dart';
// // // import 'package:my_bhulekh_app/Order/order_list.dart';
// // // import 'package:my_bhulekh_app/Order/package_order_details.dart';
// // // import 'package:my_bhulekh_app/Order/package_order_details.dart'
// // //     as ServicePackageDetails;
// // // import 'package:my_bhulekh_app/Order/service_package_details.dart';
// // // import 'package:my_bhulekh_app/controller/package/my_package_controller.dart';
// // // import 'package:my_bhulekh_app/profile/profile.dart';
// // // import '../controller/order/language controller.dart';
// // // import '../colors/custom_color.dart';
// // // import '../customfiles/bottom_navigation_controller.dart';
// // // import '../homepage.dart';

// // // class PackageScreen extends StatefulWidget {
// // //   final String customerId;
// // //   final String package_id;
// // //   final String? tbl_name;
// // //   final String? leadId;
// // //   const PackageScreen({
// // //     Key? key,
// // //     required this.customerId,
// // //     required this.package_id,
// // //     this.tbl_name,
// // //     this.leadId,
// // //   }) : super(key: key);

// // //   @override
// // //   _PackageScreenState createState() => _PackageScreenState();
// // // }

// // // class _PackageScreenState extends State<PackageScreen> {
// // //   final BottomNavigationController navigationController =
// // //       Get.find<BottomNavigationController>();
// // //   final LanguageController languageController = Get.find<LanguageController>();
// // //   final PackageOrderController packageController = Get.put(
// // //     PackageOrderController(),
// // //   );
// // //   final ScrollController _scrollController = ScrollController();

// // //   int _selectedIndex = 4;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _scrollController.addListener(() {
// // //       if (_scrollController.position.pixels >=
// // //               _scrollController.position.maxScrollExtent - 100 &&
// // //           !packageController.isLoadingMore.value) {
// // //         packageController.fetchPackageOrders(
// // //           customOffset: packageController.offset.value,
// // //           isToggled: languageController.isToggled.value,
// // //           leadId: widget.leadId,
// // //         );
// // //       }
// // //     });
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _scrollController.dispose();
// // //     super.dispose();
// // //     print('PackageService opened with leadId: ${widget.leadId}');
// // //   }

// // //   void _showFilterDialog() {
// // //     String? selectedPackageId;

// // //     Get.dialog(
// // //       AlertDialog(
// // //         title: Text(
// // //           languageController.isToggled.value
// // //               ? 'पॅकेज फिल्टर करा'
// // //               : 'Filter Packages',
// // //           style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
// // //         ),
// // //         content: Obx(
// // //           () => DropdownSearch<String>(
// // //             popupProps: PopupProps.menu(
// // //               showSearchBox: true,
// // //               searchFieldProps: TextFieldProps(
// // //                 decoration: InputDecoration(
// // //                   labelText:
// // //                       languageController.isToggled.value
// // //                           ? 'पॅकेज नाव शोधा'
// // //                           : 'Search Package',
// // //                   border: OutlineInputBorder(
// // //                     borderRadius: BorderRadius.circular(8),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //             items:
// // //                 packageController.allPackageOrders
// // //                     .map(
// // //                       (package) =>
// // //                           languageController.isToggled.value
// // //                               ? package.packageNameInLocalLanguage
// // //                               : package.packageName,
// // //                     )
// // //                     .toSet()
// // //                     .toList(),
// // //             onChanged: (value) {
// // //               final selectedPkg = packageController.allPackageOrders.firstWhere(
// // //                 (pkg) =>
// // //                     languageController.isToggled.value
// // //                         ? pkg.packageNameInLocalLanguage == value
// // //                         : pkg.packageName == value,
// // //               );
// // //               selectedPackageId = selectedPkg.packageId;
// // //             },
// // //             dropdownDecoratorProps: DropDownDecoratorProps(
// // //               dropdownSearchDecoration: InputDecoration(
// // //                 labelText:
// // //                     languageController.isToggled.value
// // //                         ? 'पॅकेज नाव निवडा'
// // //                         : 'Select Package Name',
// // //                 border: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(8),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () => Get.back(),
// // //             child: Text(
// // //               languageController.isToggled.value ? 'रद्द करा' : 'Cancel',
// // //               style: GoogleFonts.poppins(color: Colors.grey),
// // //             ),
// // //           ),
// // //           TextButton(
// // //             onPressed: () {
// // //               if (selectedPackageId != null) {
// // //                 packageController.fetchPackageOrders(
// // //                   customOffset: 0,
// // //                   packageId: selectedPackageId,
// // //                   isToggled: languageController.isToggled.value,
// // //                 );
// // //               }
// // //               Get.back();
// // //             },
// // //             child: Text(
// // //               languageController.isToggled.value ? 'लागू करा' : 'Apply',
// // //               style: GoogleFonts.poppins(color: Colors.blue),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   void _onItemTapped(int index) {
// // //     setState(() => _selectedIndex = index);
// // //     switch (index) {
// // //       case 0:
// // //         Navigator.push(
// // //           context,
// // //           MaterialPageRoute(builder: (context) => HomePage2(customer_id: '')),
// // //         );
// // //         break;
// // //       case 1:
// // //         print("Customer Care tapped");
// // //         break;
// // //       case 2:
// // //         Navigator.push(
// // //           context,
// // //           MaterialPageRoute(
// // //             builder:
// // //                 (context) => MyOrderScreen(package_id: '', customer_id: ''),
// // //           ),
// // //         );
// // //         break;
// // //       case 3:
// // //         Navigator.push(
// // //           context,
// // //           MaterialPageRoute(
// // //             builder:
// // //                 (context) =>
// // //                     ProfilePage(isToggled: languageController.isToggled.value),
// // //           ),
// // //         );
// // //         break;
// // //       case 4:
// // //         break;
// // //     }
// // //   }

// // //   Map<String, dynamic> getStatusDetails(String leadStatus, bool isToggled) {
// // //     final Map<String, Map<String, Map<String, String>>> statusTranslations = {
// // //       "0": {
// // //         "en": {"text": "Pending"},
// // //         "local": {"text": "प्रलंबित"},
// // //       },
// // //       "1": {
// // //         "en": {"text": "Order Confirmed"},
// // //         "local": {"text": "ऑर्डर पुष्ट"},
// // //       },
// // //       "2": {
// // //         "en": {"text": "Approved"},
// // //         "local": {"text": "मान्य"},
// // //       },
// // //       "3": {
// // //         "en": {"text": "Rejected"},
// // //         "local": {"text": "नाकारले"},
// // //       },
// // //     };

// // //     final language = isToggled ? 'local' : 'en';
// // //     final status =
// // //         statusTranslations[leadStatus] ??
// // //         {
// // //           "en": {"text": "Unknown"},
// // //           "local": {"text": "अज्ञात"},
// // //         };

// // //     switch (leadStatus) {
// // //       case "0":
// // //         return {
// // //           "text": status[language]!["text"],
// // //           "color": Colors.orange.shade100,
// // //           "textColor": const Color(0xFFEA580C),
// // //         };
// // //       case "1":
// // //         return {
// // //           "text": status[language]!["text"],
// // //           "color": Colors.green.shade100,
// // //           "textColor": const Color(0xFF149845),
// // //         };
// // //       case "2":
// // //         return {
// // //           "text": status[language]!["text"],
// // //           "color": Colors.green.shade100,
// // //           "textColor": const Color(0xFF149845),
// // //         };
// // //       case "3":
// // //         return {
// // //           "text": status[language]!["text"],
// // //           "color": Colors.red.shade100,
// // //           "textColor": const Color(0xFFD32F2F),
// // //         };
// // //       default:
// // //         return {
// // //           "text": status[language]!["text"],
// // //           "color": Colors.grey.shade100,
// // //           "textColor": Colors.grey,
// // //         };
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Obx(
// // //           () => Text(
// // //             languageController.isToggled.value ? "पॅकेजेस" : "Package Order",
// // //             style: GoogleFonts.poppins(
// // //               fontWeight: FontWeight.w500,
// // //               color: const Color(0xFF36322E),
// // //               fontSize: 20,
// // //             ),
// // //           ),
// // //         ),
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
// // //           onPressed:
// // //               () => Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(
// // //                   builder: (context) => HomePage2(customer_id: ''),
// // //                 ),
// // //               ),
// // //         ),
// // //         actions: [
// // //           IconButton(
// // //             icon: const Icon(Icons.filter_list, color: Colors.black),
// // //             onPressed: _showFilterDialog,
// // //           ),
// // //         ],
// // //       ),
// // //       backgroundColor: const Color(0xFFF8F8F8),
// // //       body: RefreshIndicator(
// // //         onRefresh: () => packageController.refreshPackages(),
// // //         child: Obx(
// // //           () =>
// // //               packageController.isLoading.value &&
// // //                       packageController.allPackageOrders.isEmpty
// // //                   ? const Center(child: CircularProgressIndicator())
// // //                   : packageController.allPackageOrders.isEmpty
// // //                   ? _buildNoDataScreen()
// // //                   : ListView.builder(
// // //                     physics: AlwaysScrollableScrollPhysics(),
// // //                     controller: _scrollController,
// // //                     padding: const EdgeInsets.all(20),
// // //                     itemCount:
// // //                         packageController.allPackageOrders.length +
// // //                         (packageController.isLoadingMore.value ? 1 : 0),
// // //                     itemBuilder: (context, index) {
// // //                       if (index == packageController.allPackageOrders.length &&
// // //                           packageController.isLoadingMore.value) {
// // //                         return const Padding(
// // //                           padding: EdgeInsets.all(8.0),
// // //                           child: Center(child: CircularProgressIndicator()),
// // //                         );
// // //                       }

// // //                       final package = packageController.allPackageOrders[index];
// // //                       final statusDetails = getStatusDetails(
// // //                         package.leadStatus,
// // //                         languageController.isToggled.value,
// // //                       );

// // //                       return GestureDetector(
// // //                         onTap: () {
// // //                           print('Navigating to PackageService with:');
// // //                           print('Package Lead ID: ${package.id}');
// // //                           print(
// // //                             'Service Lead ID: ${package.serviceNames.isNotEmpty ? package.serviceNames.first.leadId : 'none'}',
// // //                           );
// // //                           print('Table Name: ${package.tblName}');
// // //                           print('Customer ID: ${widget.customerId}');
// // //                           print('lead ID: ${package.leadid}');
// // //                           Navigator.push(
// // //                             context,
// // //                             MaterialPageRoute(
// // //                               builder: (context) {
// // //                                 print('Navigating to PackageService with:');
// // //                                 print('package.id: ${package.id}');
// // //                                 print(
// // //                                   'package.packageId: ${package.packageId}',
// // //                                 );
// // //                                 print('package.tblName: ${package.tblName}');
// // //                                 print('customerId: ${widget.customerId}');

// // //                                 // Validate package.id
// // //                                 final String leadId =
// // //                                     package.id != null &&
// // //                                             package.id.isNotEmpty &&
// // //                                             package.id != "Unknown Lead"
// // //                                         ? package.id
// // //                                         : "default_lead_id"; // Replace with a fallback if applicable

// // //                                 return ServicePackageDetails.PackageService(
// // //                                   package_lead_id: package.id,
// // //                                   package_Id: package.packageId,
// // //                                   tbl_name: package.tblName,
// // //                                   lead_id: leadId, // Use validated lead_id
// // //                                   customerid: widget.customerId,
// // //                                 );
// // //                               },
// // //                             ),
// // //                           );
// // //                         },
// // //                         child: Container(
// // //                           margin: const EdgeInsets.only(bottom: 15),
// // //                           padding: const EdgeInsets.all(12),
// // //                           decoration: BoxDecoration(
// // //                             color: Colors.white,
// // //                             borderRadius: BorderRadius.circular(10),
// // //                             border: Border.all(color: Colors.grey.shade300),
// // //                             boxShadow: [
// // //                               BoxShadow(
// // //                                 color: Colors.grey.withOpacity(0.1),
// // //                                 spreadRadius: 2,
// // //                                 blurRadius: 5,
// // //                                 offset: const Offset(0, 3),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                           child: Column(
// // //                             crossAxisAlignment: CrossAxisAlignment.start,
// // //                             children: [
// // //                               Row(
// // //                                 mainAxisAlignment:
// // //                                     MainAxisAlignment.spaceBetween,
// // //                                 children: [
// // //                                   Text(
// // //                                     "${languageController.isToggled.value ? 'पॅकेज लीड आयडी' : 'Package Lead ID'} : ${package.id}",
// // //                                     style: GoogleFonts.poppins(
// // //                                       fontWeight: FontWeight.w500,
// // //                                       fontSize: 16,
// // //                                     ),
// // //                                   ),
// // //                                   if (packageController
// // //                                       .allPackageOrders
// // //                                       .isNotEmpty)
// // //                                     Container(
// // //                                       padding: const EdgeInsets.symmetric(
// // //                                         horizontal: 12,
// // //                                         vertical: 4,
// // //                                       ),
// // //                                       decoration: BoxDecoration(
// // //                                         color: statusDetails['color'],
// // //                                         borderRadius: BorderRadius.circular(8),
// // //                                       ),
// // //                                       child: Text(
// // //                                         statusDetails['text'],
// // //                                         style: GoogleFonts.poppins(
// // //                                           color: statusDetails['textColor'],
// // //                                           fontWeight: FontWeight.w500,
// // //                                           fontSize: 14,
// // //                                         ),
// // //                                       ),
// // //                                     ),
// // //                                 ],
// // //                               ),
// // //                               const SizedBox(height: 8),
// // //                               _buildRow(
// // //                                 languageController.isToggled.value
// // //                                     ? "पॅकेज नाव"
// // //                                     : "Package Name",
// // //                                 languageController.isToggled.value
// // //                                     ? package.packageNameInLocalLanguage
// // //                                     : package.packageName,
// // //                               ),
// // //                               const SizedBox(height: 8),
// // //                               Wrap(
// // //                                 spacing: 6,
// // //                                 runSpacing: 6,
// // //                                 children:
// // //                                     package.serviceNames
// // //                                         .map(
// // //                                           (service) => Container(
// // //                                             padding: const EdgeInsets.symmetric(
// // //                                               horizontal: 8,
// // //                                               vertical: 2,
// // //                                             ),
// // //                                             decoration: BoxDecoration(
// // //                                               color: const Color(0xFFF5F4F1),
// // //                                               borderRadius:
// // //                                                   BorderRadius.circular(5),
// // //                                               border: Border.all(
// // //                                                 color: const Color(0xFFE5E7EB),
// // //                                               ),
// // //                                             ),
// // //                                             child: Text(
// // //                                               languageController.isToggled.value
// // //                                                   ? service
// // //                                                       .serviceNameInLocalLanguage
// // //                                                   : service.serviceName,
// // //                                               style: GoogleFonts.poppins(
// // //                                                 fontSize: 11,
// // //                                                 fontWeight: FontWeight.w400,
// // //                                                 color: const Color(0xFF757575),
// // //                                               ),
// // //                                             ),
// // //                                           ),
// // //                                         )
// // //                                         .toList(),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //         ),
// // //       ),
// // //       bottomNavigationBar: Container(
// // //         decoration: const BoxDecoration(
// // //           color: Color(0xFFFFFFFF),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: Color(0x14000000),
// // //               offset: Offset(2, 0),
// // //               blurRadius: 25,
// // //               spreadRadius: 0,
// // //             ),
// // //           ],
// // //         ),
// // //         child: Obx(
// // //           () => BottomNavigationBar(
// // //             type: BottomNavigationBarType.fixed,
// // //             items: [
// // //               BottomNavigationBarItem(
// // //                 icon: const Icon(Icons.home),
// // //                 label: languageController.isToggled.value ? 'होम' : 'Home',
// // //               ),
// // //               BottomNavigationBarItem(
// // //                 icon: const Icon(Icons.support_agent_outlined),
// // //                 label:
// // //                     languageController.isToggled.value
// // //                         ? 'ग्राहक सेवा'
// // //                         : 'Customer Care',
// // //               ),
// // //               BottomNavigationBarItem(
// // //                 icon: const Icon(Icons.edit_document),
// // //                 label:
// // //                     languageController.isToggled.value
// // //                         ? 'माझी ऑर्डर'
// // //                         : 'My Order',
// // //               ),
// // //               BottomNavigationBarItem(
// // //                 icon: const Icon(Icons.person),
// // //                 label:
// // //                     languageController.isToggled.value
// // //                         ? 'माझे प्रोफाइल'
// // //                         : 'My Profile',
// // //               ),
// // //               BottomNavigationBarItem(
// // //                 icon: const Icon(Icons.person),
// // //                 label:
// // //                     languageController.isToggled.value ? 'पॅकेजेस' : 'Packages',
// // //               ),
// // //             ],
// // //             currentIndex: _selectedIndex,
// // //             selectedItemColor: Colorfile.bordertheme,
// // //             unselectedItemColor: Colorfile.lightgrey,
// // //             onTap: _onItemTapped,
// // //             showUnselectedLabels: true,
// // //             showSelectedLabels: true,
// // //             backgroundColor: Colors.transparent,
// // //             elevation: 0,
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildNoDataScreen() {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(Icons.inbox, size: 80, color: Colors.grey.shade400),
// // //           const SizedBox(height: 16),
// // //           Text(
// // //             languageController.isToggled.value
// // //                 ? "कोणतेही पॅकेज सापडले नाहीत"
// // //                 : "No Packages Found",
// // //             style: GoogleFonts.poppins(
// // //               fontSize: 20,
// // //               fontWeight: FontWeight.w500,
// // //               color: Colors.grey.shade600,
// // //             ),
// // //           ),
// // //           const SizedBox(height: 8),
// // //           Text(
// // //             languageController.isToggled.value
// // //                 ? "असे दिसते की दाखवण्यासाठी कोणतेही पॅकेज नाहीत."
// // //                 : "It seems there are no packages to display.",
// // //             style: GoogleFonts.poppins(
// // //               fontSize: 14,
// // //               color: Colors.grey.shade500,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildRow(String label, String value) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 1.0),
// // //       child: Row(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           SizedBox(
// // //             width: 120,
// // //             child: Text(
// // //               label,
// // //               style: GoogleFonts.poppins(
// // //                 fontSize: 14,
// // //                 fontWeight: FontWeight.w400,
// // //                 color: const Color(0xFF36322E),
// // //               ),
// // //               textAlign: TextAlign.left,
// // //             ),
// // //           ),
// // //           const Text(":", style: TextStyle(fontSize: 16)),
// // //           const SizedBox(width: 4),
// // //           Expanded(
// // //             child: Text(
// // //               value,
// // //               style: GoogleFonts.poppins(
// // //                 fontSize: 14,
// // //                 fontWeight: FontWeight.w400,
// // //                 color: const Color(0xFF36322E),
// // //               ),
// // //               softWrap: true,
// // //               textAlign: TextAlign.left,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:my_bhulekh_app/Order/order_list.dart';
// import 'package:my_bhulekh_app/My_package/package_order_details.dart'
//     as ServicePackageDetails;
// import 'package:my_bhulekh_app/Order/service_package_details.dart';
// import 'package:my_bhulekh_app/controller/order/language%20controller.dart';
// import 'package:my_bhulekh_app/controller/package/my_package_controller.dart';
// import 'package:my_bhulekh_app/profile/profile.dart';
// import '../customfiles/bottom_navigation_controller.dart';
// import '../homepage.dart';

// class PackageScreen extends StatefulWidget {
//   final String customerId;
//   final String package_id;
//   final String? tbl_name;
//   final String? leadId;
//   const PackageScreen({
//     Key? key,
//     required this.customerId,
//     required this.package_id,
//     this.tbl_name,
//     this.leadId,
//   }) : super(key: key);

//   @override
//   _PackageScreenState createState() => _PackageScreenState();
// }

// class _PackageScreenState extends State<PackageScreen> {
//   final BottomNavigationController navigationController =
//       Get.find<BottomNavigationController>();
//   final LanguageController languageController = Get.find<LanguageController>();
//   final PackageOrderController packageController = Get.put(
//     PackageOrderController(),
//   );
//   final ScrollController _scrollController = ScrollController();

//   int _selectedIndex = 4;

//   @override
//   void initState() {
//     super.initState();
//     //   WidgetsBinding.instance.addPostFrameCallback((_) {
//     //     // If package_id is provided (e.g., after adding a package), fetch it first
//     //     if (widget.package_id.isNotEmpty) {
//     //       packageController
//     //           .fetchPackageOrders(
//     //             customOffset: 0,
//     //             isToggled: languageController.isToggled.value,
//     //             leadId: widget.leadId,
//     //             packageId: widget.package_id,
//     //             customerId: widget.customerId,
//     //           )
//     //           .then((_) {
//     //             // After fetching the specific package, fetch all packages
//     //             packageController.fetchPackageOrders(
//     //               customOffset: 0,
//     //               isToggled: languageController.isToggled.value,
//     //               leadId: widget.leadId,
//     //               packageId: null, // Fetch all packages
//     //               customerId: widget.customerId,
//     //             );
//     //           });
//     //     } else {
//     //       // Otherwise, fetch all packages directly
//     //       packageController.fetchPackageOrders(
//     //         customOffset: 0,
//     //         isToggled: languageController.isToggled.value,
//     //         leadId: widget.leadId,
//     //         packageId: null,
//     //         customerId: widget.customerId,
//     //       );
//     //     }
//     //   });

//     //   _scrollController.addListener(() {
//     //     if (_scrollController.position.pixels >=
//     //             _scrollController.position.maxScrollExtent - 100 &&
//     //         !packageController.isLoadingMore.value) {
//     //       packageController.fetchPackageOrders(
//     //         customOffset: packageController.offset.value,
//     //         isToggled: languageController.isToggled.value,
//     //         leadId: widget.leadId,
//     //         packageId: null, // Fetch all packages for pagination
//     //         customerId: widget.customerId,
//     //       );
//     //     }
//     //   });
//     // }
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       packageController.fetchPackageOrders(
//         isToggled: languageController.isToggled.value,
//       );
//     });

//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//               _scrollController.position.maxScrollExtent - 100 &&
//           !packageController.isLoadingMore.value) {
//         packageController.fetchPackageOrders(
//           isToggled: languageController.isToggled.value,
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//     print('PackageService opened with leadId: ${widget.leadId}');
//   }

//   void _showFilterDialog() {
//     String? selectedPackageId;

//     Get.dialog(
//       AlertDialog(
//         title: Text(
//           languageController.isToggled.value
//               ? 'पॅकेज फिल्टर करा'
//               : 'Filter Packages',
//           style: const TextStyle(
//             fontFamily: 'MyCustomFont',
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         content: Obx(
//           () => DropdownSearch<String>(
//             popupProps: PopupProps.menu(
//               showSearchBox: true,
//               searchFieldProps: TextFieldProps(
//                 decoration: InputDecoration(
//                   labelText:
//                       languageController.isToggled.value
//                           ? 'पॅकेज नाव शोधा'
//                           : 'Search Package',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//             items:
//                 packageController.allPackageOrders
//                     .map((package) {
//                       return languageController.isToggled.value
//                           ? package.packageNameInLocalLanguage
//                           : package.packageName;
//                     })
//                     .toSet()
//                     .toList(),
//             onChanged: (value) {
//               final selectedPkg = packageController.allPackageOrders.firstWhere(
//                 (pkg) =>
//                     languageController.isToggled.value
//                         ? pkg.packageNameInLocalLanguage == value
//                         : pkg.packageName == value,
//               );
//               selectedPackageId = selectedPkg.packageId;
//             },
//             dropdownDecoratorProps: DropDownDecoratorProps(
//               dropdownSearchDecoration: InputDecoration(
//                 labelText:
//                     languageController.isToggled.value
//                         ? 'पॅकेज नाव निवडा'
//                         : 'Select Package Name',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text(
//               languageController.isToggled.value ? 'रद्द करा' : 'Cancel',
//               style: const TextStyle(
//                 fontFamily: 'MyCustomFont',
//                 color: Colors.grey,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               if (selectedPackageId != null) {
//                 packageController.fetchPackageOrders(
//                   customerId: widget.customerId,
//                   customOffset: 0,
//                   packageId: selectedPackageId,
//                   isToggled: languageController.isToggled.value,
//                 );
//               }
//               Get.back();
//             },
//             child: Text(
//               languageController.isToggled.value ? 'लागू करा' : 'Apply',
//               style: const TextStyle(
//                 fontFamily: 'MyCustomFont',
//                 color: Colors.blue,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);
//     switch (index) {
//       case 0:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HomePage2(customer_id: '', customerId: '',)),
//         );
//         break;
//       case 1:
//         print("Customer Care tapped");
//         break;
//       case 2:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder:
//                 (context) => MyOrderScreen(package_id: '', customer_id: ''),
//           ),
//         );
//         break;
//       case 3:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder:
//                 (context) =>
//                     ProfilePage(isToggled: languageController.isToggled.value),
//           ),
//         );
//         break;
//       case 4:
//         break;
//     }
//   }

//   Map<String, dynamic> getStatusDetails(String leadStatus, bool isToggled) {
//     final Map<String, Map<String, Map<String, String>>> statusTranslations = {
//       "0": {
//         "en": {"text": "Pending"},
//         "local": {"text": "प्रलंबित"},
//       },
//       "1": {
//         "en": {"text": "Order Confirmed"},
//         "local": {"text": "ऑर्डर पुष्ट"},
//       },
//       "2": {
//         "en": {"text": "Approved"},
//         "local": {"text": "मान्य"},
//       },
//       "3": {
//         "en": {"text": "Rejected"},
//         "local": {"text": "नाकारले"},
//       },
//     };

//     final language = isToggled ? 'local' : 'en';
//     final status =
//         statusTranslations[leadStatus] ??
//         {
//           "en": {"text": "Unknown"},
//           "local": {"text": "अज्ञात"},
//         };

//     switch (leadStatus) {
//       case "0":
//         return {
//           "text": status[language]!["text"],
//           "color": Colors.orange.shade100,
//           "textColor": const Color(0xFFEA580C),
//         };
//       case "1":
//         return {
//           "text": status[language]!["text"],
//           "color": Colors.green.shade100,
//           "textColor": const Color(0xFF149845),
//         };
//       case "2":
//         return {
//           "text": status[language]!["text"],
//           "color": Colors.green.shade100,
//           "textColor": const Color(0xFF149845),
//         };
//       case "3":
//         return {
//           "text": status[language]!["text"],
//           "color": Colors.red.shade100,
//           "textColor": const Color(0xFFD32F2F),
//         };
//       default:
//         return {
//           "text": status[language]!["text"],
//           "color": Colors.grey.shade100,
//           "textColor": Colors.grey,
//         };
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(
//           () => Text(
//             languageController.isToggled.value ? "पॅकेजेस" : "Package Order",
//             style: const TextStyle(
//               fontFamily: 'MyCustomFont',
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF36322E),
//             ),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => HomePage2(customer_id: '', customerId: '',),
//               ),
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list, color: Colors.black),
//             onPressed: _showFilterDialog,
//           ),
//         ],
//       ),
//       backgroundColor: const Color(0xFFF8F8F8),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await packageController.fetchPackageOrders(
//             customOffset: 0,
//             isToggled: languageController.isToggled.value,
//             leadId: widget.leadId,
//             packageId: null, // Fetch all packages on refresh
//             customerId: widget.customerId,
//           );
//         },
//         child: Obx(
//           () =>
//               packageController.isLoading.value &&
//                       packageController.allPackageOrders.isEmpty
//                   ? const Center(child: CircularProgressIndicator())
//                   : packageController.allPackageOrders.isEmpty
//                   ? _buildNoDataScreen()
//                   : ListView.builder(
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     controller: _scrollController,
//                     padding: const EdgeInsets.all(20),
//                     itemCount:
//                         packageController.allPackageOrders.length +
//                         (packageController.isLoadingMore.value ? 1 : 0),
//                     itemBuilder: (context, index) {
//                       if (index == packageController.allPackageOrders.length &&
//                           packageController.isLoadingMore.value) {
//                         return const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Center(child: CircularProgressIndicator()),
//                         );
//                       }

//                       final package = packageController.allPackageOrders[index];
//                       final statusDetails = getStatusDetails(
//                         package.leadStatus,
//                         languageController.isToggled.value,
//                       );

//                       return GestureDetector(
//                         onTap: () {
//                           int selectedIndex = 0;
//                           print(
//                             'Navigating to PackageService with customerId: ${widget.customerId}',
//                           );
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder:
//                                   (context) =>
//                                       ServicePackageDetails.PackageService(
//                                         package_lead_id: package.id,
//                                         package_Id: package.packageId,
//                                         tbl_name:
//                                             package.serviceNames.isNotEmpty
//                                                 ? package
//                                                     .serviceNames[selectedIndex]
//                                                     .tbl_name
//                                                 : null,
//                                         lead_id: package.id,
//                                         customerid: widget.customerId,
//                                       ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(bottom: 15),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.grey.shade300),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.1),
//                                 spreadRadius: 2,
//                                 blurRadius: 5,
//                                 offset: const Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "${languageController.isToggled.value ? 'पॅकेज लीड आयडी' : 'Package Lead ID'} : ${package.id}",
//                                     style: const TextStyle(
//                                       fontFamily: 'MyCustomFont',
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                   if (packageController
//                                       .allPackageOrders
//                                       .isNotEmpty)
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 12,
//                                         vertical: 4,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: statusDetails['color'],
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: Text(
//                                         statusDetails['text'],
//                                         style: TextStyle(
//                                           fontFamily: 'MyCustomFont',
//                                           color: statusDetails['textColor'],
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               _buildRow(
//                                 languageController.isToggled.value
//                                     ? "पॅकेज नाव"
//                                     : "Package Name",
//                                 languageController.isToggled.value
//                                     ? package.packageNameInLocalLanguage
//                                     : package.packageName,
//                               ),
//                               const SizedBox(height: 8),
//                               Wrap(
//                                 spacing: 6,
//                                 runSpacing: 6,
//                                 children:
//                                     package.serviceNames.map((service) {
//                                       return Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 8,
//                                           vertical: 2,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: const Color(0xFFF5F4F1),
//                                           borderRadius: BorderRadius.circular(
//                                             5,
//                                           ),
//                                           border: Border.all(
//                                             color: const Color(0xFFE5E7EB),
//                                           ),
//                                         ),
//                                         child: Text(
//                                           languageController.isToggled.value
//                                               ? service
//                                                   .serviceNameInLocalLanguage
//                                               : service.serviceName,
//                                           style: const TextStyle(
//                                             fontFamily: 'MyCustomFont',
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w400,
//                                             color: Color(0xFF757575),
//                                           ),
//                                         ),
//                                       );
//                                     }).toList(),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           color: Color(0xFFFFFFFF),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0x14000000),
//               offset: Offset(2, 0),
//               blurRadius: 25,
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: Obx(
//           () => BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             items: [
//               BottomNavigationBarItem(
//                 icon: const Icon(Icons.home),
//                 label: languageController.isToggled.value ? 'होम' : 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: const Icon(Icons.support_agent_outlined),
//                 label:
//                     languageController.isToggled.value
//                         ? 'ग्राहक सेवा'
//                         : 'Customer Care',
//               ),
//               BottomNavigationBarItem(
//                 icon: const Icon(Icons.edit_document),
//                 label:
//                     languageController.isToggled.value
//                         ? 'माझी ऑर्डर'
//                         : 'My Order',
//               ),
//               BottomNavigationBarItem(
//                 icon: const Icon(Icons.person),
//                 label:
//                     languageController.isToggled.value
//                         ? 'माझे प्रोफाइल'
//                         : 'My Profile',
//               ),
//               BottomNavigationBarItem(
//                 icon: const Icon(Icons.person),
//                 label:
//                     languageController.isToggled.value ? 'पॅकेजेस' : 'Packages',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             selectedItemColor: const Color(0xFFF57C03), // Assuming bordertheme
//             unselectedItemColor: Colors.grey, // Assuming lightgrey
//             onTap: _onItemTapped,
//             showUnselectedLabels: true,
//             showSelectedLabels: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNoDataScreen() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.inbox, size: 80, color: Colors.grey.shade400),
//           const SizedBox(height: 16),
//           Text(
//             languageController.isToggled.value
//                 ? "कोणतेही पॅकेज सापडले नाहीत"
//                 : "No Packages Found",
//             style: const TextStyle(
//               fontFamily: 'MyCustomFont',
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             languageController.isToggled.value
//                 ? "असे दिसते की दाखवण्यासाठी कोणतेही पॅकेज नाहीत."
//                 : "It seems there are no packages to display.",
//             style: const TextStyle(
//               fontFamily: 'MyCustomFont',
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 1.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontFamily: 'MyCustomFont',
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFF36322E),
//               ),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           const Text(
//             ":",
//             style: TextStyle(fontFamily: 'MyCustomFont', fontSize: 16),
//           ),
//           const SizedBox(width: 4),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontFamily: 'MyCustomFont',
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFF36322E),
//               ),
//               softWrap: true,
//               textAlign: TextAlign.left,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
