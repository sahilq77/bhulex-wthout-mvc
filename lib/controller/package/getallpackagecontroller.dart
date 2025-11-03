import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../database/user_details_database.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/response/get_all_package_api_response.dart';
import '../../network/url.dart';

class PackageController extends GetxController {
  RxList<GetAllPackageApiResponseDatum> allPackages =
      <GetAllPackageApiResponseDatum>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxInt offset = 0.obs;
  RxString baseUrl = ''.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchPackages();
  }

  Future<void> fetchPackages({int? customOffset, String? packageId}) async {
    final userData = await UserDatabaseHelper().getUser();
    try {
      int currentOffset = customOffset ?? offset.value;
      isLoading.value = true;
      String customerIdbackup = '';
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (userData != null) {
        print('User ID: ${userData['id']}');
        print('Customer Name: ${userData['customer_name']}');
      }
      if (customerIdbackup.isEmpty) {
        final String? customerId = prefs.getString('customer_id');
        customerIdbackup = customerId ?? '';
      }
      String createjson = Createjson().createJsonForgetvehicleloadingapi(
        customerIdbackup,
        offset: currentOffset,
        limit: limit,
        
        packageId: packageId,
        lang: '',
      );

      List<Object?>? list = await Networkcall().postMethod(
        URLS().get_all_package,
        URLS().get_all_packageUrl,
        createjson,
        Get.context!,
      );

      if (list != null && list.isNotEmpty) {
        List<GetAllPackageApiResponse> response = List.from(list);
        if (response.isNotEmpty && response[0].status == "true") {
          if (currentOffset == 0) {
            baseUrl.value = response[0].iconPath;
            allPackages.clear();
            // Only add packages if they exist
            if (response[0].data.packages.isNotEmpty) {
              allPackages.addAll(
                response[0].data.packages.map(
                  (package) =>
                      GetAllPackageApiResponseDatum(packages: [package]),
                ),
              );
            }
          } else {
            if (response[0].data.packages.isNotEmpty) {
              allPackages.addAll(
                response[0].data.packages.map(
                  (package) =>
                      GetAllPackageApiResponseDatum(packages: [package]),
                ),
              );
            }
          }
          offset.value = currentOffset + limit;
          print('Fetched ${allPackages.length} packages');
          for (var pkg in allPackages) {
            print('Package: ${pkg.packages.first.packageName}');
          }
        } else {
          print('API response status is not "true" or empty');
        }
      } else {
        print('API returned null or empty list');
      }
    } catch (e) {
      print('Error fetching packages: $e');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshPackages() async {
    offset.value = 0;
    await fetchPackages(customOffset: 0);
    await Future.delayed(const Duration(seconds: 3));
  }

  Future<void> loadMorePackages() async {
    if (!isLoadingMore.value && !isLoading.value) {
      isLoadingMore.value = true;
      await fetchPackages();
    }
  }
}
