// // // import 'dart:developer';
// // // import 'package:get/get.dart';
// // // import 'package:my_bhulekh_app/network/response/get_all_mypackage_api_response.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import '../../database/user_details_database.dart';
// // // import '../../network/createjson.dart';
// // // import '../../network/networkcall.dart';
// // // import '../../network/url.dart';

// // // class PackageOrderController extends GetxController {
// // //   RxList<GetAllPackageOrdersApiResponseDatum> allPackageOrders =
// // //       <GetAllPackageOrdersApiResponseDatum>[].obs;

// // RxBool isLoading = false.obs;
// // RxBool isLoadingMore = false.obs;
// // RxInt offset = 0.obs;
// // // RxString customerId = '1'.obs;
// // final int limit = 10;

// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchPackageOrders();
// // //   }

// // //   Future<void> fetchPackageOrders({
// // //     int? customOffset,
// // //     String? packageId,
// // //     bool isToggled = false,
// // //     String? tbl_name,
// // //     String? customerId, // Add customerId parameter
// // //   }) async {
// // //     log("For API: get_all_package_orders");
// // //     try {
// // //       int currentOffset = customOffset ?? offset.value;
// // //       isLoading.value = true;
// // //       String customerIdBackup = customerId ?? ''; // Use passed customerId

// // //       if (customerIdBackup.isEmpty) {
// // //         SharedPreferences prefs = await SharedPreferences.getInstance();
// // //         final String? storedCustomerId = prefs.getString('customer_id');
// // //         customerIdBackup = storedCustomerId ?? '';
// // //       }
// // //       log("Customer ID used: $customerIdBackup");

// // //       String createJson = Createjson().createJsonForGetAllPackageOrdersapi(
// // //         customerIdBackup,
// // //         offset: currentOffset,
// // //         limit: limit,
// // //         tbl_name: tbl_name, // Pass tblName to JSON creator
// // //         packageId: packageId,
// // //         language: isToggled ? 'mr' : 'en',
// // //       );

// // //       if (createJson.isEmpty) {
// // //         throw Exception('Failed to create JSON for API call');
// // //       }

// // //       List<Object?>? list = await Networkcall().postMethod(
// // //         URLS().get_all_package_orders,
// // //         URLS().get_all_package_ordersapiUrl,
// // //         createJson,
// // //         Get.context!,
// // //       );
// // //       log("API Response: $list");

// // //       if (list != null) {
// // //         List<GetAllPackageOrdersApiResponse> response = List.from(list);
// // //         if (response.isNotEmpty && response[0].status == "true") {
// // //           if (currentOffset == 0) {
// // //             allPackageOrders.assignAll(response[0].data);
// // //           } else {
// // //             allPackageOrders.addAll(response[0].data);
// // //           }
// // //           offset.value = currentOffset + limit;
// // //         }
// // //       }
// // //     } catch (e) {
// // //       print('Error fetching package orders: $e');
// // //     } finally {
// // //       isLoading.value = false;
// // //       isLoadingMore.value = false;
// // //     }
// // //   }

// // //   Future<void> refreshPackages() async {
// // //     offset.value = 0;
// // //     await fetchPackageOrders(customOffset: 0);
// // //     await Future.delayed(const Duration(seconds: 3));
// // //   }

// // //   Future<void> loadMorePackages() async {
// // //     if (!isLoadingMore.value && !isLoading.value) {
// // //       isLoadingMore.value = true;
// // //       await fetchPackageOrders();
// // //     }
// // //   }
// // // }
// // import 'dart:developer';
// // import 'package:get/get.dart';
// // import 'package:my_bhulekh_app/network/response/get_all_mypackage_api_response.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import '../../database/user_details_database.dart';
// // import '../../network/createjson.dart';
// // import '../../network/networkcall.dart';
// // import '../../network/url.dart';

// // class PackageOrderController extends GetxController {
// //   RxList<GetAllPackageOrdersApiResponseDatum> allPackageOrders =
// //       <GetAllPackageOrdersApiResponseDatum>[].obs;

// //   RxBool isLoading = false.obs;
// //   RxBool isLoadingMore = false.obs;
// //   RxInt offset = 0.obs;
// //   final int limit = 10;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchPackageOrders();
// //   }

// //   Future<void> fetchPackageOrders({
// //     int? customOffset,
// //     String? packageId,
// //     String? leadId,
// //     //  String? tblName, // tblName can be null
// //     bool isToggled = false,
// //     String? customerId,
// //   }) async {
// //     log("For API: get_all_package_orders");
// //     try {
// //       int currentOffset = customOffset ?? offset.value;
// //       isLoading.value = true;
// //       String customerIdBackup = customerId ?? '';

// //       if (customerIdBackup.isEmpty) {
// //         SharedPreferences prefs = await SharedPreferences.getInstance();
// //         final String? storedCustomerId = prefs.getString('customer_id');
// //         customerIdBackup = storedCustomerId ?? '';
// //       }
// //       log("Customer ID used: $customerIdBackup");

