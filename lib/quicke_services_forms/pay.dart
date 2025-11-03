import 'package:flutter/material.dart';

import 'thank_you.dart';

class payscreen extends StatelessWidget {
  final dynamic responseData;

  const payscreen({Key? key, required this.responseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You can access responseData here if needed
    return Scaffold(
      appBar: AppBar(title: Text("Pay Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
            SizedBox(height: 20),
            Text(
              "Form submitted successfully!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ThankYouPage()),
                );
              },
              child: Text("Proceed to Pay"),
            ),
          ],
        ),
      ),
    );
  }
}
