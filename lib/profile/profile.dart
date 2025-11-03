// import 'dart:io';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:my_bhulekh_app/Order/order_list.dart' show MyOrderScreen;
// import 'package:my_bhulekh_app/My_package/package_details_new.dart';
// import 'package:my_bhulekh_app/colors/custom_color.dart';
// import 'package:my_bhulekh_app/colors/order_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../homepage.dart';
// import '../network/url.dart';
// import '../sign_up_screens/signup1.dart';
// import 'about_bhulex.dart';
// import 'change_language.dart';
// import 'disclaimer.dart';
// import 'help&support.dart';
// import 'privacy_policy.dart';
// import 'terms_and_conditions.dart';

// class ProfilePage extends StatefulWidget {
//   final bool isToggled;

//   const ProfilePage({super.key, required this.isToggled});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   int _selectedIndex = 3;
//   final ImagePicker _picker = ImagePicker();
//   bool isUploading = false;
//   late bool isToggled;

//   @override
//   void initState() {
//     super.initState();
//     isToggled = widget.isToggled;
//     loadProfileImageUrl();
//     fetchCustomer();
//   }

//   Future<void> loadProfileImageUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       shareprefImageUrl = prefs.getString('profile_image_url') ?? '';
//     });
//   }

//   Future<void> _loadToggleState() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isToggled = prefs.getBool('isToggled') ?? false;
//     });
//   }

//   String iconPath = '';
//   String customerName = '';
//   String customerMobile = '';
//   bool isLoading = true;
//   List<dynamic> customerList = [];
//   String? selectedState;
//   String? profileImageUrl;
//   String shareprefImageUrl = "";

//   Future<void> fetchCustomer() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? customerId = prefs.getString('customer_id');

//     var requestBody = {"customer_id": customerId};

//     final String url = URLS().get_customer_profile_apiUrl;
//     log("Customer Profile API URL: $url");
//     log("Request Body: ${jsonEncode(requestBody)}");

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json; charset=UTF-8'},
//         body: jsonEncode(requestBody),
//       );

//       print("Raw Response: ${response.body}");

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         log("Parsed Response: ${response.body}");

//         setState(() {
//           customerList = responseData['data'] ?? [];
//           iconPath = responseData['icon_path'] ?? '';
//           profileImageUrl =
//               customerList.isNotEmpty
//                   ? "${responseData['icon_path']}${customerList[0]['profile_image']}"
//                   : null;
//           isLoading = false;
//         });

//         if (customerList.isNotEmpty) {
//           final customerName =
//               customerList[0]['customer_name']?.toString().trim();
//           if (customerName == null || customerName.isEmpty) {
//             print("👤 Customer name is blank. Redirecting to profile page...");
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ProfilePage(isToggled: isToggled),
//               ),
//             );
//           }
//         }
//       } else {
//         print("Failed with status: ${response.statusCode}");
//         setState(() => isLoading = false);
//       }
//     } catch (e) {
//       print("Exception: $e");
//       setState(() => isLoading = false);
//     }
//   }

//   Future<void> updateProfileImage(File imageFile) async {
//     try {
//       setState(() => isUploading = true);

//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String customerId = prefs.getString('customer_id') ?? '1';

//       var url = Uri.parse("https://seekhelp.in/bhulex/update_profile");
//       var request = http.MultipartRequest('POST', url);

//       // Add customer ID
//       request.fields['customer_id'] = customerId;

//       // Attach image file
//       var multipartFile = await http.MultipartFile.fromPath(
//         'profile_image',
//         imageFile.path,
//         filename: imageFile.path.split('/').last,
//       );
//       request.files.add(multipartFile);

//       // Send request
//       var response = await request.send();
//       var responseBody = await http.Response.fromStream(response);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(responseBody.body);

//         if (jsonData['status'] == "true") {
//           final newImageUrl =
//               "${jsonData['profile_image_path']}${jsonData['data']['profile_image']}";

//           // Save it in shared preferences
//           await prefs.setString("profile_image_url", newImageUrl);

//           setState(() {
//             profileImageUrl = newImageUrl;
//             log("Updated profile image URL: $profileImageUrl");
//           });

//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Profile image updated successfully!'),
//             ),
//           );

