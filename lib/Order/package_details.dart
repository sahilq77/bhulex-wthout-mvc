
import 'dart:developer';
import 'dart:io';
import 'package:bhulexapp/My_package/package_details_new.dart';
import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/controller/package/package_enquiry_form_controller.dart';
import 'package:bhulexapp/homepage.dart';
import 'package:bhulexapp/language/hindi.dart' hide PackageStrings;
import 'package:bhulexapp/no%20internet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


import '../controller/package/package_controller.dart';

import '../controller/order/language controller.dart';

class PackageDetailsPage extends StatefulWidget {
  final String customer_id;
  final String package_id;
  final String lead_id;
  //   final String customer_id;
  //   final String package_id;
  //   final String lead_id;

  const PackageDetailsPage({
    super.key,
    required this.customer_id,
    required this.package_id,
    required this.lead_id,
    required bool isToggled,
  });

  @override
  State<PackageDetailsPage> createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
  late PackageEnquiryController _enquiryController;

  PackageControllerforpackage packageController = Get.put(
    PackageControllerforpackage(customerId: '', packageId: ''),
  );

  final LanguageController languageController = Get.find<LanguageController>();

  @override
  void initState() {
    super.initState();
    _checkAndFetchData();
    String uniqueTag = '${widget.customer_id}-${widget.package_id}';
    _enquiryController = Get.put(PackageEnquiryController()); // Initialize here
    if (Get.isRegistered<PackageControllerforpackage>(tag: uniqueTag)) {
      Get.delete<PackageControllerforpackage>(tag: uniqueTag);
    }
    packageController = Get.put(
      PackageControllerforpackage(
        customerId: widget.customer_id,
        packageId: widget.package_id,
      ),
      tag: uniqueTag,
    );
  }

  Future<void> _checkAndFetchData() async {
    bool isConnected = await _checkConnectivity();
    if (isConnected) {
      _initializeController();
    } else {
      Get.to(
        () => NoInternetPage(
          onRetry: () {
            _checkAndFetchData(); // Retry fetching data
          },
        ),
      );
    }
  }

