

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:bhulex/colors/custom_color.dart'; // Assuming this is where Colorfile is defined.
// import 'package:bhulex/languages/english.dart'; // Import the English language file
// import 'package:bhulex/languages/hindi.dart'; // Import the Hindi language file
// import 'package:bhulex/languages/german.dart';
// import 'package:my_bhulekh_app/colors/custom_color.dart';

// import 'Orders/order_list.dart';
// import 'Profile/profile.dart';
// import 'package/package_details.dart'; // Import the German language file

// class HomePage2 extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage2> {
//   String? selectedState;
//   bool isToggled = false;
//   int _selectedIndex = 0; // To track the selected bottom navigation item
//   final List<Map<String, dynamic>> packages = [
//     {
//       "offerName": "Home Loan/Loan Against Property ",
//       "description": "Lorem Ipsum has been the store standard dummy text",
//       "iconPath": "assets/images/package1.png",
//       "services": ["Consultation", "Processing", "Approval"],
//     },
//     {
//       "offerName": "Agriculture Loan",
//       "description": "Lorem Ipsum has been the store standard dummy text",
//       "iconPath": "assets/images/package2.png",
//       "services": ["Loan Assistance", "Guidance", "Subsidy Support"],
//     },
//   ];
//   Future<void> _refreshData(BuildContext context) async {
//     await Future.delayed(Duration(seconds: 2));
//   }

//   // List of icon paths
//   List<String> iconPaths = [
//     'assets/quickservices/icon1.png',
//     'assets/quickservices/icon2.png',
//     'assets/quickservices/icon3.png',
//     'assets/quickservices/icon4.png',
//     'assets/quickservices/icon5.png',
//     'assets/quickservices/icon6.png',
//     'assets/quickservices/icon7.png',
//     'assets/quickservices/icon8.png',
//   ];

//   List<String> eapplications = [
//     'assets/eapplications/icon1.png',
//     'assets/eapplications/icon2.png',
//     'assets/eapplications/icon3.png',
//     'assets/eapplications/icon4.png',
//     'assets/eapplications/icon5.png',
//     'assets/eapplications/icon6.png',
//     'assets/eapplications/icon7.png',
//     'assets/eapplications/icon8.png',
//   ];
//   static const List<String> eapplicationLabels = [
//     'E-leave & Licence',
//     'E-Challans',
//     'E-Property Valuation',
//     'Notice of Intimation',
//     'Mutation Application',
//     'Property Card Mutation Application',
//     'Check Mutation Status ',
//     'Aapli Chawadi',
//   ];
//   List<String> oldRecords = [
//     'assets/oldrecords/icon1.png',
//     'assets/oldrecords/icon2.png',
//     'assets/oldrecords/icon3.png',
//     'assets/oldrecords/icon4.png',
//   ];

//   static const List<String> oldrecordLabels = [
//     'Old 7/12 Extract',
//     'Old 8A Extract',
//     'Old mutation Extract',
//     'Old Bhu Naksha Rural / urban ',
//   ];
//   List<String> investigative = [
//     'assets/investigative/icon1.png',
//     'assets/investigative/icon2.png',
//     'assets/investigative/icon3.png',
//     'assets/investigative/icon4.png',
//   ];
//   static const List<String> investigativeLabels = [
//     'CEERSAI Reports',
//     'RERA Builder Documents',
//     'Mortgage Report',
//     'Registered Document Download',
//   ];
//   List<String> legaladvisory = [
//     'assets/legaladvisory/icon1.png',
//     'assets/legaladvisory/icon2.png',
//     'assets/legaladvisory/icon3.png',
//     'assets/legaladvisory/icon4.png',
//     'assets/legaladvisory/icon5.png',
//   ];
//   static const List<String> legaladvisoryLabels = [
//     'Title Investigation Report',
//     'Legal Drafts',
//     'Court cases/orders Search',
//     'Adhikar Abhilekh',
//     'Legal Consultation',
//   ];

//   // Texts for "Quick Services" and "Instant" in English, Hindi, and German
//   String get quickServices =>
//       isToggled
//           ? (selectedState == 'german'
//               ? German.quickServices
//               : Hindi.quickServices)
//           : English.quickServices;
//   String get instant =>
//       isToggled
//           ? (selectedState == 'german' ? German.instant : Hindi.instant)
//           : English.instant;
//   List<String> get states =>
//       selectedState == 'german'
//           ? German.states
//           : (isToggled ? Hindi.states : English.states);
//   List<String> get labels =>
//       selectedState == 'german'
//           ? German.labels
//           : (isToggled ? Hindi.labels : English.labels);
//   String get pleaseSelectState =>
//       selectedState == 'german'
//           ? German.pleaseSelectState
//           : (isToggled ? Hindi.pleaseSelectState : English.pleaseSelectState);

