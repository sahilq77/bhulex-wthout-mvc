import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../sign_up_screens/signup1.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              // Top Center Image
              Positioned(
                top: screenHeight * 0.05, // 50px scaled to 6% of screen height
                left:
                    (screenWidth - (screenWidth * 0.44)) /
                    2, // 175px as 42% of screen width
                child: Image.asset(
                  'assets/images/bhulexlogin..png',
                  width: screenWidth * 0.42, // 166px scaled proportionally
                  height: screenHeight * 0.08, // 64px scaled proportionally
                  fit: BoxFit.contain,
                ),
              ),

              // First Text (Centered)
              Positioned(
                top: screenHeight * 0.15,
                left: (screenWidth - (screenWidth * 0.9)) / 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  width: screenWidth * 0.9,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Simplifying Land Record Management For Entire\n',
                          style: TextStyle(
                            fontFamily: 'blinker',
                            fontSize:
                                screenWidth * 0.07, // Responsive font size
                            fontWeight: FontWeight.w900, // Bold
                            height: 1.3,
                            color: const Color(0xFF464646), // Dark gray
                          ),
                        ),
                        TextSpan(
                          text: 'STATE OF MAHARASHTRA',
                          style: TextStyle(
                            fontFamily: 'blinker',
                            fontSize:
                                screenWidth * 0.06, // Consistent font size
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
              ),

              // Bottom Center Image
              Positioned(
                top:
                    screenHeight * 0.30, // 270px scaled to 33% of screen height
                left: screenWidth * 0.02, // 8px scaled to 2% of screen width
                child: Image.asset(
                  'assets/images/map.png',
                  width:
                      screenWidth * 0.97, // 401px scaled to 97% of screen width
                  height:
                      screenHeight *
                      0.55, // 442px scaled to 55% of screen height
                  fit: BoxFit.contain,
                ),
              ),

              // Get Started Button
              Positioned(
                bottom: screenHeight * 0.04,
                left:
                    (screenWidth - (screenWidth * 0.58)) /
                    2, // 240px as 58% of screen width
                child: SizedBox(
                  width: screenWidth * 0.58, // 230px scaled proportionally
                  height: screenHeight * 0.06, // 54px scaled proportionally
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Signup1(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFFF57C03,
                      ), // Orange background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Get Started',
                      style: AppFontStyle2.blinker(
                        fontSize: screenWidth * 0.05, // 16px scaled
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
    );
  }
}
