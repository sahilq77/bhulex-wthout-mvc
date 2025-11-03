import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/network/url.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'no_internet_profile.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  String content = '';
  bool isLoading = true;
  bool isToggled = false; // Language toggle state
  bool hasConnection = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _loadToggleState();
    // Delay connectivity check until widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initConnectivity();
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  void _initConnectivity() {
    // Check initial connectivity
    _checkConnectivity().then((isConnected) {
      if (!mounted) return;
      setState(() {
        hasConnection = isConnected;
      });
      fetchTermsConditions();
    });

    // Listen for connectivity changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _checkConnectivity().then((isConnected) {
        if (!mounted) return;
        if (isConnected != hasConnection) {
          setState(() {
            hasConnection = isConnected;
          });
          if (!hasConnection) {
            _showNoInternetPopup();
          } else {
            _showConnectionRestoredPopup();
          }
        }
      });
    });
  }

  Future<bool> _checkConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      bool isConnected = !connectivityResult.contains(ConnectivityResult.none);
      if (isConnected) {
        isConnected = await _hasInternet();
      }
      log('Connectivity check: isConnected=$isConnected');
      return isConnected;
    } catch (e) {
      log('Connectivity check error: $e');
      return false;
    }
  }

  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      log('Internet check failed: $e');
      return false;
    }
  }

  void _showNoInternetPopup() {
    if (!mounted) return;
    _scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          isToggled ? 'इंटरनेट कनेक्शन नाही' : 'No internet connection',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: isToggled ? 'पुन्हा प्रयत्न' : 'Retry',
          textColor: Colors.white,
          onPressed: () async {
            bool isConnected = await _checkConnectivity();
            if (!mounted) return;
            setState(() {
              hasConnection = isConnected;
            });
            if (isConnected) {
              _showConnectionRestoredPopup();
            } else {
              _showNoInternetPopup();
            }
          },
        ),
      ),
    );
  }

  void _showConnectionRestoredPopup() {
    if (!mounted) return;
    _scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          isToggled ? 'इंटरनेट कनेक्शन पुनर्स्थापित' : 'Connection restored',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    // Auto-refresh content after showing popup
    Future.delayed(Duration(milliseconds: 100), () {
      if (mounted) {
        fetchTermsConditions();
      }
    });
  }

  Future<void> _loadToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isToggled = prefs.getBool('isToggled') ?? false;
    });
    // Fetch content after setting toggle state (moved to _initConnectivity)
  }

  Future<void> fetchTermsConditions() async {
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
                  fetchTermsConditions(); // Retry fetching data
                },
              ),
        ),
      );
  
    }

    setState(() {
      isLoading = true;
    });

    final String url = URLS().get_terms_apiUrl;
    log('➡ GET Terms and Conditions API URL: $url');

    try {
      final response = await http.get(Uri.parse(url));

      log("📥 Status Code: ${response.statusCode}");
      log("📥 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'].toString() == "true") {
          setState(() {
            content =
                isToggled
                    ? (jsonData['data']['page_content_in_local_language'] ??
                        '<p>कोणताही मजकूर सापडला नाही.</p>')
                    : (jsonData['data']['page_content'] ??
                        '<p>No content found.</p>');
            log('Displayed Content: $content');
          });
        } else {
          setState(() {
            content =
                isToggled
                    ? '<p>मजकूर लोड करण्यात अयशस्वी.</p>'
                    : '<p>Failed to load content.</p>';
          });
        }
    } else {
        setState(() {
          content =
              isToggled
                  ? '<p>सर्व्हर त्रुटी: ${response.statusCode}</p>'
                  : '<p>Server error: ${response.statusCode}</p>';
        });
      }
    } catch (e) {
      setState(() {
        content =
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
    await fetchTermsConditions();
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

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: const Color(0xFFFDFDFD),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFDFDFD),
          elevation: 0,
          title: Text(
            isToggled ? "अटी आणि शर्ती" : "Terms and Conditions",
            style: AppFontStyle.poppins(
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
        // body: RefreshIndicator(
        //   onRefresh: _onRefresh,
        //   child: SingleChildScrollView(
        //     physics: const AlwaysScrollableScrollPhysics(),
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //     child:
        //         isLoading
        //             ? buildShimmer()
        //             : Center(
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   if (!hasConnection)
        //                     Container(
        //                       padding: EdgeInsets.symmetric(
        //                         vertical: 8,
        //                         horizontal: 12,
        //                       ),
        //                       decoration: BoxDecoration(
        //                         color: Colors.red.withOpacity(0.1),
        //                         borderRadius: BorderRadius.circular(8),
        //                         border: Border.all(color: Colors.red, width: 1),
        //                       ),
        //                       child: Row(
        //                         mainAxisSize: MainAxisSize.min,
        //                         children: [
        //                           Icon(
        //                             Icons.cancel,
        //                             color: Colors.red,
        //                             size: 20,
        //                           ),
        //                           SizedBox(width: 8),
        //                           Text(
        //                             isToggled ? 'इंटरनेट नाही' : 'No Internet',
        //                             style: AppFontStyle.poppins(
        //                               fontSize: width * 0.035,
        //                               color: Colors.red,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   if (!hasConnection) SizedBox(height: 16),
        //                   Html(
        //                     data: content,
        //                     style: {
        //                       "body": Style(
        //                         fontFamily: 'Poppins',
        //                         fontSize: FontSize(width * 0.04),
        //                         color: const Color(0xFF36322E),
        //                         lineHeight: const LineHeight(1.5),
        //                         textAlign: TextAlign.center,
        //                       ),
        //                     },
        //                   ),
        //                 ],
        //               ),
        //             ),
        //   ),
        // ),
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
      ),
    );
  }
}
