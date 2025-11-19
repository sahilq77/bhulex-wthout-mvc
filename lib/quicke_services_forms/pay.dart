import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package

import 'thank_you.dart';

class payscreen extends StatelessWidget {
  final dynamic responseData;

  const payscreen({Key? key, this.responseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay Screen",
          style: GoogleFonts.blinker(),
        ), // Apply Blinker font here
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 285,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Color(0x42F97316),
                spreadRadius: 0,
                blurRadius: 71,
                offset: Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Color(0xFFFCC579), // Border color: #FCC579
              width: 1, // Border width
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logout.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                "Request Submitted",
                textAlign: TextAlign.center,
                style: GoogleFonts.blinker(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4D4D4D),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Order ID : 487489149 ",
                textAlign: TextAlign.center,
                style: GoogleFonts.blinker(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ThankYouPage()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFFFFFFF), // white background
                  side: BorderSide(
                    color: Color(0xFF36322E),
                    width: 1,
                  ), // border color and width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // 6px radius
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ), // optional padding for better appearance
                  minimumSize: Size(
                    double.infinity,
                    0,
                  ), // makes the button width infinite
                ),
                child: Text(
                  "Pay ₹299",
                  style: GoogleFonts.blinker(
                    // Apply Blinker font here
                    color: Color(0xFF36322E), // text color
                    fontSize: 16, // optional font size
                    fontWeight: FontWeight.bold, // optional font weight
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Note section below the pay button
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFFCC579), // background color with opacity
                  borderRadius: BorderRadius.circular(6), // rounded corners
                ),
                child: Text(
                  "We guarantee the delivery of your documents or you’ll receive a 100% refund.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.blinker(
                    // Apply Blinker font here
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF36322E), // text color
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