//   // Handler for bottom navigation bar tap
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     // Add navigation logic here if needed
//     switch (index) {
//       case 0:
//         print("Home tapped");
//         break;
//       case 1:
//         print("Customer Care tapped");
//         break;
//       case 2:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MyOrderScreen()),
//         );
//         print("My Order tapped");
//         break;
//       case 3:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ProfilePage()),
//         );
//         print("My Profile tapped");
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colorfile.appbar,
//       appBar: AppBar(
//         backgroundColor: Colorfile.body,
//         title: Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: Image.asset('assets/images/bhulex.png', height: 40),
//         ),
//         shape: Border(bottom: BorderSide(color: Colorfile.border, width: 1.0)),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Row(
//               children: [
//                 Container(
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       CupertinoSwitch(
//                         value: isToggled,
//                         onChanged: (bool newValue) {
//                           setState(() {
//                             isToggled = newValue;
//                           });
//                         },
//                         activeColor: Colorfile.bordertheme,
//                       ),
//                       if (!isToggled)
//                         Positioned(
//                           right: 10,
//                           child: Text(
//                             'अ',
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w400,
//                               color: Colorfile.lightblack,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: IconButton(
//               icon: Icon(Icons.search, size: 30, color: Colorfile.lightblack),
//               onPressed: () {
//                 print('Search icon pressed');
//               },
//             ),
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () => _refreshData(context),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     pleaseSelectState,
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colorfile.lightblack,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colorfile.bordertheme),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         value: selectedState,
//                         hint: Text(
//                           isToggled ? 'राज्य चुनें' : 'Choose a state',
//                         ),
//                         isExpanded: true,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectedState = newValue;
//                           });
//                         },
//                         items:
//                             [
//                               'Andhra Pradesh',
//                               'Arunachal Pradesh',
//                               'Assam',
//                               'Bihar',
//                               'Odisha',
//                               'Punjab',
//                               'Rajasthan',
//                               'Sikkim',
//                               'Tamil Nadu',
//                               // 'german', // Add "german" as an option
//                             ].map((String state) {
//                               return DropdownMenuItem<String>(
//                                 value: state,
//                                 child: Text(state),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         quickServices,
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colorfile.lightblack,
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Text(
//                         instant,
//                         style: GoogleFonts.poppins(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           color: Colorfile.lightgrey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       childAspectRatio: 1,
//                     ),
//                     itemCount: iconPaths.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           Image.asset(iconPaths[index], height: 20, width: 20),
//                           SizedBox(height: 5),
//                           Text(
//                             labels[index],
//                             style: GoogleFonts.poppins(
//                               fontSize: 9,
//                               fontWeight: FontWeight.w500,
//                               color: Colorfile.lightblack,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Old Records Of Rights ',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colorfile.lightblack,
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Text(
//                         'within 12 hours',
//                         style: GoogleFonts.poppins(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           color: Colorfile.lightgrey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       childAspectRatio: 1,
//                     ),
//                     itemCount:
//                         oldRecords.length > oldrecordLabels.length
//                             ? oldrecordLabels.length
//                             : oldRecords.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           Image.asset(oldRecords[index], height: 20, width: 20),
//                           SizedBox(height: 5),
//                           Text(
//                             oldrecordLabels[index],
//                             style: GoogleFonts.poppins(
//                               fontSize: 9,
//                               fontWeight: FontWeight.w500,
//                               color: Colorfile.lightblack,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Investigative Reports',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colorfile.lightblack,
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Text(
//                         'within 12 hours',
//                         style: GoogleFonts.poppins(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           color: Colorfile.lightgrey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       childAspectRatio: 1,
//                     ),
//                     itemCount:
//                         investigative.length > investigativeLabels.length
//                             ? investigativeLabels.length
//                             : investigative.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           Image.asset(
//                             investigative[index],
//                             height: 20,
//                             width: 20,
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             investigativeLabels[index],
//                             style: GoogleFonts.poppins(
//                               fontSize: 9,
//                               fontWeight: FontWeight.w500,
//                               color: Colorfile.lightblack,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Legal Advisory',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colorfile.lightblack,
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Text(
//                         'within 24 hours',
//                         style: GoogleFonts.poppins(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           color: Colorfile.lightgrey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 5, // 5 columns
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       childAspectRatio: 1,
//                     ),
//                     itemCount:
//                         legaladvisory.length > legaladvisoryLabels.length
//                             ? legaladvisoryLabels.length
//                             : legaladvisory.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           Image.asset(
//                             legaladvisory[index],
//                             height: 20,
//                             width: 20,
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             legaladvisoryLabels[index],
//                             style: GoogleFonts.poppins(
//                               fontSize: 9,
//                               fontWeight: FontWeight.w500,
//                               color: Colorfile.lightblack,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 18.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'E-Applications',
//                           style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: Colorfile.lightblack,
//                           ),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'within 12 hours',
//                           style: GoogleFonts.poppins(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w500,
//                             color: Colorfile.lightgrey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       crossAxisSpacing: 30,
//                       mainAxisSpacing: 10,
//                       childAspectRatio: 1,
//                     ),
//                     itemCount: eapplications.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           Image.asset(
//                             eapplications[index],
//                             height: 20,
//                             width: 20,
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             eapplicationLabels[index],
//                             style: GoogleFonts.poppins(
//                               fontSize: 9,
//                               fontWeight: FontWeight.w500,
//                               color: Colorfile.lightblack,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 18.0),
//                     child: Text(
//                       'Packages',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: Colorfile.lightblack,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 15.0,
//                       right: 20,
//                       bottom: 10,
//                     ),
//                     child: Column(
//                       children: [
//                         SingleChildScrollView(
//                           scrollDirection:
//                               Axis.horizontal, // Horizontal scrolling
//                           child: Row(
//                             children: List.generate(packages.length, (index) {
//                               final offer = packages[index];

//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder:
//                                             (context) => PackageDetailsPage(),
//                                       ),
//                                     );
//                                     // Handle the tap event here
//                                     print("Tapped on: ${offer['offerName']}");
//                                   },
//                                   child: Container(
//                                     width:
//                                         200, // Fixed width for horizontal scrolling consistency
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(
//                                         color: const Color(
//                                           0xFFDFE6F8,
//                                         ), // Border color
//                                         width: 0.5, // Border width
//                                       ),
//                                       color: Colors.white,
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Image.asset(
//                                             offer['iconPath'] ??
//                                                 'images/package1.png',
//                                             width: 40,
//                                             height: 40,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             offer['offerName'] ??
//                                                 'No Offer Name',
//                                             style: const TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w600,
//                                               color: Color(0xFF353B43),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 1),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 8.0,
//                                           ),
//                                           child: Text(
//                                             offer['description'] ??
//                                                 'No Description',
//                                             style: const TextStyle(
//                                               fontSize: 8,
//                                               fontWeight: FontWeight.w400,
//                                               color: Color(0xFF4B5563),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Wrap(
//                                             spacing: 5,
//                                             runSpacing: 5,
//                                             children:
//                                                 (offer['services']
//                                                         as List<String>?)
//                                                     ?.map((service) {
//                                                       return Container(
//                                                         padding:
//                                                             const EdgeInsets.symmetric(
//                                                               horizontal: 8,
//                                                               vertical: 4,
//                                                             ),
//                                                         decoration: BoxDecoration(
//                                                           color: Color(
//                                                             0xFFF5F4F1,
//                                                           ),
//                                                           borderRadius:
//                                                               BorderRadius.circular(
//                                                                 5,
//                                                               ),
//                                                           border: Border.all(
//                                                             color: Color(
//                                                               0xFFE5E7EB,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         child: Text(
//                                                           service,
//                                                           style:
//                                                               const TextStyle(
//                                                                 fontSize: 7,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 color: Color(
//                                                                   0xFF757575,
//                                                                 ),
//                                                               ),
//                                                         ),
//                                                       );
//                                                     })
//                                                     .toList() ??
//                                                 [],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFFFFFFFF), // Background color #FFFFFF (white)
//           boxShadow: [
//             BoxShadow(
//               color: Color(
//                 0x14000000,
//               ), // Shadow color #00000014 (black with 8% opacity)
//               offset: Offset(2, 0), // 2px horizontal, 0px vertical
//               blurRadius: 25, // 25px blur radius
//               spreadRadius: 0, // 0px spread
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.support_agent_outlined),
//               label: 'Customer Care',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.edit_document),
//               label: 'My Order',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'My Profile',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colorfile.bordertheme,
//           unselectedItemColor: Colorfile.lightgrey,
//           onTap: _onItemTapped,
//           showUnselectedLabels: true,
//           showSelectedLabels: true,
//           backgroundColor:
//               Colors
//                   .transparent, // Make BottomNavigationBar background transparent
//           elevation: 0, // Remove default elevation shadow
//         ),
//       ),
//     );
//   }
// }
