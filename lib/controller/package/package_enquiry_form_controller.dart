import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/response/package_enquiry_form_api_response.dart';
import '../../network/url.dart';

class PackageEnquiryController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool success = false.obs;

  Future<void> submitEnquiry({
    required String packageId,
    // required String serviceId,
    // required String firstName,
    // required String lastName,
    // required String email,
    // required String mobileNumber,
    // required String message,
  }) async {
    try {
      isLoading.value = true;
      success.value = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? customerId = prefs.getString('customer_id');

      String createjson = Createjson().createJsonForpackageEnquiryForm(
        packageId,
        customerId,
        // serviceId,
        // firstName,
        // lastName,
        // email,
        // mobileNumber,
        // message,
      );

      List<Object?>? list = await Networkcall().postMethod(
        URLS().package_enquiry_form,
        URLS().package_enquiry_formUrl,
        createjson,
        Get.context!,
      );

      if (list != null) {
        List<PackageEnquiryFormApiResponse> response = List.from(list);
        if (response.isNotEmpty && response[0].status == "true") {
          success.value = true;
        }
      }
    } catch (e) {
      print('Error submitting enquiry: $e');
      success.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
