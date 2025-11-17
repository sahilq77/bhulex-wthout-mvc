import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bhulexapp/E-Applications/aapli_chawadi_page.dart';
import 'package:bhulexapp/E-Applications/area_converter_page.dart';
import 'package:bhulexapp/E-Applications/e_property_valuation_page.dart';
import 'package:bhulexapp/bottom_navigation/main_bottom_navigation.screen.dart';
import 'package:bhulexapp/controller/bottom_navigation/bottom_navigation_controller.dart';
import 'package:bhulexapp/controller/global_controller/global_controller.dart';
import 'package:bhulexapp/investigate_reports_form/cersai_report.dart';
import 'package:bhulexapp/old_records_form/old_revenue_records.dart';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'Core/apputility.dart';
import 'My_package/package_details_new.dart';
import 'Order/all_packages.dart';
import 'Order/order_list.dart';
import 'Order/package_details.dart';
import 'colors/custom_color.dart';
import 'colors/order_fonts.dart';
import 'controller/order/language controller.dart';
import 'controller/package/getallpackagecontroller.dart' show PackageController;
import 'controller/package/my_package_controller.dart';
import 'investigate_reports_form/mortage_report.dart';
import 'investigate_reports_form/registered_document.dart';
import 'investigate_reports_form/rera builder.dart';
import 'language/hindi.dart';
import 'legal_advisory_forms/adhikar_abhilekh.dart';
import 'legal_advisory_forms/courtcases.dart';
import 'legal_advisory_forms/investigate.dart';
import 'legal_advisory_forms/legal_drafts_new.dart';
import 'legal_advisory_forms/legaldrafts.dart';
import 'network/url.dart';
import 'profile/profile.dart';
import 'quicke_services_forms/digitally_sign1.dart';
import 'quicke_services_forms/digitally_sign_property_card.dart';
import 'quicke_services_forms/indexII_search.dart';
import 'quicke_services_forms/rera_certificate.dart';
import 'package:carousel_slider/carousel_slider.dart'; // ADD THIS

