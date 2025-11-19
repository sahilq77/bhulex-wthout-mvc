import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors/order_fonts.dart';

class DocumentPreviewPage extends StatelessWidget {
  const DocumentPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        title: Text(
          'Document Preview',
          style: AppFontStyle2.blinker(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF36322E),
          ),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        titleSpacing: 0.0,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFD9D9D9)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
            ),
            border: Border.all(
              color: Color(0xFF9CA3AF),
              width: 1.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                child: Text(
                  "Here's How Your Document Will Look",
                  style: GoogleFonts.blinker(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF36322E),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[300],
                child: Image.asset(
                  'assets/images/document.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
