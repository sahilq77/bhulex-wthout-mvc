// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:bhulexapp/Core/ColorFile.dart';
import 'package:bhulexapp/utils/responsive_helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Core/AppImages.dart';
import '../colors/custom_color.dart';
import '../colors/order_fonts.dart';
import '../language/hindi.dart';
import '../network/url.dart';

class LegalDraftsNew extends StatefulWidget {
  final String id;
  final String serviceName;
  final String tblName;
  final String packageId;
  final bool isToggled;
  final String serviceNameInLocalLanguage;
  final String lead_id;
  final String customer_id;
  final String package_lead_id;

  const LegalDraftsNew({
    super.key,
    required this.id,
    required this.serviceName,
    required this.packageId,
    required this.tblName,
    required this.isToggled,
    required this.serviceNameInLocalLanguage,
    required this.lead_id,
    required this.customer_id,
    required this.package_lead_id,
  });

  @override
  _oldextract1State createState() => _oldextract1State();
}

class _oldextract1State extends State<LegalDraftsNew> {
  final TextEditingController _FieldSurveyNoController =
      TextEditingController();

  String? Selectedcity;
  String? SelectedId;
  List<String> selectedServiceIds =
      []; // Fixed: Now a List<String>, initialized
  PlatformFile? selectedFile;

  List<Map<String, dynamic>> talukaData = [];
  String? selectedTaluka;
  String? selectedTalukaId;

  List<Map<String, dynamic>> CityData = [];
  List<Map<String, dynamic>> villageData = [];
  String? selectedVillageName;
  String? selectedVillageId;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;

  // Services data with isSelected flag
  List<Map<String, dynamic>> services = [
    {"id": "1", "name": "Legal Notice", "isSelected": false},
    {"id": "2", "name": "Legal Notice for Money Recovery", "isSelected": false},
    {
      "id": "3",
      "name": "Legal Notice for recovery of dues",
      "isSelected": false,
    },
    {
      "id": "4",
      "name": "Legal Notice Under Consumer Protection Act",
      "isSelected": false,
    },
    {"id": "5", "name": "Rental Agreement", "isSelected": false},
  ];

  @override
  void initState() {
    super.initState();
    _fetchCity();
  }

  Future<void> submitOldServiceForm(
    BuildContext context,
    Map<String, dynamic> formData,
  ) async {
    // Use isSelected to get selected service IDs
    formData['selected_services'] = services
        .where((service) => service['isSelected'] == true)
        .map((service) => service['id'])
        .toList();

    final String url = URLS().submit_old_record_enquiry_form_apiUrl;

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Form submission failed')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Network error occurred')));
    }
  }

  void _fetchCity() async {
    final String url = URLS().get_all_city_apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('state_id', '22');

    var requestBody = {"state_id": "22"};
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'true') {
          setState(() {
            CityData = List<Map<String, dynamic>>.from(data['data'] ?? []);
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _fetchTaluka(String cityId) async {
    final String url = URLS().get_all_taluka_apiUrl;
    var requestBody = {"city_id": cityId};
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'true') {
          setState(() {
            talukaData = List<Map<String, dynamic>>.from(data['data'] ?? []);
          });
        }
      }
    } catch (e) {
      log('Taluka Fetch Error: $e');
    }
  }

  void _fetchVillages(String cityId, String talukaId) async {
    final String url = URLS().get_all_village_apiUrl;
    var requestBody = {"city_id": cityId, "taluka_id": talukaId};
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'true') {
          setState(() {
            villageData = List<Map<String, dynamic>>.from(data['data'] ?? []);
          });
        }
      }
    } catch (e) {
      log('Village Fetch Error: $e');
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      Selectedcity = null;
      selectedTaluka = null;
      selectedVillageName = null;
      selectedTalukaId = null;
      selectedVillageId = null;
      _FieldSurveyNoController.clear();
      selectedServiceIds.clear();
      services = services.map((service) {
        return {...service, 'isSelected': false};
      }).toList();
    });
    _fetchCity();
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
          ),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
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
            physics: const AlwaysScrollableScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Note Box
                  Container(
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
                      LocalizedStrings.getString('note', widget.isToggled),
                      style: AppFontStyle2.blinker(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF36322E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    LocalizedStrings.getString(
                      'selectServices',
                      widget.isToggled,
                    ),
                    style: AppFontStyle2.blinker(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF36322E),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Fixed DropdownSearch
                  DropdownSearch<String>.multiSelection(
                    items: services.map((s) => s['name'] as String).toList(),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: LocalizedStrings.getString(
                          'selectServices',
                          widget.isToggled,
                        ),
                        labelText: LocalizedStrings.getString(
                          'selectServices',
                          widget.isToggled,
                        ),
                        hintStyle: AppFontStyle2.blinker(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF36322E),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color(0xFFC5C5C5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color(0xFFC5C5C5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color(0xFFC5C5C5),
                          ),
                        ),
                      ),
                    ),
                    popupProps: const PopupPropsMultiSelection.menu(
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          hintText: "Search services...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    selectedItems: services
                        .where((s) => selectedServiceIds.contains(s['id']))
                        .map((s) => s['name'] as String)
                        .toList(),
                    onChanged: (List<String> selectedNames) {
                      setState(() {
                        // Update selected IDs
                        selectedServiceIds = services
                            .where((s) => selectedNames.contains(s['name']))
                            .map((s) => s['id'] as String)
                            .toList();

                        // Update isSelected flag in services list
                        services = services.map((service) {
                          return {
                            ...service,
                            'isSelected': selectedNames.contains(
                              service['name'],
                            ),
                          };
                        }).toList();
                      });
                    },
                    dropdownButtonProps: const DropdownButtonProps(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 28,
                        color: Color(0xFF9CA3AF),
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
                      const SizedBox(height: 30),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF26500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              final String? stateId = prefs.getString(
                                'state_id',
                              );
                              final prepaidCustomerId = prefs.getString(
                                'customer_id',
                              );

                              Map<String, dynamic> formData = {
                                "tbl_name": widget.tblName,
                                "lead_id": widget.package_lead_id,
                                "customer_id": prepaidCustomerId,
                                "package_id": widget.packageId,
                                "state_id": stateId,
                                "city_id": SelectedId,
                                "taluka_id": selectedTalukaId,
                                "village_id": selectedVillageId,
                                "survey_no": _FieldSurveyNoController.text,
                              };

                              submitOldServiceForm(context, formData);
                            }
                          },
                          child: Text(
                            LocalizedStrings.getString(
                              'next',
                              widget.isToggled,
                            ),
                            style: AppFontStyle2.blinker(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // View Sample Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colorfile.borderDark),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            print("View Sample button pressed");
                          },
                          child: Text(
                            LocalizedStrings.getString(
                              'viewSample',
                              widget.isToggled,
                            ),
                            style: AppFontStyle2.blinker(
                              color: Colorfile.lightblack,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
