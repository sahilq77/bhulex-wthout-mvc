import 'package:bhulexapp/colors/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../homepage.dart';
import '../profile/profile.dart';
import 'bottom_navigation_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BottomNavigationController controller = Get.put(
    BottomNavigationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(2, 0),
            blurRadius: 25,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.support_agent_outlined),
              label: 'Customer Care',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_document),
              label: 'My Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'My Profile',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colorfile.bordertheme,
          unselectedItemColor: Colorfile.lightgrey,
          onTap: (index) {
            controller.changeIndex(index);
            switch (index) {
              case 0:
                // Navigate to Home
                Get.to(() => HomePage2(customer_id: '', customerId: '', ));
                break;
              case 1:
                // Navigate to Customer Care
                // Get.to(() => CustomerCarePage());
                break;
              case 2:
                // Navigate to My Order
                // Get.to(() => MyOrderScreen(package_id: '', customer_id: ''));
                break;
              case 3:
                // Navigate to Profile
                Get.to(() => const ProfilePage(isToggled: false));
                break;
            }
          },
          showUnselectedLabels: true,
          showSelectedLabels: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}
