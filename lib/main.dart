import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/controller/bottom_navigation/bottom_navigation_controller.dart';
import 'package:bhulexapp/controller/package/package_enquiry_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/order/my_order_controller.dart';
import 'controller/package/getallpackagecontroller.dart';
import 'controller/package/my_package_controller.dart';

import 'splash_screens/splash_screen1.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<BottomNavigationController>(
    () => BottomNavigationController(),
    fenix: true,
  );
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
    final width = MediaQuery.of(context).size.width;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bhulex',
      // initialRoute: '/',
      theme: ThemeData(
        scaffoldBackgroundColor: Colorfile.background,
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: Colorfile.appbar,
          iconTheme: IconThemeData(color: Colorfile.textColor),
          titleTextStyle: AppFontStyle2.blinker(
            fontWeight: FontWeight.w600,
            fontSize: width * 0.045,
            color: Color(0xFF36322E),
          ),
        ),

        colorScheme: ColorScheme.fromSeed(seedColor: Colorfile.bordertheme),
      ),
      home: const SplashScreen(),
    );
  }
}
