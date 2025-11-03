// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:get/get.dart';

// // import '../colors/custom_color.dart';
// // import '../controller/package/package_enquiry_form_controller.dart';

// // class PackageForm extends StatefulWidget {
// //   final String packageId;
// //   final String serviceId;
// //   const PackageForm({
// //     Key? key,
// //     required this.packageId,
// //     required this.serviceId,
// //   }) : super(key: key);

// //   @override
// //   _PackageFormPageState createState() => _PackageFormPageState();
// // }

// // class _PackageFormPageState extends State<PackageForm> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _firstNameController = TextEditingController();
// //   final TextEditingController _lastNameController = TextEditingController();
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _mobileController = TextEditingController();
// //   final TextEditingController _messageController = TextEditingController();
// //   late PackageEnquiryController _enquiryController;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _enquiryController = Get.put(PackageEnquiryController());
// //   }

// //   Future<void> _showPaymentDialog() async {
// //     Get.dialog(
// //       AlertDialog(
// //         title: Text(
// //           'Confirm Payment',
// //           style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
// //         ),
// //         content: Text(
// //           'Are you sure you want to proceed with the payment?',
// //           style: GoogleFonts.poppins(fontSize: 14),
// //         ),
// //         actions: [
// //           TextButton(
// //             child: Text(
// //               'Cancel',
// //               style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
// //             ),
// //             onPressed: () => Get.back(), // Closes dialog
// //           ),
// //           Obx(
// //             () => ElevatedButton(
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: const Color(0xFFF57C03),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(7.0),
// //                 ),
// //               ),
// //               onPressed:
// //                   _enquiryController.isLoading.value
// //                       ? null
// //                       : () async {
// //                         await _enquiryController.submitEnquiry(
// //                           packageId: widget.packageId,
// //                           serviceId: widget.serviceId,
// //                           firstName: _firstNameController.text,
// //                           lastName: _lastNameController.text,
// //                           email: _emailController.text,
// //                           mobileNumber: _mobileController.text,
// //                           message: _messageController.text,
// //                         );
// //                         if (_enquiryController.success.value) {
// //                           Get.back(); // Close dialog
// //                           Get.snackbar('Success', 'Payment successful');
// //                           Navigator.pop(context); // Return to previous screen
// //                         } else {
// //                           Get.back(); // Close dialog
// //                           Get.snackbar('Error', 'Payment failed');
// //                         }
// //                       },
// //               child:
// //                   _enquiryController.isLoading.value
// //                       ? const SizedBox(
// //                         height: 20,
// //                         width: 20,
// //                         child: CircularProgressIndicator(
// //                           color: Colors.white,
// //                           strokeWidth: 2,
// //                         ),
// //                       )
// //                       : Text(
// //                         'Pay Now',
// //                         style: GoogleFonts.poppins(
// //                           color: Colors.white,
// //                           fontSize: 16,
// //                         ),
// //                       ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       barrierDismissible: false,
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colorfile.appbar,
// //       appBar: AppBar(
// //         backgroundColor: Colorfile.body,
// //         title: Text(
// //           'Home Loan',
// //           style: GoogleFonts.poppins(
// //             fontSize: 20,
// //             fontWeight: FontWeight.w500,
// //             color: Colorfile.darkgrey,
// //           ),
// //         ),
// //         shape: const Border(
// //           bottom: BorderSide(color: Colorfile.border, width: 1.0),
// //         ),
// //       ),
// //       body: RefreshIndicator(
// //         onRefresh: () async {
// //           _firstNameController.clear();
// //           _lastNameController.clear();
// //           _emailController.clear();
// //           _mobileController.clear();
// //           _messageController.clear();