// //       String createJson = Createjson().createJsonForGetAllPackageOrdersapi(
// //         customerIdBackup,
// //         offset: currentOffset,
// //         limit: limit,
// //         packageId: packageId,
// //         //leadId: leadId,
// //         //tbl_name: tblName, // Pass tblName
// //         language: isToggled ? 'mr' : 'en',
// //       );

// //       if (createJson.isEmpty) {
// //         throw Exception('Failed to create JSON for API call');
// //       }

// //       List<Object?>? list = await Networkcall().postMethod(
// //         URLS().get_all_package_orders,
// //         URLS().get_all_package_ordersapiUrl,
// //         createJson,
// //         Get.context!,
// //       );
// //       log("API Request Body: $createJson");
// //       log("API Response: $list");

// //       if (list != null) {
// //         List<GetAllPackageOrdersApiResponse> response = List.from(list);
// //         if (response.isNotEmpty && response[0].status == "true") {
// //           if (currentOffset == 0) {
// //             allPackageOrders.assignAll(response[0].data);
// //           } else {
// //             allPackageOrders.addAll(response[0].data);
// //           }
// //           offset.value = currentOffset + limit;
// //         }
// //       }
// //     } catch (e) {
// //       print('Error fetching package orders: $e');
// //     } finally {
// //       isLoading.value = false;
// //       isLoadingMore.value = false;
// //     }
// //   }

// //  Future<void> refreshPackages() async {
// //     offset.value = 0;
// //     await fetchPackageOrders(customOffset: 0);
// //     await Future.delayed(const Duration(seconds: 3));
// //   }

// //   Future<void> loadMorePackages() async {
// //     if (!isLoadingMore.value && !isLoading.value) {
// //       isLoadingMore.value = true;
// //       await fetchPackageOrders();
// //     }
// //   }
// // }
// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:my_bhulekh_app/network/response/get_all_mypackage_api_response.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../database/user_details_database.dart';
// import '../../network/createjson.dart';
// import '../../network/networkcall.dart';
// import '../../network/url.dart';

// class PackageMaster {
//   final String id;
//   final String packageName;
//   final String packageNameInLocalLanguage;

//   PackageMaster({
//     required this.id,
//     required this.packageName,
//     required this.packageNameInLocalLanguage,
//   });

//   factory PackageMaster.fromJson(Map<String, dynamic> json) {
//     return PackageMaster(
//       id: json['id'] as String,
//       packageName: json['package_name'] as String,
//       packageNameInLocalLanguage:
//           json['package_name_in_local_language'] as String,
//     );
//   }
// }

// class PackageOrderController extends GetxController {
//   RxList<GetAllPackageOrdersApiResponseDatum> allPackageOrders =
//       <GetAllPackageOrdersApiResponseDatum>[].obs;
//   RxList<PackageMaster> packageMasterList =
//       <PackageMaster>[].obs; // New list for master data

//   // RxBool isLoading = false.obs;
//   // RxBool isLoadingMore = false.obs;
//   // RxInt offset = 0.obs;
//   // final int limit = 10;
//   RxBool isLoading = false.obs;
//   RxBool isLoadingMore = false.obs;
//   RxInt offset = 0.obs;
//   // RxString customerId = '1'.obs;
//   final int limit = 10;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchPackageOrders(); // Fetch initial package orders
//     fetchPackageMasterList(); // Fetch package master list on init
//   }

//   // Fetch all package orders (existing method)
//   Future<void> fetchPackageOrders({
//     int? customOffset,
//     String? packageId,
//     String? leadId,
//     bool isToggled = false,
//     String? customerId,
//   }) async {
//     log("For API: get_all_package_orders");
//     try {
//       int currentOffset = customOffset ?? offset.value;
//       isLoading.value = true;
//       String customerIdBackup = customerId ?? '';

//       if (customerIdBackup.isEmpty) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         final String? storedCustomerId = prefs.getString('customer_id');
//         customerIdBackup = storedCustomerId ?? '';
//       }
//       log("Customer ID used: $customerIdBackup");

//       String createJson = Createjson().createJsonForGetAllPackageOrdersapi(
//         customerIdBackup,
//         offset: currentOffset,
//         limit: limit,
//         packageId: packageId,
//         language: isToggled ? 'mr' : 'en',
//       );

//       if (createJson.isEmpty) {
//         throw Exception('Failed to create JSON for API call');
//       }

//       List<Object?>? list = await Networkcall().postMethod(
//         URLS().get_all_package_orders,
//         URLS().get_all_package_ordersapiUrl,
//         createJson,
//         Get.context!,
//       );
//       log("API Request Body: $createJson");
//       log("API Response: $list");

//       if (list != null) {
//         List<GetAllPackageOrdersApiResponse> response = List.from(list);
//         if (response.isNotEmpty && response[0].status == "true") {
//           if (currentOffset == 0) {
//             allPackageOrders.assignAll(response[0].data);
//           } else {
//             allPackageOrders.addAll(response[0].data);
//           }
//           offset.value = currentOffset + limit;
//         }
//       }
//     } catch (e) {
//       print('Error fetching package orders: $e');
//     } finally {
//       isLoading.value = false;
//       isLoadingMore.value = false;
//     }
//   }

