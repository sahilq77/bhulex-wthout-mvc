import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Core/AppImages.dart';
import '../Core/ColorFile.dart';
import '../Core/apputility.dart';
import '../colors/order_fonts.dart';
import '../network/url.dart';
import '../onboarding_screens/onboarding_screen3.dart';
import '../otp_screen/otp_screen.dart';

class Signup1 extends StatefulWidget {
  const Signup1({super.key});

  @override
  _Signup1State createState() => _Signup1State();
}

class _Signup1State extends State<Signup1> {
  bool isChecked = false;
  bool isDisclaimerChecked = false;
  int? otp;
  TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _navigateToOTPPage() async {
    if (isLoading) return;

    String phoneNumber = mobileController.text.trim();

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your mobile number',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (phoneNumber.length != 10 ||
        !RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid 10-digit mobile number',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var requestBody = {"mobile_number": phoneNumber};
      log('Request Body: ${jsonEncode(requestBody)}');
      final String url = URLS().login_apiUrl;
      log('Request URL: $url');

      var response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(requestBody),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse != null && jsonResponse['data'] != null) {
          await prefs.setString('mobileNumber', phoneNumber);
          setState(() {
            otp = jsonResponse['data']['otp'] ?? '';
            log("OTP: $otp");
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtpScreen(mobilenumber: phoneNumber, otp: otp),
            ),
          );
          var data = jsonResponse['data'];
          var isNew = data['is_new'] ?? false;
          var customerId = data['customer_id'] ?? '';
          if (customerId.isNotEmpty) {
            AppUtility.login_id = customerId;
          }
          await prefs.setBool('is_new', isNew);
          await prefs.setString('customer_id', customerId.toString());
          log('Saved Customer ID: $customerId');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'OTP sent successfully!',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: const Duration(milliseconds: 200),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to get OTP. Please try again.',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Server error. Please try again later.',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } on SocketException {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No internet connection. Please check your network.',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } on TimeoutException {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Request timed out. Please try again.',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          title: Text(
            'Login/Sign Up',
            style: AppFontStyle2.blinker(
              fontWeight: FontWeight.w600,
              fontSize: 19,
              height: 16 / 18,
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFD9D9D9)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.45,
                child: Center(
                  child: Image.asset(
                    AppImages.loginImage,
                    width: screenWidth * 0.60,
                    height: screenHeight * 0.30,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Start Your Safe Hassle Free Journey!',
                    textAlign: TextAlign.left,
                    style: AppFontStyle2.blinker(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF36322E),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your mobile number for OTP Verification.',
                    style: AppFontStyle2.blinker(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF595959),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFFD0D0D0),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(AppImages.call, height: 20, width: 20),
                          const SizedBox(width: 10),
                          Container(
                            width: 1,
                            height: 40,
                            color: const Color(0xFFD0D0D0),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: mobileController,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              style: AppFontStyle2.blinker(fontSize: 17),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your mobile number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.length == 10) {
                                  FocusScope.of(context).unfocus();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor: AppColors.checkBoxColor,
                      checkColor: Colors.white,
                      side: const BorderSide(
                        color: AppColors
                            .checkBoxBorderColor, // Light gray color for border
                        width: 2.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          'A 4 digit security code will be sent via SMS to verify your mobile number!',
                          style: AppFontStyle2.blinker(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF36322E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isDisclaimerChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isDisclaimerChecked = value!;
                        });
                      },
                      activeColor: AppColors.checkBoxColor,
                      checkColor: Colors.white,
                      side: BorderSide(
                        color: AppColors
                            .checkBoxBorderColor, // Light gray color for border
                        width: 2.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          'Disclaimer: Bhulex is not government-affiliated. We do not represent the Government of State of Maharashtra and its entities that provides the data.',
                          style: AppFontStyle2.blinker(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF36322E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF26500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          if (isChecked && isDisclaimerChecked) {
                            _navigateToOTPPage();
                          } else {
                            String message = '';
                            if (!isChecked && !isDisclaimerChecked) {
                              message =
                                  'Please verify your mobile number and agree to the Disclaimer!';
                            } else if (!isChecked) {
                              message = 'Please verify your mobile number!';
                            } else {
                              message = 'Please agree to the Disclaimer!';
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  message,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }
                        },
                  child: Center(
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Get OTP',
                            style: AppFontStyle2.blinker(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