  // Initialize the package controller
  void _initializeController() {
    String uniqueTag = '${widget.customer_id}-${widget.package_id}';
    _enquiryController = Get.put(PackageEnquiryController());
    if (Get.isRegistered<PackageControllerforpackage>(tag: uniqueTag)) {
      Get.delete<PackageControllerforpackage>(tag: uniqueTag);
    }
    packageController = Get.put(
      PackageControllerforpackage(
        customerId: widget.customer_id,
        packageId: widget.package_id,
      ),
      tag: uniqueTag,
    );
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

  Future<void> _showPaymentDialog() async {
    Get.dialog(
      AlertDialog(
        title: Obx(
          () => Text(
            languageController.isToggled.value
                ? 'पेमेंटची पुष्टी करा'
                : 'Confirm Payment',
            style: AppFontStyle2.blinker(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        content: SizedBox(
          width:
              MediaQuery.of(context).size.width *
              0.8, // Added reasonable width constraint
          child: SingleChildScrollView(
            child: Obx(
              () => Text(
                languageController.isToggled.value
                    ? 'आपण खात्रीने पेमेंटसह पुढे जाऊ इच्छिता?'
                    : 'Are you sure you want to proceed with the payment?',
                style: AppFontStyle2.blinker(fontSize: 14),
              ),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Obx(
                  () => Text(
                    languageController.isToggled.value ? 'रद्द करा' : 'Cancel',
                    style: AppFontStyle2.blinker(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                onPressed: () => Get.back(),
              ),
              Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF57C03),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                  onPressed:
                      _enquiryController.isLoading.value
                          ? null
                          : () async {
                            await _enquiryController.submitEnquiry(
                              packageId: widget.package_id,
                            );
                            if (_enquiryController.success.value) {
                              Get.back();
                              Get.snackbar(
                                languageController.isToggled.value
                                    ? 'यशस्वी'
                                    : 'Success',
                                languageController.isToggled.value
                                    ? 'पेमेंट यशस्वी'
                                    : 'Payment successful',
                                backgroundColor: const Color(0xFF4CAF50),
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                                margin: const EdgeInsets.all(10),
                                borderRadius: 8,
                                duration: const Duration(seconds: 3),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => PackageScreen(
                                        package_id: widget.package_id,
                                        tbl_name: '',
                                        customerId: '',
                                        customerid: '',
                                      ),
                                ),
                              );
                            } else {
                              Get.back();
                              Get.snackbar(
                                languageController.isToggled.value
                                    ? 'त्रुटी'
                                    : 'Error',
                                languageController.isToggled.value
                                    ? 'पेमेंट अयशस्वी'
                                    : 'Payment failed',
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  233,
                                  15,
                                  15,
                                ),
                                colorText: Colors.white,
                              );
                            }
                          },
                  child:
                      _enquiryController.isLoading.value
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Obx(
                            () => Text(
                              languageController.isToggled.value
                                  ? 'आता पैसे द्या'
                                  : 'Pay Now',
                              style: AppFontStyle2.blinker(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                ),
              ),
            ],
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        insetPadding: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorfile.appbar,
      appBar: AppBar(
        backgroundColor: Colorfile.body,
        title: Obx(
          () => Text(
            languageController.isToggled.value ? "पॅकेज" : "Package",
            style: AppFontStyle2.blinker(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colorfile.darkgrey,
            ),
          ),
        ),
        titleSpacing: 0.0,
        shape: Border(bottom: BorderSide(color: Colorfile.border, width: 1.0)),
      ),
      body: Obx(
        () =>
            packageController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : packageController.packageDetails.isEmpty
                ? const Center(child: Text("No data available"))
                : Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 20,
                    bottom: 10,
                    top: 10,
                  ),
                  child: ListView.builder(
                    itemCount: packageController.packageDetails.length,
                    itemBuilder: (context, index) {
                      final offer = packageController.packageDetails[index];
                      log(
                        'Image URL: ${packageController.baseUrl.value + (offer.packageDetails.icon)}',
                      );
                      final package = packageController.packageDetails[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFDFE6F8),
                              width: 0.5,
                            ),
                            color: Colors.white,
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  packageController
                                                      .baseUrl
                                                      .value +
                                                  (package.packageDetails.icon),
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              languageController.isToggled.value
                                                  ? (offer
                                                              .packageDetails
                                                              .packageNameInLocalLanguage
                                                              ?.isNotEmpty ??
                                                          false
                                                      ? offer
                                                          .packageDetails
                                                          .packageNameInLocalLanguage!
                                                      : PackageStrings.getPackageName(
                                                        offer
                                                            .packageDetails
                                                            .packageName,
                                                        true,
                                                      ))
                                                  : offer
                                                      .packageDetails
                                                      .packageName,
                                              style: AppFontStyle2.blinker(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF353B43),
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
                                        Text(
                                          languageController.isToggled.value
                                              ? 'किंमत: '
                                              : 'Price: ',
                                          style: AppFontStyle2.blinker(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF353B43),
                                          ),
                                        ),
                                        Text(
                                          '₹ ${offer.packageDetails.discountPrice}',
                                          style: AppFontStyle2.blinker(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF36322E),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 1),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  languageController.isToggled.value
                                      ? (offer
                                                  .packageDetails
                                                  .shortDescriptionInLocalLanguage
                                                  ?.isNotEmpty ??
                                              false
                                          ? offer
                                              .packageDetails
                                              .shortDescriptionInLocalLanguage!
                                          : PackageStrings.getShortDescription(
                                            offer
                                                .packageDetails
                                                .shortDescription,
                                            true,
                                          ))
                                      : offer.packageDetails.shortDescription,
                                  style: AppFontStyle2.blinker(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4B5563),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  languageController.isToggled.value
                                      ? 'आवश्यक कागदपत्रे :'
                                      : 'Required Documents :',
                                  style: AppFontStyle2.blinker(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF36322E),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children:
                                    (package.packageDetails.serviceNames ?? '').split(',').map((
                                      serviceName,
                                    ) {
                                      return Obx(() {
                                        String serviceNameText =
                                            languageController.isToggled.value
                                                ? ((package
                                                                .packageDetails
                                                                .serviceNames
                                                                .isNotEmpty ??
                                                            false) &&
                                                        package
                                                                .packageDetails
                                                                .serviceNames
                                                                .split(',')
                                                                .length >
                                                            (package
                                                                        .packageDetails
                                                                        .serviceNames ??
                                                                    '')
                                                                .split(',')
                                                                .indexOf(
                                                                  serviceName,
                                                                )
                                                    ? package
                                                        .packageDetails
                                                        .serviceNames
                                                        .split(',')[(package
                                                                    .packageDetails
                                                                    .serviceNames ??
                                                                '')
                                                            .split(',')
                                                            .indexOf(
                                                              serviceName,
                                                            )]
                                                        .trim()
                                                    : allPackageStrings
                                                        .getServiceName(
                                                          serviceName.trim(),
                                                          true,
                                                        ))
                                                : allPackageStrings
                                                    .getServiceName(
                                                      serviceName.trim(),
                                                      false,
                                                    );

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            left: 7.0,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5F4F1),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: const Color(0xFFE5E7EB),
                                              ),
                                            ),
                                            child: Text(
                                              serviceNameText,
                                              style: AppFontStyle2.blinker(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF757575),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    }).toList(),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showPaymentDialog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF57C03),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    minimumSize: const Size(
                                      double.infinity,
                                      48,
                                    ),
                                  ),
                                  child: Text(
                                    languageController.isToggled.value
                                        ? 'आता खरेदी करा'
                                        : 'Buy Now',
                                    style: AppFontStyle2.blinker(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
