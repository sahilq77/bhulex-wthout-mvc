import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/profile/no_internet_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AboutBhulexPage extends StatefulWidget {
  const AboutBhulexPage({super.key});

  @override
  _AboutBhulexPageState createState() => _AboutBhulexPageState();
}

class _AboutBhulexPageState extends State<AboutBhulexPage> {
  String aboutHtmlContent = '';
  String pageHeading = '';
  bool isLoading = true;
  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    _loadToggleState();
    fetchAboutUs();
  }

  Future<void> _loadToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isToggled = prefs.getBool('isToggled') ?? false;
    });
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

  Future<void> fetchAboutUs() async {
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
                  fetchAboutUs(); // Retry fetching data
                },
              ),
        ),
      );
      setState(() {
        isLoading = false;
        aboutHtmlContent =
            isToggled
                ? '<p>कोणताही डेटा उपलब्ध नाही.</p>'
                : '<p>No data available.</p>';
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    const String url = "https://seekhelp.in/bhulex/get_about_us";
    log('➡ GET About Us API URL: $url');

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 10));

      log("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'].toString() == "true") {
          setState(() {
            aboutHtmlContent =
                isToggled
                    ? (jsonData['data']['page_content_in_local_language'] ??
                        '<p>स्थानिक भाषेत सामग्री उपलब्ध नाही.</p>')
                    : (jsonData['data']['page_content'] ??
                        '<p>No content available.</p>');
            pageHeading =
                isToggled
                    ? (jsonData['data']['page_heading_in_local_language'] ??
                        'आमच्याबद्दल')
                    : (jsonData['data']['page_heading'] ?? 'About us');
          });
        } else {
          setState(() {
            aboutHtmlContent =
                isToggled
                    ? '<p>सामग्री लोड करण्यात अयशस्वी.</p>'
                    : '<p>Failed to load content.</p>';
            pageHeading = isToggled ? 'आमच्याबद्दल' : 'About us';
          });
        }
      } else {
        setState(() {
          aboutHtmlContent =
              isToggled
                  ? '<p>सर्व्हर त्रुटी: ${response.statusCode}</p>'
                  : '<p>Server error: ${response.statusCode}</p>';
          pageHeading = isToggled ? 'आमच्याबद्दल' : 'About us';
        });
      }
    } catch (e) {
      log("Exception: $e");
      setState(() {
        aboutHtmlContent =
            isToggled
                ? '<p>काहीतरी चूक झाली. कृपया पुन्हा प्रयत्न करा.</p>'
                : '<p>Something went wrong. Please try again.</p>';
        pageHeading = isToggled ? 'आमच्याबद्दल' : 'About us';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    await fetchAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFD),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFF36322E),
            size: width * 0.06,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isToggled ? "आमच्याबद्दल" : "About",
          style: AppFontStyle2.blinker(
            fontWeight: FontWeight.w600,
            fontSize: width * 0.050,
            color: const Color(0xFF36322E),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child:
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Html(
                        data: aboutHtmlContent,
                        style: {
                          "body": Style(
                            fontFamily: 'blinker',
                            fontSize: FontSize(width * 0.04),
                            color: const Color(0xFF36322E),
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