//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) {
//                 return ProfilePage(isToggled: isToggled);
//               },
//             ),
//           ); // Close the modal
//         } else {
//           throw Exception(jsonData['message'] ?? 'API returned false status');
//         }
//       } else {
//         throw Exception('Failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint("Upload Error: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error uploading image: $e')));
//     } finally {
//       setState(() => isUploading = false);
//     }
//   }

//   void showEditProfileImageBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter modalSetState) {
//             return Stack(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom,
//                     left: 24,
//                     right: 24,
//                     top: 16,
//                   ),
//                   child: Wrap(
//                     children: [
//                       Center(
//                         child: Column(
//                           children: [
//                             const Icon(
//                               Icons.photo,
//                               size: 40,
//                               color: Colors.orange,
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               isToggled
//                                   ? 'प्रोफाइल फोटो संपादित करा'
//                                   : 'Edit Profile Photo',
//                               style: AppFontStyle2.blinker(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF36322E),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               isToggled
//                                   ? 'आपला फोटो अपडेट करण्यासाठी एक पद्धत निवडा'
//                                   : 'Choose a method to update your photo',
//                               textAlign: TextAlign.center,
//                               style: AppFontStyle2.blinker(
//                                 fontSize: 14,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                             const SizedBox(height: 25),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Column(
//                                   children: [
//                                     InkWell(
//                                       onTap:
//                                           isUploading
//                                               ? null
//                                               : () async {
//                                                 final XFile? image =
//                                                     await _picker.pickImage(
//                                                       source:
//                                                           ImageSource.camera,
//                                                       imageQuality: 85,
//                                                     );
//                                                 if (image != null)
//                                                   await updateProfileImage(
//                                                     File(image.path),
//                                                   );
//                                               },
//                                       child: CircleAvatar(
//                                         radius: 30,
//                                         backgroundColor: Colors.orange.shade100,
//                                         child: Icon(
//                                           Icons.camera_alt,
//                                           size: 28,
//                                           color: Colors.orange.shade800,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Text(
//                                       isToggled ? 'कॅमेरा' : 'Camera',
//                                       style: AppFontStyle2.blinker(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.orange.shade800,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     InkWell(
//                                       onTap:
//                                           isUploading
//                                               ? null
//                                               : () async {
//                                                 final XFile? image =
//                                                     await _picker.pickImage(
//                                                       source:
//                                                           ImageSource.gallery,
//                                                     );
//                                                 if (image != null)
//                                                   await updateProfileImage(
//                                                     File(image.path),
//                                                   );
//                                               },
//                                       child: CircleAvatar(
//                                         radius: 30,
//                                         backgroundColor: Colors.orange.shade100,
//                                         child: Icon(
//                                           Icons.photo_library,
//                                           size: 28,
//                                           color: Colors.orange.shade800,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Text(
//                                       isToggled ? 'गॅलरी' : 'Gallery',
//                                       style: AppFontStyle2.blinker(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.orange.shade800,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                             TextButton(
//                               onPressed:
//                                   isUploading
//                                       ? null
//                                       : () => Navigator.pop(context),
//                               child: Text(
//                                 isToggled ? 'रद्द करा' : 'Cancel',
//                                 style: AppFontStyle2.blinker(
//                                   fontSize: 14,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (isUploading)
//                   Container(
//                     color: Colors.black.withOpacity(0.3),
//                     child: const Center(child: CircularProgressIndicator()),
//                   ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   void _showLogoutConfirmationDialog(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return Container(
//           padding: MediaQuery.of(context).viewInsets,
//           color: Colors.transparent,
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: Wrap(
//               children: [
//                 ClipRect(
//                   child: Container(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           isToggled ? 'लॉगआउट' : 'Logout',
//                           style: AppFontStyle.inter(
//                             fontSize: 21,
//                             fontWeight: FontWeight.bold,
//                             color: const Color(0xFFF26500),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Container(height: 1, color: Colors.grey[300]),
//                         const SizedBox(height: 20),
//                         const Icon(
//                           Icons.power_settings_new,
//                           size: 50,
//                           color: Colors.orange,
//                         ),
//                         Text(
//                           isToggled ? 'लवकरच परत या!' : 'Come back soon!',
//                           style: AppFontStyle.poppins(
//                             // fontFamily: 'Poppins',
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18,
//                             color: Color(0xFF36322E),
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 10),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Text(
//                             isToggled
//                                 ? 'लॉगआउट केल्याने आपले सत्र संपेल\nआपण पुढे जाऊ इच्छिता का?'
//                                 : 'Logging out will end your session\nDo you wish to proceed?',
//                             textAlign: TextAlign.center,
//                             style: AppFontStyle.poppins(
//                               // fontFamily: 'Poppins',
//                               fontSize: 14,
//                               color: Colors.black54,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Expanded(
//                               child: TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 style: ButtonStyle(
//                                   side: MaterialStateProperty.resolveWith<
//                                     BorderSide
//                                   >(
//                                     (states) =>
//                                         BorderSide(color: Colors.grey[300]!),
//                                   ),
//                                   shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder
//                                   >(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5.0),
//                                     ),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   isToggled ? 'रद्द करा' : 'Cancel',
//                                   style: AppFontStyle.inter(
//                                     fontSize: 14,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 30),
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: () async {
//                                   SharedPreferences idsaver =
//                                       await SharedPreferences.getInstance();
//                                   await idsaver.clear();
//                                   Navigator.pop(context);
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => Signup1(),
//                                     ),
//                                   );
//                                 },
//                                 style: ButtonStyle(
//                                   backgroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                         const Color(0xFFF26500),
//                                       ),
//                                   shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder
//                                   >(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5.0),
//                                     ),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   isToggled ? 'लॉगआउट' : 'Logout',
//                                   style: AppFontStyle.inter(
//                                     fontSize: 16,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     switch (index) {
//       case 0:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomePage2(customer_id: '', customerId: ''),
//           ),
//         );
//         // Navigator.pop(context); // Return to HomePage2
//         print("Home tapped");
//         break;
//       case 1:
//         print("Customer Care tapped");
//         break;
//       case 2:
//         print("My Order tapped");
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder:
//                 (context) => MyOrderScreen(package_id: '', customer_id: ''),
//           ),
//         );
//         break;
//       case 3:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProfilePage(isToggled: isToggled),
//           ),
//         );
//         print("My Profile tapped");
//         break;
//       case 4:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder:
//                 (context) => PackageScreen(
//                   customerid: '',
//                   package_id: '',
//                   tbl_name: '',
//                   customerId: '',
//                 ),
//           ),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const iconTextColor = Color(0xFF353B43);
//     return Scaffold(
//       backgroundColor: Colorfile.appbar,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder:
//                         (context) => HomePage2(
//                           customer_id: '',
//                           customerId: '',
//                         ), // Replace with your HomePage2 widget
//                   ),
//                 );
//               },
//             ),
//             Text(
//               BottomNavigationStrings.getString('myProfile', isToggled),
//               style: AppFontStyle2.blinker(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFF353B43),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             Center(
//               child: Stack(
//                 children: [
//                   CircleAvatar(
//                     radius: 60,
//                     backgroundImage:
//                         (shareprefImageUrl.isNotEmpty)
//                             ? NetworkImage(shareprefImageUrl)
//                             : const AssetImage('assets/edit-02.png'),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: () => showEditProfileImageBottomSheet(context),
//                       child: CircleAvatar(
//                         radius: 20,
//                         backgroundColor: Colorfile.bordertheme,
//                         child: const Icon(
//                           Icons.edit,
//                           size: 20,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               customerList.isNotEmpty
//                   ? customerList[0]['customer_name'] ?? 'Customer Name'
//                   : 'Customer Name',
//               style: AppFontStyle2.blinker(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: iconTextColor,
//               ),
//             ),
//             Text(
//               customerList.isNotEmpty &&
//                       customerList[0]['mobile_number'] != null &&
//                       customerList[0]['mobile_number'].toString().isNotEmpty
//                   ? customerList[0]['mobile_number'].toString()
//                   : 'Mobile number not available',
//               style: AppFontStyle2.blinker(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               width: 400,
//               height: 620,
//               padding: const EdgeInsets.only(top: 7, bottom: 7),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Color(0xFFE5E7EB), width: 0.5),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(24),
//                   topRight: Radius.circular(24),
//                 ),
//               ),
//               child: Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 0,
//                 color: Colorfile.body,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListTile(
//                       leading: Image.asset(
//                         'assets/privacy.png',
//                         width: 24,
//                         height: 24,
//                         color: iconTextColor,
//                       ),
//                       title: Text(
//                         isToggled ? 'आमच्याबद्दल' : 'About',
//                         style: AppFontStyle2.blinker(color: iconTextColor),
//                       ),
//                       trailing: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: iconTextColor,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AboutBhulexPage(),
//                           ),
//                         );
//                       },
//                     ),
//                     const Divider(height: 1, color: Color(0xFFF2F4F7)),
//                     ListTile(
//                       leading: Image.asset(
//                         'assets/privacy.png',
//                         width: 24,
//                         height: 24,
//                         color: iconTextColor,
//                       ),
//                       title: Text(
//                         isToggled ? 'गोपनीयता धोरण' : 'Privacy Policy',
//                         style: AppFontStyle2.blinker(color: iconTextColor),
//                       ),
//                       trailing: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: iconTextColor,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PrivacyPolicyScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                     const Divider(height: 1, color: Color(0xFFF2F4F7)),
//                     ListTile(
//                       leading: Image.asset(
//                         'assets/term.png',
//                         width: 24,
//                         height: 24,
//                         color: iconTextColor,
//                       ),
//                       title: Text(
//                         isToggled ? 'अटी आणि शर्ती' : 'Terms & Conditions',
//                         style: AppFontStyle2.blinker(color: iconTextColor),
//                       ),
//                       trailing: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: iconTextColor,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => TermsAndConditionsScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                     const Divider(height: 1, color: Color(0xFFF2F4F7)),
//                     ListTile(
//                       leading: Image.asset(
//                         'assets/notification.png',
//                         width: 24,
//                         height: 24,
//                         color: iconTextColor,
//                       ),
//                       title: Text(
//                         isToggled ? 'अस्वीकरण' : 'Disclaimer',
//                         style: AppFontStyle2.blinker(color: iconTextColor),
//                       ),
//                       trailing: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: iconTextColor,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DisclaimerScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                     const Divider(height: 1, color: Color(0xFFF2F4F7)),
//                     ListTile(
//                       leading: Image.asset(
//                         'assets/help.png',
//                         width: 24,
//                         height: 24,
//                         color: iconTextColor,
//                       ),
//                       title: Text(
//                         isToggled ? 'भाषा बदला' : 'Change Language',
//                         style: AppFontStyle2.blinker(color: iconTextColor),
//                       ),
//                       trailing: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: iconTextColor,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ChangeLanguageScreen(),
//                           ),
//                         ).then((_) {
//                           _loadToggleState(); // Refresh language when returning
//                         });
//                       },
//                     ),
//                     const Divider(height: 1, color: Color(0xFFF2F4F7)),
//                     ListTile(
//                       leading: Image.asset(
//                         'assets/help.png',
//                         width: 24,
//                         height: 24,
//                         color: iconTextColor,
//                       ),
//                       title: Text(
//                         isToggled ? 'मदत आणि समर्थन' : 'Help & Support',
//                         style: AppFontStyle2.blinker(color: iconTextColor),
//                       ),
//                       trailing: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: iconTextColor,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => HelpSupportPage(),
//                           ),
//                         );
//                       },
//                     ),
//                     const Divider(height: 1, color: Color(0xFFF2F4F7)),
//                     ListTile(
//                       leading: Image.asset(
//                         'assets/notification.png',
//                         width: 24,
//                         height: 24,
//                         color: iconTextColor,
//                       ),
//                       title: Text(
//                         isToggled ? 'सूचना' : 'Notifications',
//                         style: AppFontStyle2.blinker(color: iconTextColor),
//                       ),
//                       trailing: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: iconTextColor,
//                       ),
//                       onTap: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => NotificationPage(),
//                         //   ),
//                         // );
//                       },
//                     ),
//                     const Divider(height: 1, color: Color(0xFFF2F4F7)),
//                     ListTile(
//                       leading: Image.asset(
//                         'assets/power.png',
//                         width: 24,
//                         height: 24,
//                         color: iconTextColor,
//                       ),
//                       title: Text(
//                         isToggled ? 'लॉगआउट' : 'Logout',
//                         style: AppFontStyle2.blinker(color: iconTextColor),
//                       ),
//                       trailing: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: iconTextColor,
//                       ),
//                       onTap: () => _showLogoutConfirmationDialog(context),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: 15.0,
//                         left: 8,
//                         right: 8,
//                       ),
//                       child: Text(
//                         isToggled
//                             ? 'अस्वीकरण: भुलेक्स कोणत्याही सरकारी संस्थेशी संलग्न नाही आणि डेटाचा स्रोत प्रदान करणाऱ्या सरकारी संस्थांचे प्रतिनिधित्व करत नाही.'
//                             : 'Disclaimer: Bhulex is not affiliated with any government agency and does not represent government entities that provide the source of data.',
//                         style: AppFontStyle2.blinker(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: const Color(0xFF353B43),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           color: Color(0xFFFFFFFF),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0x14000000),
//               offset: Offset(2, 0),
//               blurRadius: 25,
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colorfile.bordertheme,
//           unselectedItemColor: Colorfile.lightgrey,
//           onTap: _onItemTapped,
//           showUnselectedLabels: true,
//           showSelectedLabels: true,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           items: [
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.home),
//               label: BottomNavigationStrings.getString('home', isToggled),
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.support_agent_outlined),
//               label: BottomNavigationStrings.getString(
//                 'customerCare',
//                 isToggled,
//               ),
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.edit_document),
//               label: BottomNavigationStrings.getString('myOrder', isToggled),
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.person),
//               label: BottomNavigationStrings.getString('myProfile', isToggled),
//             ),
//             // BottomNavigationBarItem(
//             //   icon: const Icon(Icons.person),
//             //   label: BottomNavigationStrings.getString('package', isToggled),
//             // ),
//             BottomNavigationBarItem(
//               icon: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // Icon(Icons.person),
//                   Image.asset(
//                     'assets/images/package.png',
//                     width: 21,
//                     height: 22,
//                   ),
//                 ],
//               ),
//               label: BottomNavigationStrings.getString('package', isToggled),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:bhulexapp/My_package/package_details_new.dart';
import 'package:bhulexapp/Order/order_list.dart';
import 'package:bhulexapp/colors/custom_color.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/order/language controller.dart';
import '../form_internet.dart';
import '../homepage.dart';
import '../network/url.dart';
import '../sign_up_screens/signup1.dart';
import 'about_bhulex.dart';
import 'change_language.dart';
import 'disclaimer.dart';
import 'help&support.dart';
import 'privacy_policy.dart';
import 'terms_and_conditions.dart';

