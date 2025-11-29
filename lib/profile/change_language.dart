import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:bhulexapp/homepage.dart';
import 'package:bhulexapp/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Custom class for styling (consistent with previous pages)
class BhulexStyle {
  static const String fontFamily = 'Poppins';

  static TextStyle appBarTitle(double width) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight:
          FontWeight.w600, // Matches ChangeLanguageScreen's original style
      fontSize: width * 0.050, // Adjusted to 22 / 400 (assuming width ~400)
      color: const Color(0xFF36322E),
    );
  }

  static TextStyle bodyTitle(double width) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600, // Matches "Select Your Language" style
      fontSize: width * 0.045, // Adjusted to 22 / 400
      color: const Color(0xFF36322E),
    );
  }

  static TextStyle languageOptionText(double width) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500, // Matches language option style
      fontSize: width * 0.038, // Adjusted to 14 / 400
      color: const Color(0xFF36322E),
    );
  }

  static TextStyle dialogTitle(double width) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: width * 0.045, // Slightly smaller than appBarTitle for dialog
      color: const Color(0xFF36322E),
    );
  }

  static TextStyle dialogContent(double width) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: width * 0.035, // Adjusted for readability
      color: const Color(0xFF36322E),
    );
  }

  static TextStyle dialogButton(double width) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: width * 0.035, // Adjusted for readability
      color: const Color(0xFF36322E),
    );
  }

  static IconThemeData iconStyle(double width) {
    return IconThemeData(color: const Color(0xFF36322E), size: width * 0.06);
  }

  static const Color backgroundColor = Color(0xFFFDFDFD);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bhulex',
      home: ChangeLanguageScreen(),
    );
  }
}

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  bool isToggled = false;
  final LanguageController languageController = Get.put(LanguageController());

  @override
  void initState() {
    super.initState();
    _loadToggleState();
  }

  Future<void> _loadToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isToggled = prefs.getBool('isToggled') ?? false;
    });
  }

  Future<void> _saveToggleState(bool value) async {
    languageController.toggleLanguage(value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isToggled', value);
    setState(() {
      isToggled = value;
    });
  }

  Future<bool> _onWilPop() async {
    final width = MediaQuery.of(context).size.width;
    bool? shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isToggled ? 'बाहेर पडायचे?' : 'Exit?',
          style: BhulexStyle.dialogTitle(width), // Using custom class
        ),
        content: Text(
          isToggled
              ? 'आपण खात्रीशीर आहात की आपण बाहेर पडू इच्छिता?'
              : 'Are you sure you want to exit?',
          style: BhulexStyle.dialogContent(width), // Using custom class
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Cancel
            child: Text(
              isToggled ? 'नाही' : 'No',
              style: BhulexStyle.dialogButton(width), // Using custom class
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // Confirm
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomePage2(customer_id: '', customerId: ''),
                ),
              );
            },
            child: Text(
              isToggled ? 'होय' : 'Yes',
              style: BhulexStyle.dialogButton(width), // Using custom class
            ),
          ),
        ],
      ),
    );

    return shouldPop ?? false; // Default to not popping if dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: BhulexStyle.backgroundColor, // Using custom class
      appBar: AppBar(
        backgroundColor: BhulexStyle.backgroundColor, // Using custom class
        elevation: 0,
        title: Text(
          isToggled ? "भाषा बदला" : "Change Language",
          style: BhulexStyle.appBarTitle(width), // Using custom class
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Divider(color: Colorfile.border, height: 0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isToggled ? "तुमची भाषा निवडा" : "Select Your Language",
              style: BhulexStyle.bodyTitle(width), // Using custom class
            ),
            SizedBox(height: 20),
            Obx(
              () => _buildLanguageOption(
                languageController.isToggled.value ? "इंग्रजी" : "English",
                !languageController.isToggled.value,
                () {
                  _saveToggleState(false);
                },
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => _buildLanguageOption(
                languageController.isToggled.value ? "मराठी" : "Marathi",
                languageController.isToggled.value,
                () {
                  _saveToggleState(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    String language,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 368,
        height: 58,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFE5E7EB), width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: BhulexStyle.languageOptionText(
                width,
              ), // Using custom class
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFFF26500) : Color(0xFFB0B0B0),
            ),
          ],
        ),
      ),
    );
  }
}
