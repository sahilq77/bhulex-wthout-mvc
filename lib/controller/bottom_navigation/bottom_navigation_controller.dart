import 'package:bhulexapp/Order/order_list.dart';
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:bhulexapp/homepage.dart';
import 'package:bhulexapp/profile/profile.dart';
import 'package:bhulexapp/support/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  // Current selected index
  RxInt selectedIndex = 0.obs;
  // LanguageController get languageController => Get.find<LanguageController>();
  // List of pages (without passing empty strings)
  static final List<Widget> pages = [
    const HomePage2(
      customerId: "",
      customer_id: "",
    ), // Will be replaced properly later
    const SupportPage(),
    const MyOrderScreen(),
    const ProfilePage(isToggled: false),
  ];

  // Current page widget
  late final Rx<Widget> currentPage = pages[0].obs;

  // GlobalKey for persistent bottom bar
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void onInit() {
    super.onInit();
    currentPage.value = pages[0];
  }

  void changeTab(int index) {
    if (selectedIndex.value == index) return;

    selectedIndex.value = index;
    currentPage.value = pages[index];

    // Best practice: Use Get.offAll with named routes or simple widget replacement
    Get.offAll(
      () => pages[index],
      transition: Transition.noTransition,
      // This keeps the bottom bar alive
      predicate: (route) => false, // Clear all previous routes
    );
  }

  void goToHome() {
    selectedIndex.value = 0;
    currentPage.value = pages[0];
    Get.offAll(
      () => const HomePage2(customerId: "", customer_id: ""),
      transition: Transition.noTransition,
    );
  }
}