class ProfilePage extends StatefulWidget {
  final bool isToggled;

  const ProfilePage({super.key, required this.isToggled});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3;
  final ImagePicker _picker = ImagePicker();
  bool isUploading = false;
  late bool isToggled;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  //final NetworkChecker _networkChecker = NetworkChecker(); // Add NetworkChecker
  final LanguageController languageController = Get.find<LanguageController>();

  @override
  void initState() {
    super.initState();
    isToggled = widget.isToggled;
    loadProfileImageUrl();
    loadCachedCustomerData();
    // _networkChecker.startMonitoring(context); // Start network monitoring

    fetchCustomer();
  }

  Future<void> loadProfileImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shareprefImageUrl = prefs.getString('profile_image_url') ?? '';
    });
  }

  Future<void> loadCachedCustomerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customerName = prefs.getString('customer_name') ?? '';
      customerMobile = prefs.getString('mobile_number') ?? '';
    });
  }

  Future<void> _loadToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isToggled = prefs.getBool('isToggled') ?? false;
    });
  }

  String iconPath = '';
  String customerName = '';
  String customerMobile = '';
  bool isLoading = true;
  List<dynamic> customerList = [];
  String? selectedState;
  String? profileImageUrl;
  String shareprefImageUrl = "";

  Future<bool> _checkConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      return !connectivityResult.contains(ConnectivityResult.none);
    } catch (e) {
      return false;
    }
  }

  void _showNoInternetPopup() {
    _scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          isToggled ? 'इंटरनेट कनेक्शन नाही' : 'No internet connection',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 6),
      ),
    );
  }

  Future<void> fetchCustomer() async {
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      setState(() {
        isLoading = false;
      });
      _showNoInternetPopup();
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? customerId = prefs.getString('customer_id');

    var requestBody = {"customer_id": customerId};

    final String url = URLS().get_customer_profile_apiUrl;
    log("Customer Profile API URL: $url");
    log("Request Body: ${jsonEncode(requestBody)}");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(requestBody),
      );

      print("Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        log("Parsed Response: ${response.body}");

        setState(() {
          customerList = responseData['data'] ?? [];
          iconPath = responseData['icon_path'] ?? '';
          profileImageUrl =
              customerList.isNotEmpty
                  ? "${responseData['icon_path']}${customerList[0]['profile_image']}"
                  : null;
          customerName =
              customerList.isNotEmpty
                  ? customerList[0]['customer_name'] ?? 'Customer Name'
                  : 'Customer Name';
          customerMobile =
              customerList.isNotEmpty &&
                      customerList[0]['mobile_number'] != null &&
                      customerList[0]['mobile_number'].toString().isNotEmpty
                  ? customerList[0]['mobile_number'].toString()
                  : 'Mobile number not available';
          isLoading = false;
        });

        // Cache name and number
        await prefs.setString('customer_name', customerName);
        await prefs.setString('mobile_number', customerMobile);

        if (customerList.isNotEmpty) {
          final customerName =
              customerList[0]['customer_name']?.toString().trim();
          if (customerName == null || customerName.isEmpty) {
            print("👤 Customer name is blank. Redirecting to profile page...");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(isToggled: isToggled),
              ),
            );
          }
        }
      } else {
        print("Failed with status: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Exception: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> updateProfileImage(File imageFile) async {
    try {
      setState(() => isUploading = true);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String customerId = prefs.getString('customer_id') ?? '1';

      var url = Uri.parse("https://seekhelp.in/bhulex/update_profile");
      var request = http.MultipartRequest('POST', url);

      // Add customer ID
      request.fields['customer_id'] = customerId;

      // Attach image file
      var multipartFile = await http.MultipartFile.fromPath(
        'profile_image',
        imageFile.path,
        filename: imageFile.path.split('/').last,
      );
      request.files.add(multipartFile);

      // Send request
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(responseBody.body);

        if (jsonData['status'] == "true") {
          final newImageUrl =
              "${jsonData['profile_image_path']}${jsonData['data']['profile_image']}";

          // Save it in shared preferences
          await prefs.setString("profile_image_url", newImageUrl);

          setState(() {
            profileImageUrl = newImageUrl;
            log("Updated profile image URL: $profileImageUrl");
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile image updated successfully!'),
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProfilePage(isToggled: isToggled);
              },
            ),
          ); // Close the modal
        } else {
          throw Exception(jsonData['message'] ?? 'API returned false status');
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Upload Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error uploading image: $e')));
    } finally {
      setState(() => isUploading = false);
    }
  }

  void showEditProfileImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 24,
                    right: 24,
                    top: 16,
                  ),
                  child: Wrap(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.photo,
                              size: 40,
                              color: Colors.orange,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              isToggled
                                  ? 'प्रोफाइल फोटो संपादित करा'
                                  : 'Edit Profile Photo',
                              style: AppFontStyle2.blinker(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF36322E),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              isToggled
                                  ? 'आपला फोटो अपडेट करण्यासाठी एक पद्धत निवडा'
                                  : 'Choose a method to update your photo',
                              textAlign: TextAlign.center,
                              style: AppFontStyle2.blinker(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap:
                                          isUploading
                                              ? null
                                              : () async {
                                                final XFile? image =
                                                    await _picker.pickImage(
                                                      source:
                                                          ImageSource.camera,
                                                      imageQuality: 85,
                                                    );
                                                if (image != null)
                                                  await updateProfileImage(
                                                    File(image.path),
                                                  );
                                              },
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.orange.shade100,
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 28,
                                          color: Colors.orange.shade800,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      isToggled ? 'कॅमेरा' : 'Camera',
                                      style: AppFontStyle2.blinker(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.orange.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap:
                                          isUploading
                                              ? null
                                              : () async {
                                                final XFile? image =
                                                    await _picker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                    );
                                                if (image != null)
                                                  await updateProfileImage(
                                                    File(image.path),
                                                  );
                                              },
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.orange.shade100,
                                        child: Icon(
                                          Icons.photo_library,
                                          size: 28,
                                          color: Colors.orange.shade800,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      isToggled ? 'गॅलरी' : 'Gallery',
                                      style: AppFontStyle2.blinker(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.orange.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed:
                                  isUploading
                                      ? null
                                      : () => Navigator.pop(context),
                              child: Text(
                                isToggled ? 'रद्द करा' : 'Cancel',
                                style: AppFontStyle2.blinker(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isUploading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: MediaQuery.of(context).viewInsets,
          color: Colors.transparent,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Wrap(
              children: [
                ClipRect(
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isToggled ? 'लॉगआउट' : 'Logout',
                          style: AppFontStyle.inter(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF26500),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(height: 1, color: Colors.grey[300]),
                        const SizedBox(height: 20),
                        const Icon(
                          Icons.power_settings_new,
                          size: 50,
                          color: Colors.orange,
                        ),
                        Text(
                          isToggled ? 'लवकरच परत या!' : 'Come back soon!',
                          style: AppFontStyle.poppins(
                            // fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xFF36322E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            isToggled
                                ? 'लॉगआउट केल्याने आपले सत्र संपेल\nआपण पुढे जाऊ इच्छिता का?'
                                : 'Logging out will end your session\nDo you wish to proceed?',
                            textAlign: TextAlign.center,
                            style: AppFontStyle.poppins(
                              // fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                style: ButtonStyle(
                                  side: MaterialStateProperty.resolveWith<
                                    BorderSide
                                  >(
                                    (states) =>
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder
                                  >(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  isToggled ? 'रद्द करा' : 'Cancel',
                                  style: AppFontStyle.inter(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences idsaver =
                                      await SharedPreferences.getInstance();
                                  await idsaver.clear();
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Signup1(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                        const Color(0xFFF26500),
                                      ),
                                  shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder
                                  >(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  isToggled ? 'लॉगआउट' : 'Logout',
                                  style: AppFontStyle.inter(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage2(customer_id: '', customerId: ''),
          ),
        );
        // Navigator.pop(context); // Return to HomePage2
        print("Home tapped");
        break;
      case 1:
        print("Customer Care tapped");
        break;
      case 2:
        print("My Order tapped");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => MyOrderScreen(package_id: '', customer_id: ''),
          ),
        );
        break;
      case 3:
        print("My package tapped");

        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PackageScreen(
                  customerid: '',
                  package_id: '',
                  tbl_name: '',
                  customerId: '',
                ),
          ),
        );

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const iconTextColor = Color(0xFF353B43);
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colorfile.appbar,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              HomePage2(customer_id: '', customerId: ''),
                    ),
                  );
                },
              ),
              Text(
                BottomNavigationStrings.getString('myProfile', isToggled),
                style: AppFontStyle2.blinker(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF353B43),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          (shareprefImageUrl.isNotEmpty)
                              ? NetworkImage(shareprefImageUrl)
                              : const AssetImage('assets/edit-02.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => showEditProfileImageBottomSheet(context),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colorfile.bordertheme,
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                customerName.isNotEmpty ? customerName : 'Customer Name',
                style: AppFontStyle2.blinker(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: iconTextColor,
                ),
              ),
              Text(
                customerMobile.isNotEmpty
                    ? customerMobile
                    : 'Mobile number not available',
                style: AppFontStyle2.blinker(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400,
                height: 620,
                padding: const EdgeInsets.only(top: 7, bottom: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFE5E7EB), width: 0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  color: Colorfile.body,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Image.asset(
                          'assets/privacy.png',
                          width: 24,
                          height: 24,
                          color: iconTextColor,
                        ),
                        title: Text(
                          isToggled ? 'आमच्याबद्दल' : 'About',
                          style: AppFontStyle2.blinker(color: iconTextColor),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: iconTextColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutBhulexPage(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F4F7)),
                      ListTile(
                        leading: Image.asset(
                          'assets/privacy.png',
                          width: 24,
                          height: 24,
                          color: iconTextColor,
                        ),
                        title: Text(
                          isToggled ? 'गोपनीयता धोरण' : 'Privacy Policy',
                          style: AppFontStyle2.blinker(color: iconTextColor),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: iconTextColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyPolicyScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F4F7)),
                      ListTile(
                        leading: Image.asset(
                          'assets/term.png',
                          width: 24,
                          height: 24,
                          color: iconTextColor,
                        ),
                        title: Text(
                          isToggled ? 'अटी आणि शर्ती' : 'Terms & Conditions',
                          style: AppFontStyle2.blinker(color: iconTextColor),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: iconTextColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TermsAndConditionsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F4F7)),
                      ListTile(
                        leading: Image.asset(
                          'assets/notification.png',
                          width: 24,
                          height: 24,
                          color: iconTextColor,
                        ),
                        title: Text(
                          isToggled ? 'अस्वीकरण' : 'Disclaimer',
                          style: AppFontStyle2.blinker(color: iconTextColor),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: iconTextColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisclaimerScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F4F7)),
                      ListTile(
                        leading: Image.asset(
                          'assets/help.png',
                          width: 24,
                          height: 24,
                          color: iconTextColor,
                        ),
                        title: Text(
                          isToggled ? 'भाषा बदला' : 'Change Language',
                          style: AppFontStyle2.blinker(color: iconTextColor),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: iconTextColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeLanguageScreen(),
                            ),
                          ).then((_) {
                            _loadToggleState(); // Refresh language when returning
                          });
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F4F7)),
                      ListTile(
                        leading: Image.asset(
                          'assets/help.png',
                          width: 24,
                          height: 24,
                          color: iconTextColor,
                        ),
                        title: Text(
                          isToggled ? 'मदत आणि समर्थन' : 'Help & Support',
                          style: AppFontStyle2.blinker(color: iconTextColor),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: iconTextColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpSupportPage(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F4F7)),
                      ListTile(
                        leading: Image.asset(
                          'assets/notification.png',
                          width: 24,
                          height: 24,
                          color: iconTextColor,
                        ),
                        title: Text(
                          isToggled ? 'सूचना' : 'Notifications',
                          style: AppFontStyle2.blinker(color: iconTextColor),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: iconTextColor,
                        ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => NotificationPage(),
                          //   ),
                          // );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F4F7)),
                      ListTile(
                        leading: Image.asset(
                          'assets/power.png',
                          width: 24,
                          height: 24,
                          color: iconTextColor,
                        ),
                        title: Text(
                          isToggled ? 'लॉगआउट' : 'Logout',
                          style: AppFontStyle2.blinker(color: iconTextColor),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: iconTextColor,
                        ),
                        onTap: () => _showLogoutConfirmationDialog(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 8,
                          right: 8,
                        ),
                        child: Text(
                          isToggled
                              ? 'अस्वीकरण: भुलेक्स कोणत्याही सरकारी संस्थेशी संलग्न नाही आणि डेटाचा स्रोत प्रदान करणाऱ्या सरकारी संस्थांचे प्रतिनिधित्व करत नाही.'
                              : 'Disclaimer: Bhulex is not affiliated with any government agency and does not represent government entities that provide the source of data.',
                          style: AppFontStyle2.blinker(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF353B43),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                offset: Offset(2, 0),
                blurRadius: 25,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Obx(
            () => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: BottomNavigationStrings.getString(
                    'home',
                    languageController.isToggled.value,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.support_agent_outlined),
                  label: BottomNavigationStrings.getString(
                    'customerCare',
                    languageController.isToggled.value,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.edit_document),
                  label: BottomNavigationStrings.getString(
                    'myOrder',
                    languageController.isToggled.value,
                  ),
                ),

                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: BottomNavigationStrings.getString(
                    'myProfile',
                    languageController.isToggled.value,
                  ),
                ),
                // BottomNavigationBarItem(
                //   icon: const Icon(Icons.person),
                //   label: BottomNavigationStrings.getString(
                //     'package',
                //     languageController.isToggled.value,
                //   ),
                // ),
                BottomNavigationBarItem(
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/packageicon.png',
                        width: 21,
                        height: 22,
                      ),
                    ],
                  ),
                  label: BottomNavigationStrings.getString(
                    'Package',
                    languageController.isToggled.value,
                  ),
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colorfile.bordertheme,
              unselectedItemColor: Colorfile.lightgrey,
              onTap: _onItemTapped,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
