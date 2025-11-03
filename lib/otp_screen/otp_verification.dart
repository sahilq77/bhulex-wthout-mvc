import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0.0,
        leading: IconButton(
          icon: Image.asset('assets/eva_arrow-back-fill.png'),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder:
            //         (context) => const OtpScreen(mobilenumber: '', otp: 'null',),
            //   ),
            // );
          },
        ),
        title: Text(
          'OTP Verification',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            height: 16 / 18,
            letterSpacing: 0,
            textStyle: const TextStyle(textBaseline: TextBaseline.alphabetic),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFD9D9D9)),
        ),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.8, // 80% of screen width
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Color(0x42F97316), // #F97316 with 26% opacity (0x42)
                spreadRadius: 0,
                blurRadius: 71,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Shrink to fit content
            children: [
              // Image
              Image.asset(
                'assets/images/logout.png', // Replace with your image path
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 20), // Spacing
              // Verification Message Text
              Text(
                'Verification Successful!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4D4D4D), // Green color
                ),
              ),

              SizedBox(height: 10), // Spacing
              // Additional Message Below
              Text(
                'Now, complete your profile to enjoy a seamless and personalized experience.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700], // Soft grey color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
