import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Core/AppImages.dart';
import '../Core/ColorFile.dart';
import '../colors/order_fonts.dart';
import '../database/user_details_database.dart';
import '../homepage.dart';
import '../information/info.dart';
import '../network/url.dart';
import '../sign_up_screens/signup1.dart';

class OtpScreen extends StatefulWidget {
  final String mobilenumber;
  final int? otp;

  const OtpScreen({super.key, required this.mobilenumber, required this.otp});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final UserDatabaseHelper _dbHelper = UserDatabaseHelper();
  final NetworkChecker _networkChecker = NetworkChecker();
  int _resendTimer = 60; // 60-second timer
  bool _canResend = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _networkChecker.startMonitoring(context);
    startTimer(); // Start the 60-second timer
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _canResend = true;
          _timer.cancel();
        }
      });
    });
  }

  String getTimerText() {
    if (_resendTimer > 0) {
      final minutes = (_resendTimer ~/ 60).toString().padLeft(2, '0');
      final seconds = (_resendTimer % 60).toString().padLeft(2, '0');
      return '00:$seconds';
    }
    return '';
  }

  String maskedNumber(String mobileNumber) {
    if (mobileNumber.length < 4) {
      return mobileNumber;
    }
    return mobileNumber.replaceRange(
      0,
      mobileNumber.length - 4,
      'X' * (mobileNumber.length - 4),
    );
  }

  void _navigateToOTPPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var requestBody = {
      "mobile_number": widget.mobilenumber,
      "otp": _otpController.text,
    };

    print('Request Body: ${jsonEncode(requestBody)}');
    final String url = URLS().verify_otp_apiUrl;
    print('Request URL: $url');

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse != null && jsonResponse['data'] != null) {
          var data = jsonResponse['data'];
          var isNew = data['is_new'];

          if (data['id'] != null) {
            await prefs.setString('customer_id', data['id'].toString());
          }

          await _dbHelper.storeUser({
            'id': data['id'] ?? "",
            'customer_name': data['customer_name'] ?? "",
            'mobile_number': data['mobile_number'] ?? "",
            'email': data['email'] ?? "",
            'village_id': data['village_id'] ?? "",
            'taluka_id': data['taluka_id'] ?? "",
            'state_id': data['state_id'] ?? "",
            'pincode': data['pincode'] ?? "",
          });

          await prefs.setString('mobileNumber', widget.mobilenumber);

          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.white, // Set to solid color to hide background
            builder: (BuildContext context) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pop();
                if (isNew == "0") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const informationscreen(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const HomePage2(customer_id: '', customerId: ''),
                    ),
                  );
                }
              });
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Center(
                  child: Container(
                    width: 285,
                    height: 335,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x42F97316),
                          spreadRadius: 0,
                          blurRadius: 71,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/logout.png',
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.14,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Verification Successful!',
                            textAlign: TextAlign.center,
                            style: AppFontStyle.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF4D4D4D),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Now,complete your profile to enjoy a seamless and personalized experience.',
                            textAlign: TextAlign.center,
                            style: AppFontStyle.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );

          if (isNew == "0") {
            print("New customer: $isNew");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('New customer verified successfully!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            print("Existing customer: $isNew");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('OTP verified.'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid response from server.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to verify OTP. Try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print("Exception occurred during submission: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No internet connection. Please check your network."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _resendOtp() async {
    if (_canResend) {
      final String url = URLS().login_apiUrl;
      final Map<String, dynamic> requestBody = {
        "mobile_number": widget.mobilenumber,
      };

      try {
        print('Resend OTP Request URL: $url');
        print('Resend OTP Request Body: ${jsonEncode(requestBody)}');

        final response = await http.post(
          Uri.parse(url),
          body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json'},
        );

        print('Resend OTP Response: ${response.statusCode}');
        log('Resend OTP Body: ${response.body}');

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200 && jsonResponse['status'] == 'true') {
          final data = jsonResponse['data'];
          final String newOtp = data['otp']?.toString() ?? '';
          final String customerId = data['customer_id']?.toString() ?? '';

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('customer_id', customerId);

          log(' ************New OTP: $newOtp');
          log('***********************Saved Customer ID: $customerId');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("OTP resent successfully."),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          _resendTimer = 60; // Reset timer to 60 seconds
          startTimer(); // Restart the timer
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to resend OTP: ${jsonResponse['message']}"),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print("Exception in resend OTP: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong. Try again."),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text('OTP Verification'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFD9D9D9)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.35, // Adjusted to match image height
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: Image.asset(
                      'assets/images/bhulex login.png',
                      width: screenWidth * 0.5,
                      height: screenHeight * 0.25, // Adjusted to match image
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 27.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter OTP',
                    style: AppFontStyle2.blinker(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: const Color(0xff36322E),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 27.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          'Kindly enter the 4-digit OTP sent to mobile number +91 ',
                      style: AppFontStyle2.blinker(
                        color: AppColors.mobileNumberTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.3,
                      ),
                      children: [
                        TextSpan(
                          text: widget.mobilenumber,
                          style: AppFontStyle2.blinker(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mobileNumberTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    length: 4,
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: PinTheme(
                      width: 58, // Match image design
                      height: 58, // Match image design
                      textStyle: AppFontStyle2.blinker(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        border: Border.all(
                          color: const Color(0xFFD0D0D0),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    separatorBuilder: (index) =>
                        const SizedBox(width: 8), // Match spacing in image
                  ),
                ),
              ),
              const SizedBox(height: 37),
              GestureDetector(
                onTap: () {
                  _navigateToOTPPage();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF26500),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'verify',
                      textAlign: TextAlign.center,
                      style: AppFontStyle2.blinker(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: AppFontStyle2.blinker(
                      color: const Color(0xFF36322E),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: _canResend ? _resendOtp : null,
                    child: Text(
                      _canResend ? "Resend" : getTimerText(),
                      style: AppFontStyle2.blinker(
                        color: const Color(0xFFF26500),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
