import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bhulexapp/My_package/package_details_new.dart';
import 'package:bhulexapp/Order/order_list.dart';
import 'package:bhulexapp/bottom_navigation/main_bottom_navigation.screen.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:bhulexapp/controller/package/my_package_controller.dart';
import 'package:bhulexapp/investigate_reports_form/mortage_report.dart';
import 'package:bhulexapp/investigate_reports_form/registered_document.dart';
import 'package:bhulexapp/investigate_reports_form/rera%20builder.dart';
import 'package:bhulexapp/language/hindi.dart';
import 'package:bhulexapp/legal_advisory_forms/adhikar_abhilekh.dart';
import 'package:bhulexapp/legal_advisory_forms/courtcases.dart';
import 'package:bhulexapp/legal_advisory_forms/investigate.dart';
import 'package:bhulexapp/legal_advisory_forms/legaldrafts.dart';
import 'package:bhulexapp/old_records_form/old%20extract1.dart';
import 'package:bhulexapp/profile/profile.dart';
import 'package:bhulexapp/quicke_services_forms/digitally_sign1.dart';
import 'package:bhulexapp/quicke_services_forms/digitally_sign_property_card.dart';
import 'package:bhulexapp/quicke_services_forms/indexII_search.dart';
import 'package:bhulexapp/quicke_services_forms/rera_certificate.dart';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'Core/apputility.dart';
import 'Order/all_packages.dart';
import 'Order/package_details.dart';
import 'colors/custom_color.dart';
import 'controller/package/getallpackagecontroller.dart' show PackageController;

import 'network/url.dart';

class HomePage2 extends StatefulWidget {
  final String? package;
  final String customer_id;
  final String? packageid;
  const HomePage2({
    Key? key,
    this.package,
    required this.customer_id,
    this.packageid,
    required String customerId,
  }) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  List<dynamic> categoryList = [];
  String iconPath = '';
  String customerName = '';
  final String customer_id = '';

  bool isLoading = true;
  List<dynamic> customerList = [];
  String? selectedState;
  int _selectedIndex = 0;
  bool isToggled = false; // State variable for language toggle
  bool hasConnection = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
 
  final PackageController packageController = Get.put(PackageController());
  final LanguageController languageController = Get.put(LanguageController());
  final Map<String, String> instantTextMap = {
    'Quick Services': 'instant',
    'Old Records of Rights': 'within12Hours',
    'Legal Advisory': 'within12Hours',
    'Investigative Reports': 'within24Hours',
    'E-Applications': 'within12Hours',
  };