// //           _formKey.currentState?.reset();
// //           await Future.delayed(const Duration(seconds: 3));
// //         },
// //         child: SingleChildScrollView(
// //           physics: const AlwaysScrollableScrollPhysics(),
// //           child: Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.only(top: 12.0),
// //                   child: Text(
// //                     'Please Enter Your Details',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w500,
// //                       color: const Color(0xFF36322E),
// //                     ),
// //                   ),
// //                 ),
// //                 Form(
// //                   autovalidateMode: AutovalidateMode.onUserInteraction,
// //                   key: _formKey,
// //                   child: Column(
// //                     children: [
// //                       TextFormField(
// //                         textInputAction: TextInputAction.next,
// //                         controller: _firstNameController,
// //                         decoration: InputDecoration(
// //                           labelText: 'First Name*',
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                           focusedBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                           enabledBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                         ),
// //                         validator: (value) {
// //                           if (value == null || value.isEmpty) {
// //                             return 'Please enter your first name';
// //                           }
// //                           return null;
// //                         },
// //                       ),
// //                       const SizedBox(height: 12),
// //                       TextFormField(
// //                         textInputAction: TextInputAction.next,
// //                         controller: _lastNameController,
// //                         decoration: InputDecoration(
// //                           labelText: 'Last Name*',
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                           focusedBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                           enabledBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                         ),
// //                         validator: (value) {
// //                           if (value == null || value.isEmpty) {
// //                             return 'Please enter your last name';
// //                           }
// //                           return null;
// //                         },
// //                       ),
// //                       const SizedBox(height: 12),
// //                       TextFormField(
// //                         textInputAction: TextInputAction.next,
// //                         controller: _emailController,
// //                         decoration: InputDecoration(
// //                           labelText: 'Email ID*',
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                           focusedBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                           enabledBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                         ),
// //                         keyboardType: TextInputType.emailAddress,
// //                         validator: (value) {
// //                           if (value == null || value.isEmpty) {
// //                             return 'Please enter your email ID';
// //                           }
// //                           return null;
// //                         },
// //                       ),
// //                       const SizedBox(height: 12),
// //                       TextFormField(
// //                         textInputAction: TextInputAction.next,
// //                         controller: _mobileController,
// //                         decoration: InputDecoration(
// //                           labelText: 'Mobile Number*',
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                           focusedBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                           enabledBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                         ),
// //                         keyboardType: TextInputType.phone,
// //                         validator: (value) {
// //                           if (value == null || value.isEmpty) {
// //                             return 'Please enter your mobile number';
// //                           }
// //                           if (value.length != 10) {
// //                             return 'Please enter a valid 10-digit mobile number';
// //                           }
// //                           return null;
// //                         },
// //                       ),
// //                       const SizedBox(height: 12),
// //                       TextFormField(
// //                         textInputAction: TextInputAction.done,
// //                         controller: _messageController,
// //                         decoration: InputDecoration(
// //                           labelText: 'Message',
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                           focusedBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                           enabledBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12.0),
// //                             borderSide: const BorderSide(
// //                               color: Color(0xFFC5C5C5),
// //                             ),
// //                           ),
// //                         ),
// //                         maxLines: 4,
// //                         validator: (value) {
// //                           if (value == null || value.isEmpty) {
// //                             return 'Please enter a message';
// //                           }
// //                           return null;
// //                         },
// //                       ),
// //                       const SizedBox(height: 20),
// //                       SizedBox(
// //                         height: 54,
// //                         width: double.infinity,
// //                         child: Obx(
// //                           () => ElevatedButton(
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: const Color(0xFFF57C03),
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(7.0),
// //                               ),
// //                             ),
// //                             onPressed: () {
// //                               if (_formKey.currentState!.validate()) {
// //                                 _showPaymentDialog();
// //                               }
// //                             },
// //                             child:
// //                                 _enquiryController.isLoading.value
// //                                     ? const CircularProgressIndicator(
// //                                       color: Colors.white,
// //                                     )
// //                                     : Text(
// //                                       'Submit',
// //                                       style: GoogleFonts.poppins(
// //                                         fontSize: 18,
// //                                         color: Colors.white,
// //                                       ),
// //                                     ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _firstNameController.dispose();
// //     _lastNameController.dispose();
// //     _emailController.dispose();
// //     _mobileController.dispose();
// //     _messageController.dispose();
// //     super.dispose();
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:get/get.dart';
// import '../colors/custom_color.dart';
// import '../controller/package/package_enquiry_form_controller.dart';
// import '../controller/order/language%20controller.dart'; // Added LanguageController import

