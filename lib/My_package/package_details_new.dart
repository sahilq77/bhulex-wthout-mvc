import 'dart:io';

import 'package:bhulexapp/My_package/package_order_details.dart' as ServicePackageDetails;
import 'package:bhulexapp/Order/order_list.dart';
import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/controller/package/my_package_controller.dart';
import 'package:bhulexapp/no%20internet.dart';
import 'package:bhulexapp/profile/profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../controller/order/language controller.dart';
import '../customfiles/bottom_navigation_controller.dart';
import '../homepage.dart';

class PackageScreen extends StatefulWidget {
  final String customerId;
  final String package_id;
  final String? tbl_name;
  final String? leadId;
  const PackageScreen({
    Key? key,
    required this.customerId,
    required this.package_id,
    this.tbl_name,
    this.leadId,
    required String customerid,
  }) : super(key: key);

  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final BottomNavigationController navigationController =
      Get.find<BottomNavigationController>();
  final LanguageController languageController = Get.find<LanguageController>();
  final PackageOrderController packageController = Get.put(
    PackageOrderController(),
  );
  final ScrollController _scrollController = ScrollController();
  bool isToggled = false;
  int _selectedIndex = 4;

  @override
  void initState() {
    super.initState();
    _checkAndLoadData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      packageController.refreshPackages(customerId: widget.customerId);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !packageController.isLoadingMore.value) {
        packageController.loadMorePackages(customerId: widget.customerId);
      }
    });
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    print('PackageService opened with leadId: ${widget.leadId}');
  }

  void _showFilterDialog() {
    String? selectedPackageId;

    Get.dialog(
      AlertDialog(
        title: Text(
          languageController.isToggled.value
              ? 'पॅकेज फिल्टर करा'
              : 'Filter Packages',
          style: AppFontStyle.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Obx(
          () =>
              packageController.packageMasterList.isEmpty
                  ? const Text(
                    'No packages available to filter.',
                    style: TextStyle(fontSize: 16),
                  )
                  : DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          labelText:
                              languageController.isToggled.value
                                  ? 'पॅकेज नाव शोधा'
                                  : 'Search Package',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    items:
                        packageController.packageMasterList
                            .where(
                              (pkg) =>
                                  pkg.packageName.isNotEmpty &&
                                  (languageController.isToggled.value
                                      ? pkg
                                          .packageNameInLocalLanguage
                                          .isNotEmpty
                                      : true),
                            )
                            .map(
                              (pkg) =>
                                  languageController.isToggled.value
                                      ? pkg.packageNameInLocalLanguage
                                      : pkg.packageName,
                            )
                            .toSet()
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        final selectedPkg = packageController.packageMasterList
                            .firstWhere(
                              (pkg) =>
                                  (languageController.isToggled.value
                                      ? pkg.packageNameInLocalLanguage
                                      : pkg.packageName) ==
                                  value,
                              orElse:
                                  () => packageController.packageMasterList[0],
                            );
                        selectedPackageId = selectedPkg.id;
                        print(
                          'Selected Package: $value, ID: $selectedPackageId',
                        );
                      } else {
                        selectedPackageId = null;
                      }
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText:
                            languageController.isToggled.value
                                ? 'पॅकेज नाव निवडा'
                                : 'Select Package Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              languageController.isToggled.value ? 'रद्द करा' : 'Cancel',
              style: AppFontStyle.poppins(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              packageController.offset.value = 0;
              packageController.allPackageOrders.clear();
              packageController.fetchPackageOrders(
                customerId: widget.customerId,
                customOffset: 0,
                packageId: selectedPackageId,
                isToggled: languageController.isToggled.value,
              );
              Get.back();
            },
            child: Text(
              languageController.isToggled.value ? 'लागू करा' : 'Apply',
              style: AppFontStyle.poppins(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage2(customer_id: '', customerId: ''),
          ),
        );
        break;
      case 1:
        print("Customer Care tapped");
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => MyOrderScreen(package_id: '', customer_id: ''),
          ),
        );
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    ProfilePage(isToggled: languageController.isToggled.value),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PackageScreen(
                  customerId: '',
                  package_id: '',
                  customerid: '',
                ),
          ),
        );
        break;
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
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
              languageController.isToggled.value ? "पॅकेजेस" : "Package Order",
              style: AppFontStyle2.blinker(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF36322E),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => HomePage2(customer_id: '', customerId: ''),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black),
              onPressed: _showFilterDialog,
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF8F8F8),
        body: RefreshIndicator(
          onRefresh:
              () => packageController.refreshPackages(
                customerId: widget.customerId,
              ),
          child: Obx(
            () =>
                packageController.isLoading.value &&
                        packageController.allPackageOrders.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : packageController.allPackageOrders.isEmpty
                    ? _buildNoDataScreen()
                    : ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      padding: const EdgeInsets.all(20),
                      itemCount:
                          packageController.allPackageOrders.length +
                          (packageController.isLoadingMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index ==
                                packageController.allPackageOrders.length &&
                            packageController.isLoadingMore.value) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final package =
                            packageController.allPackageOrders[index];
                        final statusDetails = getStatusDetails(
                          package.leadStatus,
                          languageController.isToggled.value,
                        );

                        return GestureDetector(
                          onTap: () {
                            int selectedIndex = 0;
                            print(
                              'Navigating to PackageService with customerId: ${widget.customerId}',
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (
                                      context,
                                    ) => ServicePackageDetails.PackageService(
                                      package_lead_id: package.id,
                                      package_Id: package.packageId,
                                      tbl_name:
                                          package.serviceNames.isNotEmpty
                                              ? package
                                                  .serviceNames[selectedIndex]
                                                  .tbl_name
                                              : null,
                                      lead_id: package.id,
                                      customerid: widget.customerId,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${languageController.isToggled.value ? 'पॅकेज लीड आयडी' : 'Package Lead ID'} : ${package.id}",
                                      style: AppFontStyle2.blinker(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                    if (packageController
                                        .allPackageOrders
                                        .isNotEmpty)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              getStatusDetails(
                                                package.leadStatus,
                                                languageController
                                                    .isToggled
                                                    .value,
                                              )['color'],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          getStatusDetails(
                                            package.leadStatus,
                                            languageController.isToggled.value,
                                          )['text'],
                                          style: AppFontStyle2.blinker(
                                            color:
                                                getStatusDetails(
                                                  package.leadStatus,
                                                  languageController
                                                      .isToggled
                                                      .value,
                                                )['textColor'],
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                _buildRow(
                                  languageController.isToggled.value
                                      ? "पॅकेज नाव"
                                      : "Package Name",
                                  languageController.isToggled.value
                                      ? package.packageNameInLocalLanguage
                                      : package.packageName,
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children:
                                      package.serviceNames.map((service) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF5F4F1),
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFE5E7EB),
                                            ),
                                          ),
                                          child: Text(
                                            languageController.isToggled.value
                                                ? service
                                                    .serviceNameInLocalLanguage
                                                : service.serviceName,
                                            style: AppFontStyle2.blinker(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF757575),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                offset: Offset(2, 0),
                blurRadius: 25,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Obx(
            () => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: BottomNavigationStrings.getString(
                    'home',
                    languageController.isToggled.value,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.support_agent_outlined),
                  label: BottomNavigationStrings.getString(
                    'customerCare',
                    languageController.isToggled.value,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.edit_document),
                  label: BottomNavigationStrings.getString(
                    'myOrder',
                    languageController.isToggled.value,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: BottomNavigationStrings.getString(
                    'myProfile',
                    languageController.isToggled.value,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/packageicon.png',
                    width: 21,
                    height: 20,
                  ),
                  label: BottomNavigationStrings.getString(
                    'Package',
                    languageController.isToggled.value,
                  ),
                ),
                // BottomNavigationBarItem(
                //   icon: const Icon(Icons.n),
                //   label: BottomNavigationStrings.getString(
                //     'package',
                //     languageController.isToggled.value,
                //   ),
                // ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colorfile.bordertheme,
              unselectedItemColor: Colorfile.lightgrey,
              onTap: _onItemTapped,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoDataScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            languageController.isToggled.value
                ? "कोणतेही पॅकेज सापडले नाहीत"
                : "No Packages Found",
            style: AppFontStyle2.blinker(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            languageController.isToggled.value
                ? "असे दिसते की दाखवण्यासाठी कोणतेही पॅकेज नाहीत."
                : "It seems there are no packages to display.",
            style: AppFontStyle2.blinker(
              fontSize: 16,
              color: Colors.grey.shade500,
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
              style: AppFontStyle2.blinker(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF36322E),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Text(":", style: AppFontStyle.poppins(fontSize: 16)),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: AppFontStyle2.blinker(
                fontSize: 16,
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
}
