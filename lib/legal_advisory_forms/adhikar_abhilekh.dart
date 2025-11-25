import 'dart:convert';
import 'dart:developer';

import 'package:bhulexapp/Core/ColorFile.dart';
import 'package:bhulexapp/utils/responsive_helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http show post;

import 'package:shared_preferences/shared_preferences.dart';

import '../Core/AppImages.dart';
import '../My_package/package_order_details.dart';
import '../colors/custom_color.dart';
import '../colors/order_fonts.dart';
import '../form_internet.dart' show NetworkChecker;
import '../language/hindi.dart';
import '../network/url.dart';
import '../quicke_services_forms/pay.dart';
import '../validations_chan_lang/adhikarabhilekhvali.dart';

class Adhikar_Abhilekh extends StatefulWidget {
  final String id;
  final String serviceName;
  final String tblName;
  final String packageId;
  final bool isToggled;
  final String serviceNameInLocalLanguage;
  final String lead_id;
  final String package_lead_id;
  final String customerid;
  const Adhikar_Abhilekh({
    super.key,
    required this.packageId,
    required this.id,
    required this.serviceName,
    required this.tblName,
    required this.isToggled,
    required this.serviceNameInLocalLanguage,
    required this.lead_id,
    required this.customerid,
    required this.package_lead_id,
  });

  @override
  _Adhikar_AbhilekhState createState() => _Adhikar_AbhilekhState();
}

class _Adhikar_AbhilekhState extends State<Adhikar_Abhilekh> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _surveyNoController = TextEditingController();
  final TextEditingController _ByNameIncasesurveynoisnotknownController =
      TextEditingController();

  String? Selectedcity;
  String? SelectedId;
  PlatformFile? selectedFile;
  List<Map<String, dynamic>> talukaData = [];
  String? selectedTaluka;
  List<Map<String, dynamic>> CityData = [];
  List<Map<String, dynamic>> villageData = [];
  String? selectedVillageName;
  String? selectedVillageId;
  String? selectedTalukaId;
  bool isLoading = true;
  final NetworkChecker _networkChecker = NetworkChecker(); // Add NetworkChecker

  @override
  void initState() {
    super.initState();
    _networkChecker.startMonitoring(context); // Start network monitoring
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      Selectedcity = null;
      _surveyNoController.clear();
      selectedVillageName = null;
      selectedTaluka = null;
      _ByNameIncasesurveynoisnotknownController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    String displayServiceName = widget.isToggled
        ? widget.serviceNameInLocalLanguage
        : widget.serviceName;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        title: Text(
          displayServiceName,
          style: AppFontStyle2.blinker(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF36322E),
            height: 1.57,
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
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.00,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0x40F57C03),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 0.5,
                          color: const Color(0xFFFCCACA),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(14, 14, 18, 14),
                      child: Text(
                        AdhikarAbhilekhStrings.getString(
                          'note',
                          widget.isToggled,
                        ),
                        style: AppFontStyle2.blinker(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          height: 1.57,
                          color: const Color(0xFF36322E),
                        ), // style: GoogleFonts.inter(
                        //   fontSize: 11,
                        //   fontWeight: FontWeight.w400,
                        //   color: const Color(0xFF36322E),
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.spacing(16)),
                  _sectionTitle(
                    AppImages.uploadIcon,
                    "Document Upload ", // You can make * optional based on logic later
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _sectionTitle(
                      //   "",
                      //   "Document Upload *", // You can make * optional based on logic later
                      // ),
                      const SizedBox(height: 10),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(8),
                        color: selectedFile == null ? Colors.red : Colors.grey,
                        strokeWidth: 1.0,
                        dashPattern: const [4, 4],
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    'pdf',
                                    'doc',
                                    'docx',
                                    'jpg',
                                    'jpeg',
                                    'png',
                                  ],
                                  allowMultiple: false,
                                );

                            if (result != null && result.files.isNotEmpty) {
                              setState(() {
                                selectedFile = result.files.first;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Selected: ${result.files.first.name}',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (selectedFile == null) ...[
                                    SvgPicture.asset(
                                      AppImages
                                          .uploadBigIcon, // or any upload icon
                                      height: 32,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Upload Document",
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Drag & drop or click to browse",
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ] else ...[
                                    Icon(
                                      Icons.description,
                                      size: 40,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      selectedFile!.name,
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${(selectedFile!.size / 1024).toStringAsFixed(1)} KB",
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF26500),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () {
                            print("View Sample button pressed");
                          },
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  AppImages.callWhiteIcon,
                                  height: ResponsiveHelper.spacing(25),
                                  width: ResponsiveHelper.spacing(2),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  LocalizedStrings.getString(
                                    'bookCall',
                                    widget.isToggled,
                                  ),
                                  style: AppFontStyle2.blinker(
                                    color: Colorfile.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colorfile.lightwhite),
                          color: Colorfile.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () {
                            print("Chat with Us button pressed");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.whatsappGreenIcon),
                              const SizedBox(width: 8),
                              Text(
                                LocalizedStrings.getString(
                                  'chatWithUs',
                                  widget.isToggled,
                                ),
                                style: AppFontStyle2.blinker(
                                  color: Colorfile.lightblack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _sectionTitle(String icon, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 5),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.defaultblack,
          ),
        ),
      ],
    );
  }
}
