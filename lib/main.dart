import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/controller/package/package_enquiry_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/order/my_order_controller.dart';
import 'controller/package/getallpackagecontroller.dart';
import 'controller/package/my_package_controller.dart';
import 'customfiles/bottom_navigation_controller.dart';
import 'splash_screens/splash_screen1.dart';

void main() {
  
  Get.put(BottomNavigationController());
  Get.put(OrderController());
  Get.put(PackageController());
  Get.put(PackageEnquiryController());
  Get.put(PackageOrderController());
  // Get.put(PackageControllerforpackage(customerId: '', packageId: ''));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static var apiUrl;

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bhulex',
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colorfile.bordertheme),
      ),
      home: const SplashScreen(),
    );
  }
}