//   // New method to fetch package master list from get_all_package_master API
//   Future<void> fetchPackageMasterList() async {
//     if (packageMasterList.isNotEmpty)
//       return; // Avoid re-fetching if already loaded

//     try {
//       isLoading.value = true;
//       final response = await http.get(
//         Uri.parse(
//           'https://seekhelp.in/bhulex/get_all_package_master',
//         ), // Replace with actual endpoint
//         headers: {'Content-Type': 'application/json'},
//       );

//       log("Fetching package master list from: ${response.request?.url}");
//       log("API Response: ${response.body}");

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         if (jsonData['status'] == 'true') {
//           packageMasterList.value =
//               (jsonData['data'] as List)
//                   .map((item) => PackageMaster.fromJson(item))
//                   .toList();
//         } else {
//           print('API Error: ${jsonData['message']}');
//         }
//       } else {
//         print('HTTP Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Exception fetching package master: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> refreshPackages() async {
//     offset.value = 0;
//     await fetchPackageOrders(customOffset: 0);
//     await Future.delayed(const Duration(seconds: 3));
//   }

//   Future<void> loadMorePackages() async {
//     if (!isLoadingMore.value && !isLoading.value) {
//       isLoadingMore.value = true;
//       await fetchPackageOrders();
//     }
//   }
// }
import 'dart:developer';
import 'package:bhulexapp/network/response/get_all_mypackage_api_response.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/url.dart';

class PackageMaster {
  final String id;
  final String packageName;
  final String packageNameInLocalLanguage;

  PackageMaster({
    required this.id,
    required this.packageName,
    required this.packageNameInLocalLanguage,
  });

  factory PackageMaster.fromJson(Map<String, dynamic> json) {
    return PackageMaster(
      id: json['id']?.toString() ?? '',
      packageName: json['package_name']?.toString() ?? '',
      packageNameInLocalLanguage:
          json['package_name_in_local_language']?.toString() ?? '',
    );
  }
}

class PackageOrderController extends GetxController {
  RxList<GetAllPackageOrdersApiResponseDatum> allPackageOrders =
      <GetAllPackageOrdersApiResponseDatum>[].obs;
  RxList<PackageMaster> packageMasterList = <PackageMaster>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxInt offset = 0.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchPackageMasterList();
  }

  Future<void> fetchPackageOrders({
    int? customOffset,
    String? packageId,
    String? leadId,
    bool isToggled = false,
    String? customerId,
  }) async {
    log("For API: get_all_package_orders");
    try {
      int currentOffset = customOffset ?? offset.value;
      isLoading.value = currentOffset == 0;
      isLoadingMore.value = currentOffset > 0;

      String customerIdBackup = customerId ?? '';
      if (customerIdBackup.isEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        customerIdBackup = prefs.getString('customer_id') ?? '';
      }
      log("Customer ID used: $customerIdBackup");

      if (customerIdBackup.isEmpty) {
        log("No customer ID available, skipping fetch");
        allPackageOrders.clear();
        return;
      }

      String createJson = Createjson().createJsonForGetAllPackageOrdersapi(
        customerIdBackup,
        offset: currentOffset,
        limit: limit,
        packageId: packageId,
        language: isToggled ? 'mr' : 'en',
      );

      List<Object?>? list = await Networkcall().postMethod(
        URLS().get_all_package_orders,
        URLS().get_all_package_ordersapiUrl,
        createJson,
        Get.context!,
      );
      log("API Request Body: $createJson");
      log("API Response: $list");

      if (list != null) {
        List<GetAllPackageOrdersApiResponse> response = List.from(list);
        if (response.isNotEmpty && response[0].status == "true") {
          if (currentOffset == 0) {
            allPackageOrders.assignAll(response[0].data);
          } else {
            allPackageOrders.addAll(response[0].data);
          }
          offset.value = currentOffset + limit;
        } else {
          if (currentOffset == 0) {
            allPackageOrders.clear();
          }
        }
      } else {
        if (currentOffset == 0) {
          allPackageOrders.clear();
        }
      }
    } catch (e) {
      log('Error fetching package orders: $e');
      if (customOffset == 0) {
        allPackageOrders.clear();
      }
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> fetchPackageMasterList() async {
    if (packageMasterList.isNotEmpty) return;

    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://seekhelp.in/bhulex/get_all_package_master'),
        headers: {'Content-Type': 'application/json'},
      );

      log("Fetching package master list from: ${response.request?.url}");
      log("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'true') {
          packageMasterList.value = (jsonData['data'] as List)
              .map((item) => PackageMaster.fromJson(item))
              .toList();
        }
      }
    } catch (e) {
      log('Exception fetching package master: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPackages({String? customerId}) async {
    offset.value = 0;
    allPackageOrders.clear();
    await fetchPackageOrders(customOffset: 0, customerId: customerId);
  }

  Future<void> loadMorePackages({String? customerId}) async {
    if (!isLoadingMore.value && !isLoading.value) {
      await fetchPackageOrders(customerId: customerId);
    }
  }
}