// class PackageForm extends StatefulWidget {
//   final String packageId;
//   final String serviceId;
//   final String title;
//   final String titleInLocalLanguage; // Local language title
//   const PackageForm({
//     Key? key,
//     required this.packageId,
//     required this.serviceId,
//     required this.title,
//     required this.titleInLocalLanguage,
//   }) : super(key: key);

//   @override
//   _PackageFormPageState createState() => _PackageFormPageState();
// }

// class _PackageFormPageState extends State<PackageForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//   late PackageEnquiryController _enquiryController;
//   final LanguageController languageController =
//       Get.find<LanguageController>(); // Use global instance

//   @override
//   void initState() {
//     super.initState();
//     _enquiryController = Get.put(PackageEnquiryController());
//   }

//   Future<void> _showPaymentDialog() async {
//     Get.dialog(
//       AlertDialog(
//         title: Obx(
//           () => Text(
//             languageController.isToggled.value
//                 ? 'पेमेंटची पुष्टी करा'
//                 : 'Confirm Payment',
//             style: GoogleFonts.poppins(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         content: Obx(
//           () => Text(
//             languageController.isToggled.value
//                 ? 'आपण खात्रीने पेमेंटसह पुढे जाऊ इच्छिता?'
//                 : 'Are you sure you want to proceed with the payment?',
//             style: GoogleFonts.poppins(fontSize: 14),
//           ),
//         ),
//         actions: [
//           TextButton(
//             child: Obx(
//               () => Text(
//                 languageController.isToggled.value ? 'रद्द करा' : 'Cancel',
//                 style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
//               ),
//             ),
//             onPressed: () => Get.back(),
//           ),
//           Obx(
//             () => ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFF57C03),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(7.0),
//                 ),
//               ),
//               onPressed:
//                   _enquiryController.isLoading.value
//                       ? null
//                       : () async {
//                         await _enquiryController.submitEnquiry(
//                           packageId: widget.packageId,
//                         );
//                         if (_enquiryController.success.value) {
//                           Get.back();
//                           Get.snackbar(
//                             languageController.isToggled.value
//                                 ? 'यशस्वी'
//                                 : 'Success',
//                             languageController.isToggled.value
//                                 ? 'पेमेंट यशस्वी'
//                                 : 'Payment successful',
//                             backgroundColor: const Color(
//                               0xFF4CAF50,
//                             ), // Green color
//                             colorText: Colors.white, // White text for contrast
//                             snackPosition:
//                                 SnackPosition
//                                     .TOP, // Optional: positions snackbar at top
//                             margin: const EdgeInsets.all(10),
//                             borderRadius: 8, // Optional: rounded corners
//                             duration: const Duration(
//                               seconds: 3,
//                             ), // Optional: sets duration
//                           );
//                           Navigator.pop(context);
//                         } else {
//                           Get.back();
//                           Get.snackbar(
//                             languageController.isToggled.value
//                                 ? 'त्रुटी'
//                                 : 'Error',
//                             languageController.isToggled.value
//                                 ? 'पेमेंट अयशस्वी'
//                                 : 'Payment failed',
//                             backgroundColor: const Color.fromARGB(
//                               255,
//                               233,
//                               15,
//                               15,
//                             ), // Green color
//                             colorText: Colors.white, // White text for contrast
//                           );
//                         }
//                       },
//               child:
//                   _enquiryController.isLoading.value
//                       ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 2,
//                         ),
//                       )
//                       : Obx(
//                         () => Text(
//                           languageController.isToggled.value
//                               ? 'आता पैसे द्या'
//                               : 'Pay Now',
//                           style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//             ),
//           ),
//         ],
//       ),
//       barrierDismissible: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colorfile.appbar,

