import 'dart:async';
import 'dart:io';

import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/homepage.dart';
import 'package:bhulexapp/language/hindi.dart' hide PackageStrings;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../Core/apputility.dart';
import '../controller/package/getallpackagecontroller.dart';
import '../controller/order/language%20controller.dart';
import '../network/response/get_all_package_api_response.dart';
import 'package_details.dart';
import '../My_package/package_order_details.dart';

class AllPackagesPage extends StatefulWidget {
  @override
  _AllPackagesPageState createState() => _AllPackagesPageState();
}

class _AllPackagesPageState extends State<AllPackagesPage> {
  final PackageController packageController = Get.put(PackageController());
  final LanguageController languageController = Get.find<LanguageController>();
  final ScrollController _scrollController = ScrollController();
  bool hasConnection = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    super.initState();
    // checkNetworkConnection(context);
    // Fetch initial packages
    // _initConnectivity();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      packageController.fetchPackages(customOffset: 0);
    });

    // Pagination listener
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !packageController.isLoadingMore.value) {
        packageController.loadMorePackages();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

 
  void _showFilterDialog() {
    GetAllPackageApiResponseDatum? selectedPackage;

    Get.dialog(
      AlertDialog(
        title: Obx(
          () => Text(
            languageController.isToggled.value
                ? 'पॅकेजेस फिल्टर करा'
                : 'Filter Packages',
            style: AppFontStyle.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        content: DropdownSearch<GetAllPackageApiResponseDatum>(
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                labelText:
                    languageController.isToggled.value
                        ? 'पॅकेज शोधा'
                        : 'Search Package',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          items: packageController.allPackages,
          itemAsString:
              (item) =>
                  languageController.isToggled.value
                      ? (item.packages.isNotEmpty &&
                              item
                                      .packages
                                      .first
                                      .packageNameInLocalLanguage
                                      .isNotEmpty ==
                                  true
                          ? item.packages.first.packageNameInLocalLanguage!
                          : PackageStrings.getPackageName(
                            item.packages.isNotEmpty
                                ? item.packages.first.packageName
                                : 'No Name',
                            true,
                          ))
                      : (item.packages.isNotEmpty
                          ? item.packages.first.packageName
                          : 'No Name'),
          onChanged: (value) {
            selectedPackage = value;
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText:
                  languageController.isToggled.value
                      ? 'पॅकेज निवडा'
                      : 'Select Package',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Obx(
              () => Text(
                languageController.isToggled.value ? 'रद्द करा' : 'Cancel',
                style: AppFontStyle.poppins(color: Colors.grey),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (selectedPackage != null &&
                  selectedPackage!.packages.isNotEmpty) {
                packageController.offset.value = 0;
                packageController.fetchPackages(
                  customOffset: 0,
                  packageId: selectedPackage!.packages.first.id,
                );
              }
              Get.back();
            },
            child: Obx(
              () => Text(
                languageController.isToggled.value ? 'लागू करा' : 'Apply',
                style: AppFontStyle.poppins(color: Colorfile.bordertheme),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title: Obx(
          () => Text(
            languageController.isToggled.value
                ? 'सर्व पॅकेजेस'
                : 'All Packages',
            style: AppFontStyle.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colorfile.defaultblack,
            ),
          ),
        ),
        titleSpacing: 0.0,
        shape: const Border(
          bottom: BorderSide(color: Colorfile.border, width: 1.0),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colorfile.defaultblack),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (!hasConnection) {
           // _showNoInternetPopup();
            return;
          }
          await packageController.refreshPackages();
        },
        color: Colorfile.bordertheme,
        child: Obx(
          () =>
              packageController.isLoading.value &&
                      packageController.allPackages.isEmpty
                  ? const Center(child: CircularProgressIndicator())
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
                                  style: AppFontStyle.poppins(
                                    fontSize: 14,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            languageController.isToggled.value
                                ? 'कोणताही डेटा उपलब्ध नाही'
                                : 'No data available',
                            style: AppFontStyle.poppins(
                              fontSize: 16,
                              color: Colorfile.defaultblack,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                  : packageController.allPackages.isEmpty
                  ? const Center(child: Text('No packages available'))
                  : ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    itemCount:
                        packageController.allPackages.length +
                        (packageController.isLoadingMore.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == packageController.allPackages.length &&
                          packageController.isLoadingMore.value) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final package = packageController.allPackages[index];
                      if (package.packages.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => PackageDetailsPage(
                                      package_id: package.packages.first.id,
                                      customer_id: AppUtility.login_id,
                                      isToggled:
                                          languageController.isToggled.value,
                                      lead_id: '',
                                    ),
                              ),
                            );
                            print(
                              "Tapped on: ${package.packages.first.packageName}",
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFDFE6F8),
                                  width: 0.5,
                                ),
                                color: Colors.white,
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
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      packageController
                                                          .baseUrl
                                                          .value +
                                                      (package
                                                          .packages
                                                          .first
                                                          .icon),
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
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Obx(
                                                  () => Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                                .packageNameInLocalLanguage!
                                                            : allPackageStrings
                                                                .getPackageName(
                                                                  package
                                                                      .packages
                                                                      .first
                                                                      .packageName,
                                                                  true,
                                                                ))
                                                        : (package
                                                            .packages
                                                            .first
                                                            .packageName),
                                                    style: AppFontStyle.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                        0xFF353B43,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Obx(
                                              () => Text(
                                                languageController
                                                        .isToggled
                                                        .value
                                                    ? 'किंमत: '
                                                    : 'Price: ',
                                                style: AppFontStyle.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(
                                                    0xFF353B43,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '₹ ${package.packages.first.discountPrice}',
                                              style: AppFontStyle.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF36322E),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                    ),
                                    child: Obx(
                                      () => Text(
                                        languageController.isToggled.value
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
                                        style: AppFontStyle.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF4B5563),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Wrap(
                                      spacing: 6,
                                      runSpacing: 6,
                                      children:
                                          (package.packages.first.serviceNames ?? '').split(',').map((
                                            serviceName,
                                          ) {
                                            return Obx(() {
                                              String serviceNameText =
                                                  languageController
                                                          .isToggled
                                                          .value
                                                      ? ((package
                                                                      .packages
                                                                      .first
                                                                      .serviceNamesLocal
                                                                      ?.isNotEmpty ??
                                                                  false) &&
                                                              package
                                                                      .packages
                                                                      .first
                                                                      .serviceNamesLocal!
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
                                                          ? package
                                                              .packages
                                                              .first
                                                              .serviceNamesLocal!
                                                              .split(
                                                                ',',
                                                              )[(package
                                                                          .packages
                                                                          .first
                                                                          .serviceNames ??
                                                                      '')
                                                                  .split(',')
                                                                  .indexOf(
                                                                    serviceName,
                                                                  )]
                                                              .trim()
                                                          : allPackageStrings
                                                              .getServiceName(
                                                                serviceName
                                                                    .trim(),
                                                                true,
                                                              ))
                                                      : allPackageStrings
                                                          .getServiceName(
                                                            serviceName.trim(),
                                                            false,
                                                          );

                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFF5F4F1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: const Color(
                                                      0xFFE5E7EB,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  serviceNameText,
                                                  style: AppFontStyle.poppins(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                      0xFF757575,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                          }).toList(),
                                    ),
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
    );
  }
}
