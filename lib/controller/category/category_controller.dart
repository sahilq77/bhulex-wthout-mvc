// controllers/category_controller.dart
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:bhulexapp/model/category_response_model.dart';
import 'package:bhulexapp/network/url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class CategoryController extends GetxController {
  var isLoading = true.obs;
  var hasConnection = true.obs;
  var categories = <Category>[].obs;
  var iconPath = ''.obs;

  final LanguageController languageController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    if (!hasConnection.value) {
      isLoading(false);
      return;
    }

    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final customerId = prefs.getString('customer_id') ?? '';

      final response = await http.post(
        Uri.parse(URLS().get_all_category_apiUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "customer_id": customerId,
          "lang": languageController.isToggled.value ? 'mr' : 'en',
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final categoryResponse = CategoryResponse.fromJson(jsonData);
        categories.assignAll(categoryResponse.data);
        iconPath.value = categoryResponse.iconPath;
      } else {
        Get.snackbar("Error", "Failed to load categories");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }

  void refreshData() => fetchCategories();
}