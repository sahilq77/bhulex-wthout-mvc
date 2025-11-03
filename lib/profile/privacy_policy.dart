import 'dart:async';
import 'dart:convert';
import 'dart:developer' show log;
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:bhulexapp/network/url.dart';
import 'package:bhulexapp/profile/no_internet_profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  String privacyHtmlContent = '';
  bool isLoading = true;
  bool isToggled = false; // Language toggle state
  final LanguageController languageController = Get.find<LanguageController>();

  @override
  void initState() {
    super.initState();
    _loadToggleState();
  }

  Future<void> _loadToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        isToggled = prefs.getBool('isToggled') ?? false;
      });
      await fetchPrivacyPolicy();
    }
  }
 Future<bool> _checkConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      return !connectivityResult.contains(ConnectivityResult.none);
    } catch (e) {
      log('Connectivity check error: $e');
      return false;
    }
  }
 Future<void> fetchPrivacyPolicy() async {
    if (!mounted) return;

    // Check connectivity
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => NoInternetPageone(
                onRetry: () {
                  fetchPrivacyPolicy(); // Retry fetching data
                },
              ),
        ),
      );
  
    }

    setState(() {
      isLoading = true;
    });

    final String url = URLS().get_privacy_apiUrl;
    log('➡ GET Privacy Policy API URL: $url');

    try {
      final response = await http.get(Uri.parse(url));

      log("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'].toString() == "true") {
          setState(() {
            privacyHtmlContent =
                isToggled
                    ? (jsonData['data']['page_content_in_local_language'] ??
                        '<p>कोणताही मजकूर उपलब्ध नाही.</p>')
                    : (jsonData['data']['page_content'] ??
                        '<p>No content available.</p>');
            log('Displayed Content: $privacyHtmlContent');
          });
        } else {
          setState(() {
            privacyHtmlContent =
                isToggled
                    ? '<p>मजकूर लोड करण्यात अयशस्वी.</p>'
                    : '<p>Failed to load content.</p>';
          });
        }
      } else {
        setState(() {
          privacyHtmlContent =
              isToggled
                  ? '<p>सर्व्हर त्रुटी: ${response.statusCode}</p>'
                  : '<p>Server error: ${response.statusCode}</p>';
        });
      }
    } catch (e) {
      setState(() {
        privacyHtmlContent =
            isToggled
                ? '<p>काहीतरी चूक झाली. कृपया पुन्हा प्रयत्न करा.</p>'
                : '<p>Something went wrong. Please try again.</p>';
      });
      log("Exception: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    await fetchPrivacyPolicy();
  }

  Widget buildShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(8, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 18,
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFD),
        elevation: 0,
        title: Obx(
          () => Text(
            languageController.isToggled.value
                ? "गोपनीयता धोरण"
                : "Privacy Policy",
            style: AppFontStyle2.blinker(
              fontWeight: FontWeight.w600,
              fontSize: width * 0.050,
              color: Color(0xFF36322E),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF36322E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: isLoading
              ? buildShimmer()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Html(
                      data: privacyHtmlContent,
                      style: {
                        "body": Style(
                          fontFamily: 'blinker',
                          fontSize: FontSize(width * 0.04),
                          color: const Color(0xFF36322E),
                          lineHeight: const LineHeight(1.5),
                          textAlign: TextAlign.center,
                        ),
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}