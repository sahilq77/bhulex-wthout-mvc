import 'package:bhulexapp/Core/ColorFile.dart';
import 'package:bhulexapp/controller/bottom_navigation/bottom_navigation_controller.dart';
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:bhulexapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // ← import
import 'package:get/get.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationController());
    final LanguageController languageController = Get.put(LanguageController());

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
              icon: FontAwesomeIcons.house, // regular
              selectedIcon:
                  FontAwesomeIcons.house, // solid (or use houseUser, etc.)
              label: BottomNavigationStrings.getString(
                'home',
                languageController.isToggled.value,
              ),
              controller: controller,
            ),
            _buildNavItem(
              index: 1,
              icon: FontAwesomeIcons.headset,
              selectedIcon: FontAwesomeIcons.headset,
              label: BottomNavigationStrings.getString(
                'customerCare',
                languageController.isToggled.value,
              ),
              controller: controller,
            ),
            _buildNavItem(
              index: 2,
              icon: FontAwesomeIcons.receipt,
              selectedIcon: FontAwesomeIcons.receipt,
              label: BottomNavigationStrings.getString(
                'myOrder',
                languageController.isToggled.value,
              ),
              controller: controller,
            ),
            _buildNavItem(
              index: 3,
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              label: BottomNavigationStrings.getString(
                'myProfile',
                languageController.isToggled.value,
              ),
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon, // now FontAwesomeIcons.*
    required IconData selectedIcon,
    required String label,
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
            FaIcon(
              // ← use FaIcon instead of Icon
              isSelected ? selectedIcon : icon,
              size: 24.0,
              color: color,
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
