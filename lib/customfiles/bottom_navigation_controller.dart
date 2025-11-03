import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  // Method to reset the index when navigating back
  void resetIndex() {
    selectedIndex.value = 0; // Reset to the home index or any default index
  }
}