//       appBar: AppBar(
//         backgroundColor: Colorfile.body,
//         title: Obx(
//           () => Text(
//             languageController.isToggled.value
//                 ? widget.titleInLocalLanguage
//                 : widget.title,
//             style: GoogleFonts.poppins(
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//               color: Colorfile.darkgrey,
//             ),
//           ),
//         ),
//         titleSpacing: 0.0,

//         shape: const Border(
//           bottom: BorderSide(color: Colorfile.border, width: 1.0),
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           _firstNameController.clear();
//           _lastNameController.clear();
//           _emailController.clear();
//           _mobileController.clear();
//           _messageController.clear();
//           _formKey.currentState?.reset();
//           await Future.delayed(const Duration(seconds: 3));
//         },
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Obx(
//                     () => Text(
//                       languageController.isToggled.value
//                           ? 'कृपया आपला तपशील प्रविष्ट करा'
//                           : 'Please Enter Your Details',
//                       style: GoogleFonts.poppins(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: const Color(0xFF36322E),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 Form(
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       Obx(
//                         () => TextFormField(
//                           textInputAction: TextInputAction.next,
//                           controller: _firstNameController,
//                           decoration: InputDecoration(
//                             labelText:
//                                 languageController.isToggled.value
//                                     ? 'प्रथम नाव*'
//                                     : 'First Name*',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                           ),
//                           inputFormatters: [
//                             FilteringTextInputFormatter.allow(
//                               RegExp(
//                                 r'^[\u0900-\u097F\u0966-\u096F a-zA-Z\s]+$',
//                               ), // Marathi + English
//                             ),
//                             LengthLimitingTextInputFormatter(
//                               50,
//                             ), // Limit to 50 characters
//                             TextInputFormatter.withFunction((
//                               oldValue,
//                               newValue,
//                             ) {
//                               String text = newValue.text.replaceAll(
//                                 RegExp(r'\s+'),
//                                 ' ',
//                               ); // Remove extra spaces
//                               if (text.startsWith(' '))
//                                 text = text.trimLeft(); // Trim leading spaces

//                               return TextEditingValue(
//                                 text: text,
//                                 selection: TextSelection.collapsed(
//                                   offset: text.length,
//                                 ),
//                               );
//                             }),
//                           ],
//                           textCapitalization: TextCapitalization.words,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return languageController.isToggled.value
//                                   ? 'कृपया आपले प्रथम नाव प्रविष्ट करा'
//                                   : 'Please enter your first name';
//                             }

//                             final trimmedValue = value.trim();

//                             // Block HTML/script tags or suspicious patterns
//                             if (RegExp(
//                               r'<.*?>|script|alert|on\w+=',
//                               caseSensitive: false,
//                             ).hasMatch(trimmedValue)) {
//                               return 'Invalid characters or script content detected';
//                             }

//                             // Allow only Unicode letters and spaces
//                             if (!RegExp(
//                               r'^[\p{L}\s]+$',
//                               unicode: true,
//                             ).hasMatch(trimmedValue)) {
//                               return 'Only alphabets and spaces allowed';
//                             }

//                             return null;
//                           },
//                           // validator: (value) {
//                           // if (value == null || value.isEmpty) {
//                           //   return languageController.isToggled.value
//                           //       ? 'कृपया आपले प्रथम नाव प्रविष्ट करा'
//                           //       : 'Please enter your first name';
//                           // }
//                           //   return null;
//                           // },
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Obx(
//                         () => TextFormField(
//                           textInputAction: TextInputAction.next,
//                           controller: _lastNameController,
//                           decoration: InputDecoration(
//                             labelText:
//                                 languageController.isToggled.value
//                                     ? 'आडनाव*'
//                                     : 'Last Name*',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                           ),
//                           inputFormatters: [
//                             FilteringTextInputFormatter.allow(
//                               RegExp(
//                                 r'^[\u0900-\u097F\u0966-\u096F a-zA-Z\s]+$',
//                               ), // Marathi + English
//                             ),
//                             LengthLimitingTextInputFormatter(
//                               50,
//                             ), // Limit to 50 characters
//                             TextInputFormatter.withFunction((
//                               oldValue,
//                               newValue,
//                             ) {
//                               String text = newValue.text.replaceAll(
//                                 RegExp(r'\s+'),
//                                 ' ',
//                               ); // Remove extra spaces
//                               if (text.startsWith(' '))
//                                 text = text.trimLeft(); // Trim leading spaces

//                               return TextEditingValue(
//                                 text: text,
//                                 selection: TextSelection.collapsed(
//                                   offset: text.length,
//                                 ),
//                               );
//                             }),
//                           ],
//                           textCapitalization: TextCapitalization.words,
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return languageController.isToggled.value
//                                   ? 'कृपया आपले आडनाव प्रविष्ट करा'
//                                   : 'Please enter your last name';
//                             }

//                             final trimmedValue = value.trim();

//                             // Block HTML/script tags or suspicious patterns
//                             if (RegExp(
//                               r'<.*?>|script|alert|on\w+=',
//                               caseSensitive: false,
//                             ).hasMatch(trimmedValue)) {
//                               return 'Invalid characters or script content detected';
//                             }

//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Obx(
//                         () => TextFormField(
//                           textInputAction: TextInputAction.next,
//                           controller: _emailController,
//                           decoration: InputDecoration(
//                             labelText:
//                                 languageController.isToggled.value
//                                     ? 'ईमेल आयडी*'
//                                     : 'Email ID*',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           inputFormatters: [
//                             FilteringTextInputFormatter.allow(
//                               RegExp(r'[a-zA-Z0-9@._-]'),
//                             ),
//                             LengthLimitingTextInputFormatter(50),
//                           ],
//                           onChanged: (value) {
//                             _emailController
//                                 .value = _emailController.value.copyWith(
//                               text:
//                                   value
//                                       .toLowerCase(), // Convert input to lowercase
//                               selection: TextSelection.collapsed(
//                                 offset: value.length,
//                               ),
//                             );
//                           },
//                           textCapitalization:
//                               TextCapitalization
//                                   .none, // Emails are case-insensitive
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return languageController.isToggled.value
//                                   ? 'कृपया आपला ईमेल आयडी प्रविष्ट करा'
//                                   : 'Please enter email ID';
//                             }

//                             final trimmedValue = value.trim();

//                             // Block HTML/script tags or suspicious patterns
//                             if (RegExp(
//                               r'<.*?>|script|alert|on\w+=',
//                               caseSensitive: false,
//                             ).hasMatch(trimmedValue)) {
//                               return languageController.isToggled.value
//                                   ? 'अवैध अक्षरे किंवा स्क्रिप्ट सामग्री आढळली'
//                                   : 'Invalid characters or script content detected';
//                             }

//                             // Allow only valid email format
//                             if (!RegExp(
//                               r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
//                             ).hasMatch(trimmedValue)) {
//                               return languageController.isToggled.value
//                                   ? 'कृपया वैध ईमेल आयडी प्रविष्ट करा'
//                                   : 'Please enter a valid email ID';
//                             }

//                             return null;
//                           },
//                           // keyboardType: TextInputType.emailAddress,
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return languageController.isToggled.value
//                           //         ? 'कृपया आपला ईमेल आयडी प्रविष्ट करा'
//                           //         : 'Please enter your email ID';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Obx(
//                         () => TextFormField(
//                           textInputAction: TextInputAction.next,
//                           controller: _mobileController,
//                           decoration: InputDecoration(
//                             labelText:
//                                 languageController.isToggled.value
//                                     ? 'मोबाइल नंबर*'
//                                     : 'Mobile Number*',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                           ),
//                           // keyboardType: TextInputType.phone,
//                           inputFormatters: [
//                             FilteringTextInputFormatter.allow(
//                               RegExp(
//                                 r'[0-9\u0966-\u096F]',
//                               ), // Allow both English (0-9) and Marathi (०-९) digits
//                             ),
//                             LengthLimitingTextInputFormatter(
//                               10,
//                             ), // Limit to 10 digits
//                           ],
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return languageController.isToggled.value
//                                   ? 'कृपया आपला मोबाइल नंबर प्रविष्ट करा'
//                                   : 'Please enter mobile number';
//                             }

//                             final trimmedValue = value.trim();

//                             // Block HTML/script tags or suspicious patterns
//                             if (RegExp(
//                               r'<.*?>|script|alert|on\w+=',
//                               caseSensitive: false,
//                             ).hasMatch(trimmedValue)) {
//                               return languageController.isToggled.value
//                                   ? 'अवैध अक्षरे किंवा स्क्रिप्ट सामग्री आढळली'
//                                   : 'Invalid characters or script content detected';
//                             }

//                             // Regular Expression to Validate:
//                             // English: 9876543210
//                             // Marathi: ९८७६५४३२१०
//                             // if (!RegExp(
//                             //   r'^[6-9]\d{9}$|^[\u096C-\u096F][\u0966-\u096F]{9}$',
//                             // ).hasMatch(trimmedValue)) {
//                             //   return languageController.isToggled.value
//                             //       ? 'कृपया वैध १०-अंकी मोबाइल नंबर प्रविष्ट करा '
//                             //       : 'Please enter a valid 10-digit mobile number';
//                             // }

//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Obx(
//                         () => TextFormField(
//                           textInputAction: TextInputAction.done,
//                           controller: _messageController,
//                           decoration: InputDecoration(
//                             labelText:
//                                 languageController.isToggled.value
//                                     ? 'संदेश'
//                                     : 'Message',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFC5C5C5),
//                               ),
//                             ),
//                           ),
//                           inputFormatters: [
//                             FilteringTextInputFormatter.allow(
//                               RegExp(
//                                 r'^[\u0900-\u097F\u0966-\u096F a-zA-Z0-9\s/@#&*(),.\-]+$',
//                               ),
//                             ),
//                             LengthLimitingTextInputFormatter(
//                               50,
//                             ), // Limit to 50 characters
//                             TextInputFormatter.withFunction((
//                               oldValue,
//                               newValue,
//                             ) {
//                               String text = newValue.text.replaceAll(
//                                 RegExp(r'\s+'),
//                                 ' ',
//                               ); // Remove extra spaces
//                               if (text.startsWith(' '))
//                                 text = text.trimLeft(); // Trim leading spaces

//                               return TextEditingValue(
//                                 text: text,
//                                 selection: TextSelection.collapsed(
//                                   offset: text.length,
//                                 ),
//                               );
//                             }),
//                           ],
//                           textCapitalization: TextCapitalization.words,
//                           maxLines: 4,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return languageController.isToggled.value
//                                   ? 'कृपया आपले आडनाव प्रविष्ट करा'
//                                   : 'Please enter your last name';
//                             }
//                             final trimmedValue = value.trim();

//                             // Block HTML/script tags or suspicious patterns
//                             if (RegExp(
//                               r'<.*?>|script|alert|on\w+=',
//                               caseSensitive: false,
//                             ).hasMatch(trimmedValue)) {
//                               return 'Invalid characters or script content detected';
//                             }

//                             // Allow only Unicode letters and spaces
//                             // if (!RegExp(
//                             //   r'^[\p{L}\s]+$',
//                             //   unicode: true,
//                             // ).hasMatch(trimmedValue)) {
//                             //   return 'Only alphabets and spaces allowed';
//                             // }

//                             // return null;
//                           },
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return languageController.isToggled.value
//                           //         ? 'कृपया संदेश प्रविष्ट करा'
//                           //         : 'Please enter a message';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         height: 54,
//                         width: double.infinity,
//                         child: Obx(
//                           () => ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFFF57C03),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(7.0),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 _showPaymentDialog();
//                               }
//                             },
//                             child:
//                                 _enquiryController.isLoading.value
//                                     ? const CircularProgressIndicator(
//                                       color: Colors.white,
//                                     )
//                                     : Obx(
//                                       () => Text(
//                                         languageController.isToggled.value
//                                             ? 'सबमिट करा'
//                                             : 'Submit',
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 18,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _mobileController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }
// }
