import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../database/user_details_database.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/response/get_all_orders_api_response.dart';
import '../../network/response/get_all_service_package_api_response.dart';
import '../../network/url.dart';

class OrderController extends GetxController {
  RxList<GetAllOrdersApiResponseDatum> allOrders =
      <GetAllOrdersApiResponseDatum>[].obs;
  RxList<GetAllServicePackageApiResponseDatum> packageService =
      <GetAllServicePackageApiResponseDatum>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxInt offset = 0.obs;
  RxString customerId = '1'.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
    fetchproductserviceapi();
  }

  Future<void> fetchproductserviceapi({
    int? customOffset,
    String? customerId,
    // String? packageId,
    String? serviceId,
    bool isToggled = false,
  }) async {
    log("For Filter API: get_all_service_package");
    final userData = await UserDatabaseHelper().getUser();
    try {
      int currentOffset = customOffset ?? offset.value;
      isLoading.value = true;
      String customerIdBackup = '';
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (userData != null) {
        print('User ID: ${userData['id']}');
        print('Customer Name: ${userData['customer_name']}');
      }
      if (customerIdBackup.isEmpty) {
        final String? customerId = prefs.getString('customer_id');
        customerIdBackup = customerId ?? '1';
        this.customerId.value = customerIdBackup;
      }

      String createJson = Createjson().createJsonForGetAllOrdersapi(
        customerIdBackup,
        offset: currentOffset,
        limit: limit,

        //packageId: packageId,
        // serviceId: serviceId,
        language: isToggled ? 'mr' : 'en',
      );

      List<Object?>? list = await Networkcall().postMethod(
        URLS().get_all_service_package,
        URLS().get_all_service_packageapiUrl,
        createJson,
        Get.context!,
      );

      if (list != null) {
        List<GetAllServicePackageApiResponse> response = List.from(list);
        if (response.isNotEmpty && response[0].status == "true") {
          if (currentOffset == 0) {
            packageService.assignAll(response[0].data);
          } else {
            packageService.addAll(response[0].data);
          }
          offset.value = currentOffset + limit;
        } else {
          print('No services/packages found or status is false');
        }
      }
    } catch (e) {
      print('Error fetching services/packages: $e');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> fetchOrders({
    int? customOffset,
    String? packageId,
    bool isToggled = false,
    String? serviceId, String? customerId,
  }) async {
    log("For api :get_all_orders");
    final userData = await UserDatabaseHelper().getUser();
    try {
      int currentOffset = customOffset ?? offset.value;
      isLoading.value = true;
      String customerIdBackup = '';
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (userData != null) {
        print('User ID: ${userData['id']}');
        print('Customer Name: ${userData['customer_name']}');
      }
      if (customerIdBackup.isEmpty) {
        final String? customerId = prefs.getString('customer_id');
        customerIdBackup = customerId ?? '1';
        this.customerId.value = customerIdBackup;
      }

      String createJson = Createjson().createJsonForGetAllOrdersapi(
        customerIdBackup,
        offset: currentOffset,
        limit: limit,
        packageId: packageId,
        language: isToggled ? 'mr' : 'en', // Pass language based on toggle
      );

      if (createJson.isEmpty) {
        throw Exception('Failed to create JSON for API call');
      }

      List<Object?>? list = await Networkcall().postMethod(
        URLS().get_all_orders,
        URLS().get_all_ordersUrl,
        createJson,
        Get.context!,
      );

      if (list != null) {
        List<GetAllOrdersApiResponse> response = List.from(list);
        if (response.isNotEmpty && response[0].status == "true") {
          if (currentOffset == 0) {
            allOrders.assignAll(response[0].data);
          } else {
            allOrders.addAll(response[0].data);
          }
          offset.value = currentOffset + limit;
        }
      }
    } catch (e) {
      print('Error fetching orders: $e');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshOrders({bool isToggled = false}) async {
    offset.value = 0;
    allOrders.clear();
    await fetchOrders(customOffset: 0, isToggled: isToggled);
    await fetchproductserviceapi(customOffset: 0, isToggled: isToggled);
    await Future.delayed(const Duration(seconds: 3));
  }

  Future<void> loadMoreOrders({bool isToggled = false}) async {
    if (!isLoadingMore.value && !isLoading.value) {
      isLoadingMore.value = true;
      await fetchOrders(isToggled: isToggled);
    }
  }
}