  @override
  void initState() {
    super.initState();
    _loadToggleState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initConnectivity();
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isToggled = prefs.getBool('isToggled') ?? false;
      languageController.isToggled.value = isToggled;
    });
    fetchCategories();
  }

  Future<void> _saveToggleState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isToggled', value);
    setState(() {
      isToggled = value;
      languageController.isToggled.value = value;
    });
  }

  void _initConnectivity() {
    _checkConnectivity().then((isConnected) {
      if (!mounted) return;
      setState(() {
        hasConnection = isConnected;
      });
      if (isConnected) {
        fetchCategories();
      }
    });

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _checkConnectivity().then((isConnected) {
        if (!mounted) return;
        if (isConnected != hasConnection) {
          setState(() {
            hasConnection = isConnected;
          });
          if (isConnected) {
            fetchCategories();
          }
        }
      });
    });
  }

  Future<bool> _checkConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      bool isConnected = !connectivityResult.contains(ConnectivityResult.none);
      if (isConnected) {
        isConnected = await _hasInternet();
      }
      return isConnected;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  void _showNoInternetPopup() {
    if (!mounted) return;
    _scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          languageController.isToggled.value
              ? 'इंटरनेट कनेक्शन नाही'
              : 'No Internet Connection',
          style: AppFontStyle2.blinker(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: languageController.isToggled.value
              ? 'पुन्हा प्रयत्न'
              : 'Retry',
          textColor: Colors.white,
          onPressed: () async {
            bool isConnected = await _checkConnectivity();
            if (!mounted) return;
            setState(() {
              hasConnection = isConnected;
            });
            if (isConnected) {
              fetchCategories();
            } else {
              _showNoInternetPopup();
            }
          },
        ),
      ),
    );
  }

  Future<void> fetchCategories() async {
    if (!hasConnection) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? customerId = prefs.getString('customer_id');
    var requestBody = {
      "customer_id": customerId,
      "lang": languageController.isToggled.value ? 'mr' : 'en',
    };

    final String url = URLS().get_all_category_apiUrl;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        log("API Response: ${response.body}");
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          categoryList = responseData['data'] ?? [];
          iconPath = responseData['icon_path'] ?? '';
          isLoading = false;
        });
      } else {
        print(
          "Error: Server responded with status code ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _onRefresh() async {
    if (!hasConnection) {
      _showNoInternetPopup();
      return;
    }
    await fetchCategories();
    await Get.find<PackageOrderController>().fetchPackageOrders(
      customerId: widget.customer_id, // Assuming HomePage2 has customerId
      customOffset: 0,
      isToggled: Get.find<LanguageController>().isToggled.value,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        print("Home tapped");
        break;
      case 1:
        print("Customer Care tapped");
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MyOrderScreen(package_id: '', customer_id: ''),
          ),
        );
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProfilePage(isToggled: languageController.isToggled.value),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PackageScreen(customerId: '', package_id: '', customerid: ''),
          ),
        );

        break;
    }
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Obx(
              () => Text(
                languageController.isToggled.value
                    ? 'साठवलेला डेटा नष्ट होईल'
                    : 'Unsaved Data Will Be Lost',
                style: AppFontStyle2.blinker(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            content: Obx(
              () => Text(
                languageController.isToggled.value
                    ? 'आपण खात्रीने बाहेर पडू इच्छिता?'
                    : 'Are you sure you want to exit?',
                style: AppFontStyle2.blinker(fontSize: 16),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Obx(
                  () => Text(
                    languageController.isToggled.value ? 'रद्द करा' : 'Cancel',
                    style: AppFontStyle2.blinker(color: Colors.grey),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Obx(
                  () => Text(
                    languageController.isToggled.value ? 'होय' : 'Yes',
                    style: AppFontStyle2.blinker(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // If not on Home tab (index 0), switch to Home instead of exiting
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false; // Prevent exit
        }

        // If on Home tab, show exit confirmation dialog
        return await _showExitDialog(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colorfile.body,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset('assets/images/bhulex.png', height: 40),
          ),
          shape: Border(
            bottom: BorderSide(color: Colorfile.border, width: 1.0),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0),
              child: Row(
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(
                          () => CupertinoSwitch(
                            value: languageController.isToggled.value,
                            onChanged: (bool newValue) {
                              languageController.toggleLanguage(newValue);
                              setState(() {
                                fetchCategories();
                              });
                            },
                            activeColor: Colorfile.bordertheme,
                          ),
                        ),
                        Obx(
                          () => !languageController.isToggled.value
                              ? Positioned(
                                  right: 10,
                                  child: Text(
                                    'अ',
                                    style: AppFontStyle2.blinker(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colorfile.lightblack,
                                    ),
                                  ),
                                )
                              : Positioned(
                                  left: 10,
                                  child: Text(
                                    'A',
                                    style: AppFontStyle2.blinker(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colorfile.lightblack,
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colorfile.lightblack,
                ),
                onPressed: () {
                  print('Search icon pressed');
                },
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: isLoading
              ? ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(height: 150, color: Colors.white),
                      ),
                    );
                  },
                )
              : !hasConnection
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.cancel, color: Colors.red, size: 20),
                              SizedBox(width: 8),
                              Text(
                                languageController.isToggled.value
                                    ? 'इंटरनेट नाही'
                                    : 'No Internet',
                                style: AppFontStyle2.blinker(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Obx(
                          () => Text(
                            languageController.isToggled.value
                                ? 'कोणताही डेटा उपलब्ध नाही'
                                : 'No data available',
                            style: AppFontStyle2.blinker(
                              fontSize: 16,
                              color: Colorfile.lightblack,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...categoryList.map((category) {
                        var services = category['service'] ?? [];
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () => Text(
                                      languageController.isToggled.value
                                          ? (category['category_name_in_local_language'] ??
                                                category['category_name'] ??
                                                '')
                                          : (category['category_name'] ?? ''),
                                      style: AppFontStyle2.blinker(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      LocalizationStringsinstant.getString(
                                        instantTextMap[category['category_name']] ??
                                            '',
                                        languageController.isToggled.value,
                                      ),
                                      style: AppFontStyle2.blinker(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colorfile.lightgrey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: services.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1.4,
                                    ),
                                itemBuilder: (context, serviceIndex) {
                                  var service = services[serviceIndex];
                                  String serviceIcon = service['icon'] != null
                                      ? iconPath + service['icon']
                                      : '';
                                  return Obx(() {
                                    String displayName =
                                        languageController.isToggled.value
                                        ? (service['service_name_in_local_language'] ??
                                              service['service_name'] ??
                                              '')
                                        : (service['service_name'] ?? '');
                                    return InkWell(
                                      onTap: () {
                                        var selectedService =
                                            services[serviceIndex];
                                        final id = selectedService['id']
                                            .toString();
                                        final serviceName =
                                            selectedService['service_name'] ??
                                            '';
                                        final tblName =
                                            selectedService['tbl_name'] ?? '';
                                        if ([
                                          "tbl_seven_twelve",
                                          "tbl_eighta_extract",
                                          "tbl_e_mutation_extract",
                                          "tbl_bhu_naksha",
                                        ].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DigitallySign1(
                                                id: id,
                                                packageId: "",
                                                serviceName: serviceName,

                                                tblName: tblName,
                                                isToggled: languageController
                                                    .isToggled
                                                    .value,
                                                serviceNameInLocalLanguage:
                                                    selectedService['service_name_in_local_language'] ??
                                                    serviceName,
                                                lead_id: '',
                                                customer_id: '',
                                                package_lead_id: '',

                                                // packageId: null,
                                              ),
                                            ),
                                          );
                                        } else if ([
                                          "tbl_index_second_search",
                                        ].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => IndexSearch1(
                                                id: id,
                                                packageId: "",
                                                serviceName: serviceName,
                                                tblName: tblName,
                                                isToggled: languageController
                                                    .isToggled
                                                    .value,
                                                serviceNameInLocalLanguage:
                                                    selectedService['service_name_in_local_language'] ??
                                                    serviceName,
                                                lead_id: '',
                                                customer_id: widget.customer_id,
                                                package_lead_id: '',
                                              ),
                                            ),
                                          );
                                        } else if ([
                                          "tbl_rera_certificate",
                                        ].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ReraCertificate(
                                                id: id,
                                                packageId: "",
                                                serviceName: serviceName,
                                                tblName: tblName,
                                                isToggled: languageController
                                                    .isToggled
                                                    .value,
                                                serviceNameInLocalLanguage:
                                                    selectedService['service_name_in_local_language'] ??
                                                    serviceName,
                                                lead_id: '',
                                                customer_id: '',
                                                package_lead_id: '',
                                              ),
                                            ),
                                          );
                                        } else if ([
                                          "tbl_property_card",
                                        ].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => propertyCard(
                                                id: id,
                                                packageId: "",
                                                serviceName: serviceName,
                                                tblName: tblName,
                                                isToggled: languageController
                                                    .isToggled
                                                    .value,
                                                serviceNameInLocalLanguage:
                                                    selectedService['service_name_in_local_language'] ??
                                                    serviceName,
                                                package_lead_id: '',
                                                lead_id: '',
                                                customer_id: '',
                                              ),
                                            ),
                                          );
                                        } else if ([
                                          "tbl_old_seven_twelve",
                                          "tbl_old_eighta_extract",
                                          "tbl_old_e_mutation_extract",
                                          "tbl_old_bhu_naksha",
                                        ].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => oldextract1(
                                                id: id,
                                                packageId: "",
                                                serviceName: serviceName,
                                                tblName: tblName,
                                                isToggled: languageController
                                                    .isToggled
                                                    .value,
                                                serviceNameInLocalLanguage:
                                                    selectedService['service_name_in_local_language'] ??
                                                    serviceName,
                                                lead_id: '',
                                                customer_id: '',
                                                package_lead_id: '',
                                              ),
                                            ),
                                          );
                                        } else if ([
                                          "tbl_mortage_report",
                                          "tbl_ceersai_report",
                                        ].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MortgageReports(
                                                id: id,
                                                packageId: "",
                                                serviceName: serviceName,
                                                tblName: tblName,
                                                isToggled: languageController
                                                    .isToggled
                                                    .value,
                                                serviceNameInLocalLanguage:
                                                    selectedService['service_name_in_local_language'] ??
                                                    serviceName,
                                                lead_id: '',
                                                customer_id: '',
                                                package_lead_id: '',
                                              ),
                                            ),
                                          );
                                        } else if ([
                                          "tbl_rera_builder_documents",
                                        ].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => RERA_Builder(
                                                id: id,
                                                packageId: "",
                                                serviceName: serviceName,
                                                tblName: tblName,
                                                isToggled: languageController
                                                    .isToggled
                                                    .value,
                                                serviceNameInLocalLanguage:
                                                    selectedService['service_name_in_local_language'] ??
                                                    serviceName,
                                                customer_id: '',
                                                lead_id: '',
                                                package_lead_id: '',
                                              ),
                                            ),
                                          );
                                        } else if ([
                                          "tbl_registered_document",
                                        ].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisteredDocument(
                                                    id: id,
                                                    packageId: "",
                                                    serviceName: serviceName,
                                                    tblName: tblName,
                                                    isToggled:
                                                        languageController
                                                            .isToggled
                                                            .value,
                                                    serviceNameInLocalLanguage:
                                                        selectedService['service_name_in_local_language'] ??
                                                        serviceName,
                                                    lead_id: '',
                                                    customer_id: '',
                                                    package_lead_id: '',
                                                  ),
                                            ),
                                          );
                                        } else if ([
                                          "tbl_title_investigation_report",
                                        ].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Investigation(
                                                id: id,
                                                packageId: "",

                                                serviceName: serviceName,
                                                tblName: tblName,
                                                isToggled: languageController
                                                    .isToggled
                                                    .value,
                                                serviceNameInLocalLanguage:
                                                    selectedService['service_name_in_local_language'] ??
                                                    serviceName,
                                                customer_id: '',
                                                lead_id: '',
                                                package_lead_id: '',
                                              ),
                                            ),
                                          );
                                        } else if ([
                                          "tbl_legal_drafts",
                                        ].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Legaldrafts(
                                                id: id,
                                                packageId: "",

                                                serviceName: serviceName,
                                                tblName: tblName,
                                                isToggled: languageController
                                                    .isToggled
                                                    .value,
                                                serviceNameInLocalLanguage:
                                                    selectedService['service_name_in_local_language'] ??
                                                    serviceName,
                                                lead_id: '',
                                                customer_id: '',
                                                package_lead_id: '',
                                              ),
                                            ),
                                          );
                                        } else if (["tbl_court_cases"].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Courtcases(
                                                id: id,
                                                packageId: "",

                                                serviceName: serviceName,
                                                tblName: tblName,
                                                isToggled: languageController
                                                    .isToggled
                                                    .value,
                                                serviceNameInLocalLanguage:
                                                    selectedService['service_name_in_local_language'] ??
                                                    serviceName,
                                                lead_id: '',
                                                customer_id: '',
                                                package_lead_id: '',
                                              ),
                                            ),
                                          );
                                        } else if (["tbl_adhikar_abhilekh"].contains(tblName)) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Adhikar_Abhilekh(
                                                    id: id,
                                                    packageId: "",

                                                    serviceName: serviceName,
                                                    tblName: tblName,
                                                    isToggled:
                                                        languageController
                                                            .isToggled
                                                            .value,
                                                    serviceNameInLocalLanguage:
                                                        selectedService['service_name_in_local_language'] ??
                                                        serviceName,
                                                    lead_id: '',
                                                    customerid: customer_id,
                                                    package_lead_id: '',
                                                  ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Obx(
                                                () => Text(
                                                  languageController
                                                          .isToggled
                                                          .value
                                                      ? "या निवडीसाठी सेवा उपलब्ध नाही."
                                                      : "Service not available for this selection.",
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          serviceIcon.isNotEmpty
                                              ? Image.network(
                                                  serviceIcon,
                                                  height: 25,
                                                  width: 25,
                                                  fit: BoxFit.contain,
                                                  errorBuilder: (ctx, _, __) =>
                                                      const Icon(
                                                        Icons.broken_image,
                                                        size: 25,
                                                      ),
                                                )
                                              : const Icon(
                                                  Icons.miscellaneous_services,
                                                  size: 30,
                                                ),
                                          const SizedBox(height: 5),
                                          Text(
                                            displayName,
                                            style: AppFontStyle2.blinker(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colorfile.lightblack,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 18,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                languageController.isToggled.value
                                    ? 'पॅकेजेस'
                                    : 'Packages',
                                style: AppFontStyle2.blinker(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colorfile.lightblack,
                                ),
                              ),
                            ),
                            Obx(
                              () => TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllPackagesPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  languageController.isToggled.value
                                      ? 'सर्व पहा'
                                      : 'View All',
                                  style: AppFontStyle2.blinker(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colorfile.bordertheme,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => packageController.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 20,
                                  bottom: 15,
                                ),
                                child: SizedBox(
                                  // Responsive height: 25% of screen height, capped at 200 for smaller screens
                                  height:
                                      MediaQuery.of(context).size.height *
                                              0.25 >
                                          200
                                      ? 200
                                      : MediaQuery.of(context).size.height *
                                            0.25,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        packageController.allPackages.length +
                                        (packageController.isLoadingMore.value
                                            ? 1
                                            : 0),
                                    itemBuilder: (context, index) {
                                      if (index ==
                                              packageController
                                                  .allPackages
                                                  .length &&
                                          packageController
                                              .isLoadingMore
                                              .value) {
                                        return const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }

                                      final package =
                                          packageController.allPackages[index];
                                      if (package.packages.isEmpty) {
                                        return const SizedBox.shrink(); // Skip empty packages
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PackageDetailsPage(
                                                      package_id: package
                                                          .packages
                                                          .first
                                                          .id,
                                                      customer_id:
                                                          AppUtility.login_id,
                                                      isToggled: isToggled,
                                                      lead_id: '',
                                                    ),
                                              ),
                                            );
                                            print(
                                              "Tapped on: ${package.packages.first.packageName}",
                                            );
                                          },
                                          child: Container(
                                            // Responsive width: 80% of screen width or fixed 290, whichever is smaller
                                            width:
                                                MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        0.8 >
                                                    290
                                                ? 290
                                                : MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.8,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFFDFE6F8),
                                                width: 0.5,
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: SingleChildScrollView(
                                              // Added SingleChildScrollView
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            50,
                                                          ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            packageController
                                                                .baseUrl
                                                                .value +
                                                            (package
                                                                    .packages
                                                                    .first
                                                                    .icon ??
                                                                ''),
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) =>
                                                                const CircularProgressIndicator(),
                                                        errorWidget:
                                                            (
                                                              context,
                                                              url,
                                                              error,
                                                            ) => Image.asset(
                                                              'assets/images/package1.png',
                                                              width: 40,
                                                              height: 40,
                                                              fit: BoxFit.cover,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          5.0,
                                                        ),
                                                    child: Obx(
                                                      () => Text(
                                                        languageController
                                                                .isToggled
                                                                .value
                                                            ? (package
                                                                          .packages
                                                                          .first
                                                                          .packageNameInLocalLanguage
                                                                          ?.isNotEmpty ??
                                                                      false
                                                                  ? package
                                                                        .packages
                                                                        .first
                                                                        .packageNameInLocalLanguage!
                                                                  : PackageStrings.getPackageName(
                                                                      package
                                                                          .packages
                                                                          .first
                                                                          .packageName,
                                                                      true,
                                                                    ))
                                                            : package
                                                                  .packages
                                                                  .first
                                                                  .packageName,
                                                        style:
                                                            AppFontStyle2.blinker(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                0xFF353B43,
                                                              ),
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 1),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8.0,
                                                        ),
                                                    child: Obx(
                                                      () => Text(
                                                        languageController
                                                                .isToggled
                                                                .value
                                                            ? (package
                                                                          .packages
                                                                          .first
                                                                          .shortDescriptionInLocalLanguage
                                                                          ?.isNotEmpty ??
                                                                      false
                                                                  ? package
                                                                        .packages
                                                                        .first
                                                                        .shortDescriptionInLocalLanguage!
                                                                  : PackageStrings.getShortDescription(
                                                                      package
                                                                          .packages
                                                                          .first
                                                                          .shortDescription,
                                                                      true,
                                                                    ))
                                                            : package
                                                                  .packages
                                                                  .first
                                                                  .shortDescription,
                                                        style:
                                                            AppFontStyle2.blinker(
                                                              fontSize: 9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                0xFF4B5563,
                                                              ),
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Wrap(
                                                    spacing: 6,
                                                    runSpacing: 6,
                                                    children:
                                                        (package
                                                                    .packages
                                                                    .first
                                                                    .serviceNames ??
                                                                '')
                                                            .split(',')
                                                            .map((serviceName) {
                                                              return Obx(() {
                                                                String
                                                                serviceNameText =
                                                                    languageController
                                                                        .isToggled
                                                                        .value
                                                                    ? ((package.packages.first.serviceNamesLocal?.isNotEmpty ??
                                                                                  false) &&
                                                                              package.packages.first.serviceNamesLocal!
                                                                                      .split(
                                                                                        ',',
                                                                                      )
                                                                                      .length >
                                                                                  (package.packages.first.serviceNames ??
                                                                                          '')
                                                                                      .split(
                                                                                        ',',
                                                                                      )
                                                                                      .indexOf(
                                                                                        serviceName,
                                                                                      )
                                                                          ? package.packages.first.serviceNamesLocal!
                                                                                .split(
                                                                                  ',',
                                                                                )[(package.packages.first.serviceNames ??
                                                                                        '')
                                                                                    .split(
                                                                                      ',',
                                                                                    )
                                                                                    .indexOf(
                                                                                      serviceName,
                                                                                    )]
                                                                                .trim()
                                                                          : allPackageStrings.getServiceName(
                                                                              serviceName.trim(),
                                                                              true,
                                                                            ))
                                                                    : allPackageStrings.getServiceName(
                                                                        serviceName
                                                                            .trim(),
                                                                        false,
                                                                      );

                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets.only(
                                                                        left:
                                                                            7.0,
                                                                      ),
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          4,
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                      color: const Color(
                                                                        0xFFF5F4F1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            5,
                                                                          ),
                                                                      border: Border.all(
                                                                        color: const Color(
                                                                          0xFFE5E7EB,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      serviceNameText,
                                                                      style: AppFontStyle2.blinker(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: const Color(
                                                                          0xFF757575,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                            })
                                                            .toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: CustomBottomBar(),
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withOpacity(0.08),
        //         blurRadius: 25,
        //         offset: const Offset(0, -2),
        //       ),
        //     ],
        //   ),
        //   child: Obx(
        //     () => BottomNavigationBar(
        //       type: BottomNavigationBarType.fixed,
        //       currentIndex: _selectedIndex,
        //       backgroundColor: Colors.white,
        //       elevation: 0,
        //       selectedItemColor: Colorfile.bordertheme,
        //       unselectedItemColor: Colorfile.lightgrey,
        //       selectedFontSize: 12,
        //       unselectedFontSize: 11,
        //       showSelectedLabels: true,
        //       showUnselectedLabels: true,
        //       onTap: (index) {
        //         if (_selectedIndex == index)
        //           return; // Prevent re-tapping same tab

        //         setState(() => _selectedIndex = index);

        //         switch (index) {
        //           case 0: // Home
        //             // Already on Home
        //             break;

        //           case 1: // Support / Customer Care
        //             ScaffoldMessenger.of(context).showSnackBar(
        //               SnackBar(
        //                 backgroundColor: Colorfile.bordertheme,
        //                 content: Text(
        //                   languageController.isToggled.value
        //                       ? "ग्राहक सेवा लवकरच उपलब्ध होईल"
        //                       : "Customer Support coming soon",
        //                   style: const TextStyle(color: Colors.white),
        //                 ),
        //                 duration: const Duration(seconds: 2),
        //               ),
        //             );
        //             break;

        //           case 2: // My Orders
        //             Navigator.pushReplacement(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (_) => MyOrderScreen(
        //                   package_id: '',
        //                   customer_id: widget.customer_id,
        //                 ),
        //               ),
        //             );
        //             break;

        //           case 3: // Profile
        //             Navigator.pushReplacement(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (_) => ProfilePage(
        //                   isToggled: languageController.isToggled.value,
        //                 ),
        //               ),
        //             );
        //             break;
        //         }
        //       },
        //       items:
        //           const [
        //             BottomNavigationBarItem(
        //               icon: Icon(Icons.home_outlined),
        //               activeIcon: Icon(Icons.home),
        //               label: 'Home', // Will be auto-translated below
        //             ),
        //             BottomNavigationBarItem(
        //               icon: Icon(Icons.headset_mic_outlined),
        //               activeIcon: Icon(Icons.headset_mic),
        //               label: 'Support',
        //             ),
        //             BottomNavigationBarItem(
        //               icon: Icon(Icons.receipt_long_outlined),
        //               activeIcon: Icon(Icons.receipt_long),
        //               label: 'My Orders',
        //             ),
        //             BottomNavigationBarItem(
        //               icon: Icon(Icons.person_outline),
        //               activeIcon: Icon(Icons.person),
        //               label: 'Profile',
        //             ),
        //           ].asMap().entries.map((entry) {
        //             int idx = entry.key;
        //             var item = entry.value;
        //             return BottomNavigationBarItem(
        //               icon: item.icon!,
        //               activeIcon: item.activeIcon!,
        //               label: BottomNavigationStrings.getString(
        //                 ['home', 'support', 'myOrder', 'myProfile'][idx],
        //                 languageController.isToggled.value,
        //               ),
        //             );
        //           }).toList(),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

// LocalizationStringsinstant class
class LocalizationStringsinstant {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'instant': {'en': 'Instant', 'local': 'तात्काळ'},
      'within12Hours': {'en': 'Within 12 Hours', 'local': '१२ तासांत'},
      'within24Hours': {'en': 'Within 24 Hours', 'local': '२४ तासांत'},
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ?? key;
  }
}

// lib/language/bottom_navigation_strings.dart
class BottomNavigationStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'home': {'en': 'Home', 'local': 'होम'},
      'customerCare': {'en': 'Customer Care', 'local': 'ग्राहक सेवा'},
      'myOrder': {'en': 'My Order', 'local': 'माझी ऑर्डर'},

      'packages': {'en': 'Packages', 'local': 'पॅकेजेस'},
      'myProfile': {'en': 'My Profile', 'local': 'माझे प्रोफाइल'},
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ?? key;
  }
}

// lib/language/package_strings.dart
class PackageStrings {
  static String getPackageName(String packageName, bool isToggled) {
    final Map<String, Map<String, String>> packageTranslations = {
      'package1': {'en': 'package1', 'local': 'पॅकेज १'},
      'Basic Package': {'en': 'Basic Package', 'local': 'मूलभूत पॅकेज'},
      'Premium Package': {'en': 'Premium Package', 'local': 'प्रिमियम पॅकेज'},
    };

    final language = isToggled ? 'local' : 'en';
    return packageTranslations[packageName]?[language] ?? packageName;
  }

  static String getShortDescription(String description, bool isToggled) {
    final Map<String, Map<String, String>> descriptionTranslations = {
      'package': {'en': 'package', 'local': 'पॅकेज'},
      'Includes basic services': {
        'en': 'Includes basic services',
        'local': 'मूलभूत सेवा समाविष्ट करते',
      },
      'Comprehensive package with additional benefits': {
        'en': 'Comprehensive package with additional benefits',
        'local': 'अतिरिक्त लाभांसह व्यापक पॅकेज',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return descriptionTranslations[description]?[language] ?? description;
  }

  static String getTag(String tag, bool isToggled) {
    final Map<String, Map<String, String>> tagTranslations = {
      'doc2': {'en': 'doc2', 'local': 'दस्तऐवज २'},
      'Aadhar Card': {'en': 'Aadhar Card', 'local': 'आधार कार्ड'},
      'PAN Card': {'en': 'PAN Card', 'local': 'पॅन कार्ड'},
      'Property Documents': {
        'en': 'Property Documents',
        'local': 'मालमत्ता दस्तऐवज',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return tagTranslations[tag]?[language] ?? tag;
  }
}
