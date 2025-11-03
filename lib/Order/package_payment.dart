import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/quicke_services_forms/thank_you.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../controller/order/language controller.dart';

class PaymentScreen extends StatefulWidget {
  // final String packageId;
  // final String customerId;

  const PaymentScreen({
    Key? key,
    // required this.packageId,
    // required this.customerId,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final LanguageController languageController = Get.find<LanguageController>();
  String selectedPaymentMethod = 'Credit Card'; // Default payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorfile.appbar,
      appBar: AppBar(
        backgroundColor: Colorfile.body,
        title: Obx(
          () => Text(
            languageController.isToggled.value ? "पेमेंट" : "Payment",
            style: AppFontStyle.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colorfile.darkgrey,
            ),
          ),
        ),
        shape: const Border(
          bottom: BorderSide(color: Colorfile.border, width: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Package Summary Card
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageController.isToggled.value
                          ? "पॅकेज तपशील"
                          : "Package Details",
                      style: AppFontStyle.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF353B43),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Payment Method Section
                    Text(
                      languageController.isToggled.value
                          ? "पेमेंट पद्धत"
                          : "Payment Method",
                      style: AppFontStyle.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF353B43),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildPaymentMethodOption(
                      icon: Icons.credit_card,
                      title:
                          languageController.isToggled.value
                              ? "क्रेडिट कार्ड"
                              : "Credit Card",
                      value: 'Credit Card',
                    ),
                    _buildPaymentMethodOption(
                      icon: Icons.account_balance_wallet,
                      title:
                          languageController.isToggled.value ? "यूपीआय" : "UPI",
                      value: 'UPI',
                    ),
                    _buildPaymentMethodOption(
                      icon: Icons.money,
                      title:
                          languageController.isToggled.value
                              ? "नेट बँकिंग"
                              : "Net Banking",
                      value: 'Net Banking',
                    ),
                    const SizedBox(height: 20),

                    // Pay Now Button
                    ElevatedButton(
                      onPressed: () {
                        _processPayment(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF57C03),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                        elevation: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            languageController.isToggled.value
                                ? "आता पे करा"
                                : "Pay Now",
                            style: AppFontStyle.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build payment method options
  Widget _buildPaymentMethodOption({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              selectedPaymentMethod == value
                  ? const Color(0xFFFFF3E0)
                  : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                selectedPaymentMethod == value
                    ? const Color(0xFFF57C03)
                    : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFF57C03), size: 24),
            const SizedBox(width: 10),
            Text(
              title,
              style: AppFontStyle.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF353B43),
              ),
            ),
            const Spacer(),
            if (selectedPaymentMethod == value)
              const Icon(
                Icons.check_circle,
                color: Color(0xFFF57C03),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  // Dummy payment processing logic
  void _processPayment(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            languageController.isToggled.value
                ? "पेमेंट यशस्वीरित्या झाले!"
                : "Payment Successful!",
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ThankYouPage()),
      );
    });
  }
}
