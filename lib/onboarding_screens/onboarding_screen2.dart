import 'package:flutter/material.dart';

import '../colors/custom_color.dart';
import '../colors/order_fonts.dart';
import 'onboarding_screen3.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth,
            height: screenHeight, // Ensures content fits within screen height
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Section (Logo and Text)
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.04),
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        'assets/images/bhulexlogin..png',
                        width: screenWidth * 0.44,
                        height: screenHeight * 0.08,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Title Text 1
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'One Stop Solution for all ',
                                style: TextStyle(
                                  fontFamily: 'blinker',
                                  fontSize: screenWidth *
                                      0.07, // Responsive font size
                                  fontWeight: FontWeight.w900, // Bold
                                  height: 1.3,
                                  color: const Color(0xFF464646), // Black
                                ),
                              ),
                              TextSpan(
                                text: 'Legal Property Documents',
                                style: TextStyle(
                                  fontFamily: 'blinker',
                                  fontSize: screenWidth *
                                      0.07, // Match font size for consistency
                                  fontWeight: FontWeight.w900, // Bold
                                  height: 1.3,
                                  color: const Color(0xFFF57C03), // Orange
                                ),
                              ),
                            ],
                          ),
                          softWrap: true,
                        ),
                      ),
                      // Description Text
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.01,
                        ),
                        width: screenWidth * 0.9,
                        child: Text(
                          'Get Quick And Reliable Access To Essential Land Records, '
                          'Registered Legal Documents And Other Property Documents '
                          'With Expert Legal Support.',
                          textAlign: TextAlign.center,
                          style: AppFontStyle.poppins(
                            fontSize: screenWidth * 0.028,
                            fontWeight: FontWeight.w400,
                            height: 1.67,
                            color: const Color(0xFF36322E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Middle Section (Image)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                    ),
                    child: Image.asset(
                      'assets/images/onboardingtwo.png',
                      width: screenWidth * 0.95,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Bottom Section (Button)
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.08),
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen3(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colorfile.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Next',
                        style: AppFontStyle2.blinker(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}