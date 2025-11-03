import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Core/apputility.dart';
import '../homepage.dart';

import '../onboarding_screens/onboarding_screen2.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnCustomerId();
  }

  Future<void> _navigateBasedOnCustomerId() async {
    try {
      // Wait for 2 seconds to show splash screen
      await Future.delayed(Duration(seconds: 2));

      // Get SharedPreferences instance
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? customerId = prefs.getString('customer_id');
      if (customerId!.isNotEmpty) {
        AppUtility.login_id = customerId;
      }
      if (mounted) {
        // Check if customerId exists and navigate accordingly
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    customerId != null && customerId.isNotEmpty
                        ? HomePage2(customer_id: '', customerId: '')
                        : OnboardingScreen2(),
          ),
        );
      }
    } catch (e) {
      print('Error during navigation: $e');
      if (mounted) {
        // Fallback navigation to OnboardingScreen1 in case of error
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen2()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bhulex Text
            Image.asset(
              'assets/images/bhulexlogin..png',
              width: 297,
              height: 116,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
