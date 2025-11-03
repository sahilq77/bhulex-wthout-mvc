import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/network/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


import 'no_internet_profile.dart';

class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key});

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  String content = '';
  bool isLoading = true;
  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    _loadToggleState();
    fetchDisclaimerContent();
  }

  Future<void> _loadToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        isToggled = prefs.getBool('isToggled') ?? false;
      });
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

  Future<void> fetchDisclaimerContent() async {
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
                  fetchDisclaimerContent(); // Retry fetching data
                },
              ),
        ),
      );
      setState(() {
        isLoading = false;
        content =
            isToggled
                ? '<p>कोणताही डेटा उपलब्ध नाही.</p>'
                : '<p>No data available.</p>';
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? customerId = prefs.getString('customer_id');

      if (customerId == null || customerId.isEmpty) {
        if (mounted) {
          setState(() {
            content =
                isToggled
                    ? '<p>त्रुटी: ग्राहक आयडी सापडला नाही.</p>'
                    : '<p>Error: Customer ID not found.</p>';
            isLoading = false;
          });
        }
        return;
      }

      final String url = URLS().get_disclaimer_apiUrl;
      log('➡ POST Disclaimer API URL: $url');

      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({"customer_id": customerId}),
          )
          .timeout(const Duration(seconds: 10));

      log("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'].toString() == "true") {
          if (mounted) {
            setState(() {
              content =
                  isToggled
                      ? (jsonData['data']['page_content_in_local_language'] ??
                          '<p>कोणताही मजकूर सापडला नाही.</p>')
                      : (jsonData['data']['page_content'] ??
                          '<p>No content found.</p>');
              log('Displayed Content: $content');
            });
          }
        } else {
          if (mounted) {
            setState(() {
              content =
                  isToggled
                      ? '<p>मजकूर लोड करण्यात अयशस्वी.</p>'
                      : '<p>Failed to load content.</p>';
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            content =
                isToggled
                    ? '<p>सर्व्हर त्रुटी: ${response.statusCode}</p>'
                    : '<p>Server error: ${response.statusCode}</p>';
          });
        }
      }
    } catch (e) {
      log("Exception: $e");
      if (mounted) {
        setState(() {
          content =
              isToggled
                  ? '<p>काहीतरी चूक झाली. कृपया पुन्हा प्रयत्न करा.</p>'
                  : '<p>Something went wrong. Please try again.</p>';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    await fetchDisclaimerContent();
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
        title: Text(
          isToggled ? "अस्वीकरण" : "Disclaimer",
          style: AppFontStyle2.blinker(
            fontWeight: FontWeight.w600,
            fontSize: width * 0.050,
            color: const Color(0xFF36322E),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF36322E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              isLoading
                  ? buildShimmer()
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Html(
                        data: content,
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
