import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/profile/profile.dart';
import 'package:flutter/material.dart';

class UploadInfoDocumentScreen extends StatelessWidget {
  final bool isToggled;
  const UploadInfoDocumentScreen({super.key, required this.isToggled});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Upload Document', // Replace with your desired title
          style: AppFontStyle.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            height: 16 / 18, // Equivalent to line-height: 16px
            // letterSpacing: 0,
            textStyle: const TextStyle(textBaseline: TextBaseline.alphabetic),
          ),
        ),
        //centerTitle: true, // Center align the title
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFD9D9D9)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.file_copy_outlined,
                  size: 20,
                  color: Color(0xFF36322E),
                ),
                SizedBox(width: 3),
                Text(
                  'Document Upload',
                  style: AppFontStyle.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.57,
                    color: Color(0xFF36322E),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Upload Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade50,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 48,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Upload Your Document',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Maximum file size: 10 MB per document',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Description Field
            Text(
              'Add Your Description / Query',
              style: AppFontStyle.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.57,
                color: Color(0xFF36322E),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.orange),
                ),
              ),
            ),

            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 110.0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF57C03),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(isToggled: isToggled),
                      ),
                    );
                  },
                  child: Text(
                    'Submit',
                    style: AppFontStyle.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Submit Button
          ],
        ),
      ),
    );
  }
}