class HomePage2 extends StatefulWidget {
  final String? package;
  final String customer_id;
  final String? packageid;
  const HomePage2({
    super.key,
    this.package,
    required this.customer_id,
    this.packageid,
    required String customerId,
  });

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
  bool isToggled = false;
  bool hasConnection = true;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final BottomNavigationController controller =
      Get.find<BottomNavigationController>();
  final PackageController packageController = Get.put(PackageController());
  final LanguageController languageController = Get.put(LanguageController());
  final StateController stateController = Get.put(StateController());

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
  }

  Future<bool> _checkConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      bool isConnected = connectivityResult != ConnectivityResult.none;
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
      ).timeout(const Duration(seconds: 5));
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
        duration: const Duration(seconds: 3),
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
    print("Request URL: $url");
    print("Request Body: ${jsonEncode(requestBody)}");
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(requestBody),
      );
      print("Response Status Code: ${response.statusCode}");
      log("Response Body of category: ${response.body}");
      if (response.statusCode == 200) {
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
      customerId: widget.customer_id,
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
            builder: (context) => const PackageScreen(
              customerId: '',
              package_id: '',
              customerid: '',
            ),
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
      onWillPop: () async => await _showExitDialog(context),
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
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.grey.withOpacity(0.3),
                highlightColor: Colors.grey.withOpacity(0.1),
                onTap: () {
                  print('Search icon pressed');
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colorfile.lightblack,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.grey.withOpacity(0.3),
                highlightColor: Colors.grey.withOpacity(0.1),
                onTap: () {
                  print('Bell icon pressed');
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/images/bell-icon.svg',
                    width: 25,
                    height: 25,
                    color: Colorfile.lightblack,
                  ),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: Container(color: Colorfile.border, height: 1),
          ),
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
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          padding: const EdgeInsets.symmetric(
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
                              const Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
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
                        const SizedBox(height: 16),
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
                      // State Dropdown
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          languageController.isToggled.value
                              ? 'राज्य निवडा'
                              : 'Select State',
                          style: AppFontStyle2.blinker(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Obx(
                          () => stateController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : Obx(() {
                                  final isSelected = stateController
                                      .selectedStateName
                                      .value
                                      .isNotEmpty;
                                  final borderColor = isSelected
                                      ? Color(0xFFF26500)
                                      : Color(0xFFD9D9D9);
                                  return DropdownSearch<String>(
                                    items: stateController.states
                                        .map((state) => state.stateName)
                                        .toList(),
                                    selectedItem: isSelected
                                        ? stateController
                                              .selectedStateName
                                              .value
                                        : null,
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                labelText:
                                                    languageController
                                                        .isToggled
                                                        .value
                                                    ? 'राज्य निवडा'
                                                    : 'Select State',
                                                labelStyle:
                                                    AppFontStyle2.blinker(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 14,
                                                    ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  borderSide: BorderSide(
                                                    color: borderColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: borderColor,
                                                        width: 1,
                                                      ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: borderColor,
                                                        width: 1,
                                                      ),
                                                    ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: borderColor,
                                                        width: 1,
                                                      ),
                                                    ),
                                              ),
                                        ),
                                    popupProps: const PopupProps.menu(
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                          hintText: 'Search State...',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      stateController.setSelectedState(value);
                                    },
                                  );
                                }),
                        ),
                      ),

                      // Categories
                      ...categoryList.map((category) {
                        var services = category['service'] ?? [];
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Obx(
                                      () => Text(
                                        languageController.isToggled.value
                                            ? (category['category_name_in_local_language'] ??
                                                  category['category_name'] ??
                                                  '')
                                            : (category['category_name'] ?? ''),
                                        style: AppFontStyle2.blinker(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Container(
                                          height: 1,
                                          color: const Color(0xFF757575),
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
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colorfile.lightgrey,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
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
                                        // [Your existing navigation logic]
                                        // ... (unchanged)
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
                                              fontSize: 9,
                                              fontWeight: FontWeight.w600,
                                              height: 12 / 9,
                                              color: Colorfile.servicename,
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
                      }),

                      // Dummy E-Applications
                      // ... (unchanged)

                      // ==================== PACKAGES CAROUSEL ====================
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
                                  fontWeight: FontWeight.w600,
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

                      // CAROUSEL SLIDER
                      Obx(
                        () => packageController.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                                children: [
                                  CarouselSlider.builder(
                                    itemCount:
                                        packageController.allPackages.length,
                                    options: CarouselOptions(
                                      height:
                                          MediaQuery.of(context).size.height *
                                                  0.25 >
                                              150
                                          ? 150
                                          : MediaQuery.of(context).size.height *
                                                0.25,
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      viewportFraction: 0.85,
                                      aspectRatio: 16 / 9,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      autoPlayInterval: const Duration(
                                        seconds: 4,
                                      ),
                                      autoPlayAnimationDuration: const Duration(
                                        milliseconds: 800,
                                      ),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      pauseAutoPlayOnTouch: true,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, reason) {
                                        packageController
                                                .currentCarouselIndex
                                                .value =
                                            index;
                                      },
                                    ),
                                    itemBuilder: (context, index, realIndex) {
                                      final package =
                                          packageController.allPackages[index];
                                      if (package.packages.isEmpty) {
                                        return const SizedBox.shrink();
                                      }
                                      return GestureDetector(
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
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          // margin: const EdgeInsets.symmetric(
                                          //   horizontal: 8,
                                          // ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: Colorfile.primaryColor,
                                              width: 0.5,
                                            ),
                                            color: const Color(0xFFFFF3E0),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            12,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFFFFF3E0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
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
                                                          placeholder: (_, __) =>
                                                              const CircularProgressIndicator(),
                                                          errorWidget:
                                                              (
                                                                _,
                                                                __,
                                                                ___,
                                                              ) => Image.asset(
                                                                'assets/images/package1.png',
                                                                width: 40,
                                                                height: 40,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Obx(
                                                            () => Text(
                                                              languageController
                                                                      .isToggled
                                                                      .value
                                                                  ? (package
                                                                            .packages
                                                                            .first
                                                                            .packageNameInLocalLanguage
                                                                            .isNotEmpty
                                                                        ? package
                                                                              .packages
                                                                              .first
                                                                              .packageNameInLocalLanguage
                                                                        : PackageStrings.getPackageName(
                                                                            package.packages.first.packageName,
                                                                            true,
                                                                          ))
                                                                  : package
                                                                        .packages
                                                                        .first
                                                                        .packageName,
                                                              style: AppFontStyle2.blinker(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    const Color(
                                                                      0xFF353B43,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Obx(
                                                            () => Text(
                                                              languageController
                                                                      .isToggled
                                                                      .value
                                                                  ? (package
                                                                            .packages
                                                                            .first
                                                                            .shortDescriptionInLocalLanguage
                                                                            .isNotEmpty
                                                                        ? package
                                                                              .packages
                                                                              .first
                                                                              .shortDescriptionInLocalLanguage
                                                                        : PackageStrings.getShortDescription(
                                                                            package.packages.first.shortDescription,
                                                                            true,
                                                                          ))
                                                                  : package
                                                                        .packages
                                                                        .first
                                                                        .shortDescription,
                                                              style: AppFontStyle2.blinker(
                                                                fontSize: 9,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    const Color(
                                                                      0xFF4B5563,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 7,
                                                      ),
                                                  child: Wrap(
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
                                                                    ? ((package.packages.first.serviceNamesLocal.isNotEmpty) &&
                                                                              package.packages.first.serviceNamesLocal
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
                                                                          ? package.packages.first.serviceNamesLocal
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
                                                                return Container(
                                                                  padding:
                                                                      const EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4,
                                                                      ),
                                                                  decoration: BoxDecoration(
                                                                    color: Colorfile
                                                                        .primaryColor
                                                                        .withOpacity(
                                                                          0.2,
                                                                        ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          5,
                                                                        ),
                                                                  ),
                                                                  child: Text(
                                                                    serviceNameText,
                                                                    style: AppFontStyle2.blinker(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: const Color(
                                                                        0xFF757575,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                            })
                                                            .toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  // DOT INDICATORS
                                  const SizedBox(height: 12),
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: packageController.allPackages
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                            return GestureDetector(
                                              onTap: () {
                                                // Optional: jump to page
                                              },
                                              child: Container(
                                                width: 8,
                                                height: 8,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colorfile.bordertheme
                                                      .withOpacity(
                                                        entry.key ==
                                                                packageController
                                                                    .currentCarouselIndex
                                                                    .value
                                                            ? 1
                                                            : 0.4,
                                                      ),
                                                ),
                                              ),
                                            );
                                          })
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}

final Map<String, dynamic> dummyCategory = {
  "category_name": "E-Applications",
  "category_name_in_local_language": "मालमत्ता सेवा",
  "service": [
    {
      "id": "1",
      "service_name": "E-Property Valuation",
      "service_name_in_local_language": "ई-मालमत्ता मूल्यांकन",
      "icon": "assets/images/valuation.png",
      "tbl_name": "tbl_e_property_valuation",
    },
    {
      "id": "2",
      "service_name": "Aapli Chawadi",
      "service_name_in_local_language": "आपली चावडी",
      "icon": "assets/images/chawadi.png",
      "tbl_name": "tbl_aapli_chawadi",
    },
    {
      "id": "3",
      "service_name": "Area Converter",
      "service_name_in_local_language": "क्षेत्र परिवर्तक",
      "icon": "assets/images/area_converter.png",
      "tbl_name": "tbl_area_converter",
    },
  ],
};

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
