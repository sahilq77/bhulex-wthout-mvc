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

  @override
  void initState() {
    super.initState();
    _loadToggleState();
    // Simulate API delay then load dummy data
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) fetchSupportDummy();
    });
  }

  Future<void> _loadToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isToggled = prefs.getBool('isToggled') ?? false;
    });
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  // DUMMY DATA FUNCTION
  Future<void> fetchSupportDummy() async {
    if (!mounted) return;

    // Optional: still respect no-internet screen for realism
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoInternetPageone(onRetry: fetchSupportDummy),
        ),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;

      if (isToggled) {
        // MARATHI DUMMY CONTENT
        pageHeading = "सपोर्ट";
        supportHtmlContent = """
        <h2>आम्ही कशी मदत करू शकतो?</h2>
        <p>तुम्हाला कोणत्याही समस्या आल्यास आमच्या सपोर्ट टीमशी संपर्क साधा.</p>
        
        <ul>
          <li><strong>ईमेल:</strong> support@bhulex.in</li>
          <li><strong>फोन:</strong> +91 88888 77766 (सोम-शनि, 10:00 ते 18:00)</li>
          <li><strong>व्हॉट्सअ‍ॅप:</strong> <a href="https://wa.me/918888877766">चॅट सुरू करा</a></li>
        </ul>
        
        <h3>सामान्य प्रश्न</h3>
        <p><strong>प्रश्न:</strong> माझे खाते लॉक झाले आहे.<br>
        <strong>उत्तर:</strong> पासवर्ड रिसेट लिंकवर क्लिक करा किंवा सपोर्ट टीमला मेल करा.</p>
        
        <p><strong>प्रश्न:</strong> पेमेंट यशस्वी झाले पण ऑर्डर दिसत नाही.<br>
        <strong>उत्तर:</strong> 24 तासांत आपोआप अपडेट होईल. नाहीतर सपोर्टला कळवा.</p>
        
        <p>आम्ही 24 तासांच्या आत उत्तर देतो </p>
        """;
      } else {
        // ENGLISH DUMMY CONTENT
        pageHeading = "Support";
        supportHtmlContent = """
        <h2>How can we help you?</h2>
        <p>Having any issue? Reach out to our support team anytime.</p>
        
        <ul>
          <li><strong>Email:</strong> support@bhulex.in</li>
          <li><strong>Phone:</strong> +91 88888 77766 (Mon-Sat, 10AM - 6PM)</li>
          <li><strong>WhatsApp:</strong> <a href="https://wa.me/918888877766">Start Chat</a></li>
        </ul>
        
        <h3>Frequently Asked Questions</h3>
        <p><strong>Q:</strong> My account is locked.<br>
        <strong>A:</strong> Use the password reset link or mail support.</p>
        
        <p><strong>Q:</strong> Payment successful but order not showing.<br>
        <strong>A:</strong> It auto-updates within 24 hrs. Else contact support.</p>
        
        <p>We reply within 24 hours </p>
        """;
      }
    });
  }

  Future<void> _onRefresh() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    await fetchSupportDummy();
  }
 final bottomController = Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

   return WillPopScope(
      onWillPop: () async {
        print(
          'Main: WillPopScope triggered, current route: ${Get.currentRoute}, selectedIndex: ${bottomController.selectedIndex.value}',
        );

        print('Main: Navigating to home');
        bottomController.selectedIndex.value = 0;
        bottomController.goToHome();
        return false; // Prevent app exit
      },
      child: Scaffold(
        backgroundColor: Colorfile.background,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFDFDFD),
          elevation: 0,
          title: Text(
            pageHeading.isNotEmpty ? pageHeading : (isToggled ? "सपोर्ट" : "Support"),
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
                            textAlign: TextAlign.start,
                          ),
                          "a": Style(color: Colors.blue, textDecoration: TextDecoration.underline),
                          "h2": Style(fontSize: FontSize(width * 0.055), fontWeight: FontWeight.bold),
                          "h3": Style(fontSize: FontSize(width * 0.045), fontWeight: FontWeight.bold),
                        },
                        onLinkTap: (url, _, __) {
                          log("Opening link: $url");
                          // You can use url_launcher here if needed
                        },
                      ),
                      const SizedBox(height: 120), // Extra space for pull-to-refresh
                    ],
                  ),
          ),
        ),
         bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}