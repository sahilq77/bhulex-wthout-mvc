import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  RxBool isToggled = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadToggleState();
  }

  Future<void> _loadToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    isToggled.value = prefs.getBool('isToggled') ?? false;
  }

  Future<void> toggleLanguage(bool value) async {
    isToggled.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isToggled', value);
  }
}