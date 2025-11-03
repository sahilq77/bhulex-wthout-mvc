import 'dart:async';
import 'dart:io';
import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:bhulexapp/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_fonts/google_fonts.dart';


class NoInternetPageone extends StatefulWidget {
  final VoidCallback? onRetry;

  const NoInternetPageone({Key? key, this.onRetry}) : super(key: key);

  @override
  _NoInternetPageoneState createState() => _NoInternetPageoneState();
}

class _NoInternetPageoneState extends State<NoInternetPageone>
    with TickerProviderStateMixin {
  final LanguageController languageController = Get.find<LanguageController>();
  bool isChecking = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
bool isToggled = false;
  @override
  void initState() {
    super.initState();
    // Initialize pulse animation for icon
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    // Show snackbar after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showNoInternetSnackBar();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<bool> _checkConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      bool isConnected = !connectivityResult.contains(ConnectivityResult.none);
      if (isConnected) {
        try {
          final result = await InternetAddress.lookup(
            'google.com',
          ).timeout(Duration(seconds: 5));
          isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
        } catch (e) {
          isConnected = false;
        }
      }
      return isConnected;
    } catch (e) {
      return false;
    }
  }

  void _showNoInternetSnackBar() {
    if (!mounted) return;
    _scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          languageController.isToggled.value
              ? 'इंटरनेट कनेक्शन नाही'
              : 'No Internet Connection',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.red.shade600,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
      ),
    );
  }

  void _handleRetry() async {
    if (isChecking) return;
    setState(() {
      isChecking = true;
    });

    bool hasConnection = await _checkConnectivity();
    setState(() {
      isChecking = false;
    });

    if (hasConnection) {
      widget.onRetry?.call();
      Get.back();
      _scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            languageController.isToggled.value
                ? 'इंटरनेट पुन्हा कनेक्ट झाले'
                : 'Internet Reconnected',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.green.shade600,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
        ),
      );
    } else {
      _scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            languageController.isToggled.value
                ? 'कृपया आपले इंटरनेट कनेक्शन तपासा'
                : 'Please check your internet connection',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.red.shade600,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isSmallScreen = screenWidth < 360;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage( isToggled: isToggled, ),
          ),
        );
        return false;
      },
      child: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade50,
                  Colors.white,
                  Colors.orange.shade50,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.05),
                          FadeTransition(
                            opacity: _pulseAnimation,
                            child: ScaleTransition(
                              scale: _pulseAnimation,
                              child: Icon(
                                Icons.wifi_off,
                                size: isSmallScreen ? 70 : 110,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Obx(
                            () => AnimatedOpacity(
                              opacity: 1.0,
                              duration: Duration(milliseconds: 1000),
                              child: Text(
                                languageController.isToggled.value
                                    ? 'इंटरनेट कनेक्शन नाही'
                                    : 'No Internet Connection',
                                style: GoogleFonts.poppins(
                                  fontSize: isSmallScreen ? 18 : 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colorfile.defaultblack,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Obx(
                            () => AnimatedOpacity(
                              opacity: 1.0,
                              duration: Duration(milliseconds: 1200),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.1,
                                ),
                                child: Text(
                                  languageController.isToggled.value
                                      ? 'कृपया आपले इंटरनेट कनेक्शन तपासा आणि पुन्हा प्रयत्न करा'
                                      : 'Please check your internet connection and try again',
                                  style: GoogleFonts.poppins(
                                    fontSize: isSmallScreen ? 10 : 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          AnimatedOpacity(
                            opacity: 1.0,
                            duration: Duration(milliseconds: 1400),
                            child: GestureDetector(
                              onTap: isChecking ? null : _handleRetry,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.1,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: isSmallScreen ? 12 : 16,
                                  horizontal: isSmallScreen ? 20 : 30,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      offset: Offset(4, 4),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-4, -4),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Obx(
                                  () => Text(
                                    isChecking
                                        ? (languageController.isToggled.value
                                            ? 'तपासत आहे...'
                                            : 'Checking...')
                                        : (languageController.isToggled.value
                                            ? 'पुन्हा प्रयत्न'
                                            : 'Retry'),
                                    style: GoogleFonts.poppins(
                                      fontSize: isSmallScreen ? 14 : 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colorfile.bordertheme,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
