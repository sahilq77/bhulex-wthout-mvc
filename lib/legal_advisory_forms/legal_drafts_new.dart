// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  List<Map<String, dynamic>> talukaData = [];
  String? selectedTaluka;
  List<Map<String, dynamic>> CityData = [];
  List<Map<String, dynamic>> villageData = [];
  String? selectedVillageName;
  String? selectedVillageId;
  String? selectedTalukaId;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;

  // Services data
  List<Map<String, dynamic>> services = [
    {"id": "1", "name": "Legal Notice", "isSelected": false},
    {
      "id": "2",
      "name": "Legal Notice for Money Recovery ",
      "isSelected": false,
    },
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
    formData['selected_services'] = services
        .where((service) => service['isSelected'])
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Form submitted successfully')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Form submission failed')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Network error')));
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
      _FieldSurveyNoController.clear();
      services = services.map((service) {
        return {...service, 'isSelected': false};
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        LocalizedStrings.getString('note', widget.isToggled),
                        style: AppFontStyle2.blinker(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF36322E),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                  Column(
                    children: services.map((service) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              service['isSelected'] = !service['isSelected'];
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: service['isSelected']
                                    ? const Color(0xFF343A40)
                                    : const Color(0xFFD9D9D9),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  service['name'],
                                  style: AppFontStyle2.blinker(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF36322E),
                                  ),
                                ),
                                if (service['isSelected'])
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF343A40),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF26500),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final String? stateId = prefs.getString('state_id');
                            final prepaidCustomerId = prefs.getString(
                              'customer_id',
                            );
                            Map<String, dynamic> formData = {
                              "tbl_name": widget.tblName,
                              "lead_id": widget.package_lead_id,
                              "customer_id": prepaidCustomerId,
                              "package_id": widget.packageId ?? "",
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
                          LocalizedStrings.getString('next', widget.isToggled),
                          style: AppFontStyle2.blinker(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colorfile.borderDark),
                              color: Colorfile.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: () {
                                print("View Sample button pressed");
                              },
                              child: Center(
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
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
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
                                  Image.asset(AppImages.whatsapp),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
