import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadDocumentPage extends StatefulWidget {
  final Map<String, String> order;

  const DownloadDocumentPage({super.key, required this.order});

  @override
  _DownloadDocumentPageState createState() => _DownloadDocumentPageState();
}

class _DownloadDocumentPageState extends State<DownloadDocumentPage> {
  // Sample list of documents with selection state
  final List<Map<String, dynamic>> documents = [
    {'name': 'Old 7/12 Extract', 'isSelected': false},
    {'name': 'Old 8A Extract', 'isSelected': false},
    {'name': 'Old E- Mutation', 'isSelected': false},
    {'name': 'Property Card', 'isSelected': false},
  ];

  Future<void> _refreshData() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      for (var doc in documents) {
        doc['isSelected'] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order',
          style: GoogleFonts.blinker(
            color: Colors.black87,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.shade300,
            height: 1,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFDFDFD),
      body: RefreshIndicator(
        onRefresh: _refreshData, // Triggered when user pulls down
        color: const Color(0xFFF26500), // Color of the refresh indicator
        backgroundColor:
            Colors.white, // Background color of the refresh indicator
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(), // Ensures scrollability for refresh
            child: Column(
              children: [
                // Order Details Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  ),
                  color: const Color(0xFFFFFFFF),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Order ID', widget.order['orderId']!),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                            'First Name', widget.order['firstName']!),
                        const SizedBox(height: 12),
                        _buildDetailRow('Last Name', widget.order['lastName']!),
                        const SizedBox(height: 12),
                        _buildDetailRow('Email ID', widget.order['email']!),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                            'Mobile Number', widget.order['mobile']!),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Documents List Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: const Color(0xFFFFFFFF),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Documents:',
                          style: GoogleFonts.blinker(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: const Color(0xFF36322E),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // List of documents with custom checkboxes
                        ...documents.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, dynamic> doc = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    doc['name'],
                                    style: GoogleFonts.blinker(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF36322E),
                                    ),
                                  ),
                                ),
                                CustomCheckbox(
                                  value: doc['isSelected'],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      documents[index]['isSelected'] = value!;
                                    });
                                  },
                                  activeColor: const Color(0xFFF26500),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                // Note Container
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEEEDE),
                    border:
                        Border.all(color: const Color(0xFFFAE5C9), width: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Note: This document will be available for download only once.',
                    style: GoogleFonts.blinker(
                      fontSize: 13,
                      color: const Color(0xFF36322E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    if (label == 'Order ID') {
      return Text(
        '$label: $value',
        style: GoogleFonts.blinker(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF36322E),
        ),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$label:',
            style: GoogleFonts.blinker(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF36322E),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: GoogleFonts.blinker(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF36322E),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color activeColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          border: Border.all(
            color: value ? activeColor : Colors.grey.shade400,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
          color: value ? activeColor : Colors.transparent,
        ),
        child: value
            ? const Icon(
                Icons.check,
                size: 18,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
