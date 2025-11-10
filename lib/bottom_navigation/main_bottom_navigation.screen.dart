import 'package:bhulexapp/Core/AppImages.dart';
import 'package:bhulexapp/Core/ColorFile.dart';
import 'package:bhulexapp/Core/apputility.dart';
import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/controller/bottom_navigation/bottom_navigation_controller.dart';
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:bhulexapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // ← import
import 'package:get/get.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationController());
    final LanguageController languageController = Get.put(LanguageController());
    // Use fixed sizes for better control
    const double bottomBarHeight = 70.0; // Fixed height
    const double iconSize = 24.0; // Standard icon size
    const double fontSize = 12.0; // Standard font size
    const double verticalPadding = 8.0; // Reduced padding
    const double spacing = 4.0; // Reduced spacing

    return Container(
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              index: 0,
              icon: AppImages.homeIcon, // regular
              selectedIcon:
                  FontAwesomeIcons.house, // solid (or use houseUser, etc.)
              label: BottomNavigationStrings.getString(
                'home',
                languageController.isToggled.value,
              ),
              controller: controller,
              iconSize: iconSize,
              fontSize: fontSize,
              verticalPadding: verticalPadding,
              horizontalPadding:
                  verticalPadding, // Match vertical for consistency
              spacing: spacing,
            ),
            _buildNavItem(
              index: 1,
              icon: AppImages.supportIcon,
              selectedIcon: FontAwesomeIcons.headset,
              label: BottomNavigationStrings.getString(
                'customerCare',
                languageController.isToggled.value,
              ),
              controller: controller,
              iconSize: iconSize,
              fontSize: fontSize,
              verticalPadding: verticalPadding,
              horizontalPadding:
                  verticalPadding, // Match vertical for consistency
              spacing: spacing,
            ),
            _buildNavItem(
              index: 2,
              icon: AppImages.ordersIcon,
              selectedIcon: FontAwesomeIcons.receipt,
              label: BottomNavigationStrings.getString(
                'myOrder',
                languageController.isToggled.value,
              ),
              controller: controller,
              iconSize: iconSize,
              fontSize: fontSize,
              verticalPadding: verticalPadding,
              horizontalPadding:
                  verticalPadding, // Match vertical for consistency
              spacing: spacing,
            ),
            _buildNavItem(
              index: 3,
              icon: AppImages.profileIcon,
              selectedIcon: FontAwesomeIcons.solidUser,
              label: BottomNavigationStrings.getString(
                'myProfile',
                languageController.isToggled.value,
              ),
              controller: controller,
              iconSize: iconSize,
              fontSize: fontSize,
              verticalPadding: verticalPadding,
              horizontalPadding:
                  verticalPadding, // Match vertical for consistency
              spacing: spacing,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon, // now FontAwesomeIcons.*
    required IconData selectedIcon,
    required String label,
    required double iconSize,
    required double fontSize,
    required double verticalPadding,
    required double horizontalPadding,
    required double spacing,
    required BottomNavigationController controller,
  }) {
    final isSelected = controller.selectedIndex.value == index;
    final color = isSelected ? AppColors.primaryColor : Colors.grey;
    final fontWeight = isSelected ? FontWeight.w600 : FontWeight.normal;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              semanticsLabel: label,
            ),

            const SizedBox(height: 4.0),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12.0,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
