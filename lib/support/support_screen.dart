// support_page.dart
import 'dart:developer';
import 'package:bhulexapp/bottom_navigation/main_bottom_navigation.screen.dart';
import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/controller/bottom_navigation/bottom_navigation_controller.dart';
import 'package:bhulexapp/profile/no_internet_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  String supportHtmlContent = '';
  String pageHeading = '';
  bool isLoading = true;
  bool isToggled = false;

  // Add this to cancel delayed calls
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _loadToggleState();
    // Use Future.microtask or direct call with mounted check
    Future.microtask(() => fetchSupportDummy());
  }

  @override
  void dispose() {
    _isDisposed = true; // Mark as disposed
    super.dispose();
  }

  Future<void> _loadToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted || _isDisposed) return;
    setState(() {
      isToggled = prefs.getBool('isToggled') ?? false;
    });
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  Future<void> fetchSupportDummy() async {
    if (_isDisposed || !mounted) return; // Critical: early exit

    bool isConnected = await _checkConnectivity();
    if (!mounted || _isDisposed) return;

    if (!isConnected) {
      if (!mounted || _isDisposed) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoInternetPageone(onRetry: fetchSupportDummy),
        ),
      );
      if (mounted && !_isDisposed) {
        setState(() => isLoading = false);
      }
      return;
    }

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    if (_isDisposed || !mounted) return; // Check again after await!

    setState(() {
      isLoading = false;
      if (isToggled) {
        pageHeading = "सपोर्ट";
        supportHtmlContent = """
        <h2>आम्ही कशी मदत करू शकतो?</h2>
        <p>तुम्हाला कोणत्याही समस्या आल्यास आमच्या सपोर्ट टीमशी संपर्क साधा.</p>
        ...
        """;
      } else {
        pageHeading = "Support";
        supportHtmlContent = """
        <h2>How can we help you?</h2>
        <p>Having any issue? Reach out to our support team anytime.</p>
        ...
        """;
      }
    });
  }

  Future<void> _onRefresh() async {
    if (_isDisposed || !mounted) return;
    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted && !_isDisposed) {
      await fetchSupportDummy();
    }
  }

  final bottomController = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        if (_isDisposed) return true;
        print(
          'WillPopScope triggered, selectedIndex: ${bottomController.selectedIndex.value}',
        );
        bottomController.selectedIndex.value = 0;
        bottomController.goToHome();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colorfile.background,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFDFDFD),
          elevation: 0,
          title: Text(
            pageHeading.isNotEmpty
                ? pageHeading
                : (isToggled ? "सपोर्ट" : "Support"),
            style: AppFontStyle2.blinker(
              fontWeight: FontWeight.w600,
              fontSize: width * 0.050,
              color: const Color(0xFF36322E),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Divider(color: Colorfile.border, height: 0),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: isLoading
                ? const SizedBox(
                    height: 400,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    children: [
                      Html(
                        data: supportHtmlContent,
                        style: {
                          "body": Style(
                            fontFamily: 'blinker',
                            fontSize: FontSize(width * 0.04),
                            color: const Color(0xFF36322E),
                          ),
                          "a": Style(
                            color: Colors.blue,
                            textDecoration: TextDecoration.underline,
                          ),
                          "h2": Style(
                            fontSize: FontSize(width * 0.055),
                            fontWeight: FontWeight.bold,
                          ),
                          "h3": Style(
                            fontSize: FontSize(width * 0.045),
                            fontWeight: FontWeight.bold,
                          ),
                        },
                        onLinkTap: (url, _, __) {
                          if (mounted) log("Opening link: $url");
                        },
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
          ),
        ),
        bottomNavigationBar: const CustomBottomBar(), // assuming it's stateless
      ),
    );
  }
}
