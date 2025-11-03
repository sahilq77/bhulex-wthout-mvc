// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../sign_up_screens/signup1.dart';
// import 'onboarding_screen3.dart';

// class OnboardingScreen2 extends StatelessWidget {
//   const OnboardingScreen2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SizedBox(
//           width: double.infinity,
//           height: double.infinity,
//           child: Stack(
//             children: [
//               // Top Center Image
//               Positioned(
//                 top: screenHeight * 0.06, // 50px scaled to 6% of screen height
//                 left:
//                     (screenWidth - (screenWidth * 0.42)) /
//                     2, // 175px as 42% of screen width
//                 child: Image.asset(
//                   'assets/images/bhulexlogo.png',
//                   width: screenWidth * 0.42, // 166px scaled proportionally
//                   height: screenHeight * 0.08, // 64px scaled proportionally
//                   fit: BoxFit.contain,
//                 ),
//               ),

//               // First Text (Centered)
//               Positioned(
//                 top: screenHeight * 0.17,
//                 left:
//                     (screenWidth - (screenWidth * 0.9)) /
//                     2, // 356px as 90% of screen width
//                 child: Container(
//                   width: screenWidth * 0.9, // Responsive width
//                   alignment: Alignment.center,
//                   child: Text(
//                     'One Stop Solution for all',
//                     textAlign: TextAlign.center,
//                     softWrap: true,
//                     style: GoogleFonts.poppins(
//                       fontSize: screenWidth * 0.07, // 28px scaled (adjustable)
//                       fontWeight: FontWeight.w700,
//                       height: 1.3,
//                       letterSpacing: 0,
//                       color: const Color(0xFF464646),
//                     ),
//                   ),
//                 ),
//               ),

//               // Second Text (Centered)
//               Positioned(
//                 top: screenHeight * 0.21,
//                 left:
//                     (screenWidth - (screenWidth * 0.9)) /
//                     2, // 356px as 90% of screen width
//                 child: Container(
//                   width: screenWidth * 0.9, // Responsive width
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Legal Property Documents',
//                     textAlign: TextAlign.center,
//                     softWrap: true,
//                     style: GoogleFonts.poppins(
//                       fontSize: screenWidth * 0.065, // 26px scaled (adjustable)
//                       fontWeight: FontWeight.w700,
//                       height: 1.3,
//                       letterSpacing: 0,
//                       color: const Color(0xFFF57C03),
//                     ),
//                   ),
//                 ),
//               ),

//               // Description Text (Centered)
//               Positioned(
//                 top: screenHeight * 0.24,
//                 left:
//                     (screenWidth - (screenWidth * 0.9)) /
//                     2, // 356px as 90% of screen width
//                 child: Container(
//                   width: screenWidth * 0.9, // Responsive width
//                   height:
//                       screenHeight * 0.1, // 75px scaled to 10% of screen height
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Get Quick And Reliable Access To Essential Land Records, '
//                     'Registered Legal Documents And Other Property Documents '
//                     'With Expert Legal Support.',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
//                       fontSize:
//                           screenWidth * 0.028, // 11.2px scaled (adjustable)
//                       fontWeight: FontWeight.w400,
//                       height: 1.67,
//                       color: const Color(0xFF36322E),
//                     ),
//                   ),
//                 ),
//               ),

//               // Bottom Center Image
//               Positioned(
//                 top:
//                     screenHeight * 0.30, // 290px scaled to 35% of screen height
//                 left:
//                     screenWidth * 0.025, // 10px scaled to 2.5% of screen width
//                 child: Image.asset(
//                   'assets/images/onboardingtwo.png',
//                   width:
//                       screenWidth * 0.95, // 396px scaled to 95% of screen width
//                   height:
//                       screenHeight *
//                       0.58, // 449px scaled to 55% of screen height
//                   fit: BoxFit.contain,
//                 ),
//               ),

//               // Get Started Button
//               Positioned(
//                 bottom: screenHeight * 0.05,
//                 left:
//                     (screenWidth - (screenWidth * 0.38)) /
//                     2, // 150px as 38% of screen width
//                 child: SizedBox(
//                   width: screenWidth * 0.38, // 150px scaled proportionally
//                   height: screenHeight * 0.07, // 54px scaled proportionally
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const OnboardingScreen3(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFF57C03),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(28),
//                       ),
//                       elevation: 5,
//                     ),
//                     child: Text(
//                       'Next',
//                       style: GoogleFonts.poppins(
//                         fontSize:
//                             screenWidth * 0.04, // 16px scaled (adjustable)
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../sign_up_screens/signup1.dart';
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
                                  fontSize:
                                      screenWidth *
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
                                  fontSize:
                                      screenWidth *
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
                    width: screenWidth * 0.58,
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
                        backgroundColor: const Color(0xFFF57C03),
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
