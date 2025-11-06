import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/controller/order/language%20controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../no internet.dart';
import 'no_internet_profile.dart';

class HelpSupportPage extends StatefulWidget {
  @override
  _HelpSupportPageState createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  String _content = '';
  bool _isLoading = true;
  bool isToggled = false; // Language toggle state
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerStateKey =
      GlobalKey<ScaffoldMessengerState>();
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
      await fetchHelpContent(); // Fetch content after setting toggle state
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

  Future<void> fetchHelpContent() async {
    if (!mounted) return;

    // Check connectivity
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoInternetPageone(
            onRetry: () {
              fetchHelpContent(); // Retry fetching data
            },
          ),
        ),
      );
      setState(() {
        _isLoading = false;
        _content = isToggled
            ? '<p>कोणताही डेटा उपलब्ध नाही.</p>'
            : '<p>No data available.</p>';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? customerId = prefs.getString('customer_id');

      if (customerId == null || customerId.isEmpty) {
        if (mounted) {
          setState(() {
            _content = isToggled
                ? '<p>त्रुटी: ग्राहक आयडी सापडला नाही.</p>'
                : '<p>Error: Customer ID not found.</p>';
            _isLoading = false;
          });
        }
        return;
      }

      const String url = 'https://seekhelp.in/bhulex/get_help_support';
      print('➡ POST Help Support API URL: $url');

      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({"customer_id": customerId}),
          )
          .timeout(const Duration(seconds: 10));

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'].toString() == "true") {
          if (mounted) {
            setState(() {
              _content = isToggled
                  ? (jsonData['data']['page_content_in_local_language'] ??
                        '<p>कोणताही मजकूर सापडला नाही.</p>')
                  : (jsonData['data']['page_content'] ??
                        '<p>No content found.</p>');
              print('Displayed Content: $_content');
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _content = isToggled
                  ? '<p>मजकूर लोड करण्यात अयशस्वी.</p>'
                  : '<p>Failed to load content.</p>';
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _content = isToggled
                ? '<p>सर्व्हर त्रुटी: ${response.statusCode}</p>'
                : '<p>Server error: ${response.statusCode}</p>';
          });
        }
      }
    } catch (e) {
      log("Exception: $e");
      if (mounted) {
        setState(() {
          _content = isToggled
              ? '<p>काहीतरी चूक झाली. कृपया पुन्हा प्रयत्न करा.</p>'
              : '<p>Something went wrong. Please try again.</p>';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    await fetchHelpContent();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            languageController.isToggled.value
                ? 'मदत आणि समर्थन'
                : 'Help and Support',
            style: AppFontStyle2.blinker(
              fontWeight: FontWeight.w600,
              fontSize: width * 0.045,
              color: Color(0xFF36322E),
            ),
          ),
        ),

        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Divider(color: Colorfile.border, height: 0),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Html(
                      data: _content,
                      style: {
                        "body": Style(
                          fontFamily: 'blinker',
                          fontSize: FontSize(16.0),
                          color: Color(0xFF36322E),
                          textAlign: TextAlign.start,
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
