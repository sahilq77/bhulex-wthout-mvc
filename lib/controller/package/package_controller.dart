// import 'package:get/get.dart';
// import '../../network/createjson.dart';
// import '../../network/networkcall.dart';
// import '../../network/response/package_details_api_response.dart';
// import '../../network/url.dart';

// class PackageControllerforpackage extends GetxController {
//   RxList<PackageDetailsApiResponseDatum> packageDetails =
//       <PackageDetailsApiResponseDatum>[].obs;

//   RxBool isLoading = false.obs;
//   RxString baseUrl = ''.obs;

//   final String customerId;
//   final String packageId;

//   PackageControllerforpackage({
//     required this.customerId,
//     required this.packageId,
//   });

//   @override
//   void onInit() {
//     super.onInit();
//     fetchPackageDetails();
//   }

//   Future<void> fetchPackageDetails() async {
//     try {
//       isLoading.value = true;

//       String createjson = Createjson().createJsonForPackageDetailsApi(
//         customerId,
//         packageId,
//       );

//       List<Object?>? list = await Networkcall().postMethod(
//         URLS().package_details,
//         URLS().package_detailsUrl,
//         createjson,
//         Get.context!,
//       );

//       if (list != null) {
//         List<PackageDetailsApiResponse> response = List.from(list);
//         if (response.isNotEmpty && response[0].status == "true") {
//           packageDetails.assignAll(response[0].data);
//         }
//       }
//     } catch (e) {
//       print('Error fetching package details: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
import 'package:get/get.dart';
import 'dart:developer'; // Added import
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/response/package_details_api_response.dart';
import '../../network/url.dart';

class PackageControllerforpackage extends GetxController {
  RxList<PackageDetailsApiResponseDatum> packageDetails =
      <PackageDetailsApiResponseDatum>[].obs;

  RxBool isLoading = false.obs;
  RxString baseUrl = ''.obs;

  final String customerId;
  final String packageId;

  PackageControllerforpackage({
    required this.customerId,
    required this.packageId,
  });

  @override
  void onInit() {
    super.onInit();
    fetchPackageDetails();
  }

  Future<void> fetchPackageDetails() async {
    try {
      isLoading.value = true;

      String createjson = Createjson().createJsonForPackageDetailsApi(
        customerId,
        packageId,
      );

      List<Object?>? list = await Networkcall().postMethod(
        URLS().package_details,
        URLS().package_detailsUrl,
        createjson,
        Get.context!,
      );

      if (list != null) {
        log('API Response: $list'); // Debug log
        List<PackageDetailsApiResponse> response = List.from(list);
        if (response.isNotEmpty && response[0].status == "true") {
          baseUrl.value = response[0].iconPath;
          log('Image path: ${baseUrl.value}');
          packageDetails.assignAll([response[0].data]); // Wrap in a list
        }
      }
    } catch (e) {
      log('Error fetching package details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
