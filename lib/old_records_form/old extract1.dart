// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../My_package/package_order_details.dart';
import '../colors/custom_color.dart';
import '../colors/order_fonts.dart';
import '../form_internet.dart';
import '../language/hindi.dart';
import '../network/url.dart';
import '../quicke_services_forms/pay.dart';
import '../validations_chan_lang/seventwelveextract.dart';

class oldextract1 extends StatefulWidget {
  final String id;
  final String serviceName;
  final String tblName;
  final String packageId;
  final bool isToggled;
  final String serviceNameInLocalLanguage;
  final String lead_id;
  final String customer_id;
  final String package_lead_id;

  const oldextract1({
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

class _oldextract1State extends State<oldextract1> {
  final TextEditingController _FieldSurveyNoController =
      TextEditingController();
  final TextEditingController _ByNameIncasesurveynoisnotknownController =
      TextEditingController();
  final TextEditingController _ByKhataNoController = TextEditingController();
  final TextEditingController _MutationNoController = TextEditingController();

  String? Selectedcity;
  String? SelectedId;
  List<Map<String, dynamic>> talukaData = [];
  String? selectedTaluka;
  List<Map<String, dynamic>> CityData = [];
  List<Map<String, dynamic>> villageData = [];
  String? selectedVillageName;
  String? selectedVillageId;
  String? selectedTalukaId;
  TextEditingController cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  final NetworkChecker _networkChecker = NetworkChecker();

  @override
  void initState() {
    print(widget.tblName);
    super.initState();
    print(widget.tblName);
    _networkChecker.startMonitoring(context);
    _fetchCity();
  }

  Future<void> submitOldServiceForm(
    BuildContext context,
    Map<String, dynamic> formData,
  ) async {
    final String url = URLS().submit_old_record_enquiry_form_apiUrl;
    print('Request URL: $url');
    print('Request Body: ${jsonEncode(formData)}');

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("Form submitted successfully: $responseData");

        if (widget.packageId == "") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => payscreen(responseData: responseData),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PackageService(
                package_Id: widget.packageId,
                lead_id: widget.lead_id,
                customerid: widget.customer_id,
                tbl_name: '',
              ),
            ),
          );
        }
      } else {
        print(
          "Failed to submit form: ${response.statusCode} - ${response.body}",
        );

        String errorMessage;
        switch (response.statusCode) {
          case 400:
            errorMessage = "Bad request. Please check your form data.";
            break;
          case 401:
            errorMessage = "Unauthorized. Please check your credentials.";
            break;
          case 403:
            errorMessage = "Forbidden. You don’t have permission.";
            break;
          case 404:
            errorMessage = "API endpoint not found.";
            break;
          case 500:
            errorMessage = "Server error. Please try again later.";
            break;
          default:
            errorMessage = "Form submission failed: ${response.statusCode}";
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } on SocketException {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No internet connection. Please check your network.',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _fetchCity() async {
    final String url = URLS().get_all_city_apiUrl;
    log('City URL: $url');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('state_id', '22');
    log('state_id 22 saved to SharedPreferences');

    var requestBody = {"state_id": "22"};
    log('City Request Body: ${jsonEncode(requestBody)}');

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      log('City Response Status Code: ${response.statusCode}');
      log('City Raw Response Body: "${response.body}"');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'true') {
          setState(() {
            CityData = List<Map<String, dynamic>>.from(data['data'] ?? []);
            isLoading = false;
          });
          log('Fetched City Data: ${data['data']}');
        } else {
          log('Failed to load city: ${data['message'] ?? 'Unknown error'}');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        log('Failed to load city data. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      log('City Fetch Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _fetchTaluka(String cityId) async {
    final String url = URLS().get_all_taluka_apiUrl;
    log('Taluka URL: $url');

    var requestBody = {"city_id": cityId};
    log('Taluka Request Body: ${jsonEncode(requestBody)}');

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      log('Taluka Response Status Code: ${response.statusCode}');
      log('Taluka Raw Response Body: "${response.body}"');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'true') {
          setState(() {
            talukaData = List<Map<String, dynamic>>.from(data['data'] ?? []);
          });
          log('Fetched Taluka Data: ${data['data']}');
        } else {
          log('Failed to load taluka: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        log('Failed to load taluka data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Taluka Fetch Error: $e');
    }
  }

  void _fetchVillages(String cityId, String talukaId) async {
    final String url = URLS().get_all_village_apiUrl;
    log('Village URL: $url');

    var requestBody = {"city_id": cityId, "taluka_id": talukaId};
    log('Village Request Body: ${jsonEncode(requestBody)}');

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      log('Village Response Status Code: ${response.statusCode}');
      log('Village Raw Response Body: "${response.body}"');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'true') {
          setState(() {
            villageData = List<Map<String, dynamic>>.from(data['data'] ?? []);
          });
          log('Fetched Village Data: ${data['data']}');
        } else {
          log('Failed to load villages: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        log('Failed to load village data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Village Fetch Error: $e');
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      Selectedcity = null;
      _FieldSurveyNoController.clear();
      selectedVillageName = null;
      selectedTaluka = null;
      _ByNameIncasesurveynoisnotknownController.clear();
      _MutationNoController.clear();
      if (widget.tblName == 'tbl_eighta_extract') {
        _ByKhataNoController.clear();
      }
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
            child: SizedBox(
              height: widget.tblName == 'tbl_eighta_extract' ? 1100 : 1000,
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
                    const SizedBox(height: 16),
                    Text(
                      LocalizedStrings.getString(
                        'pleaseEnterYourDetails',
                        widget.isToggled,
                      ),
                      style: AppFontStyle2.blinker(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.57,
                        color: const Color(0xFF36322E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FormField<String>(
                      validator: (value) {
                        if (Selectedcity == null ||
                            Selectedcity!.trim().isEmpty) {
                          return ValidationMessagesseventweleve.getMessage(
                            'pleaseSelectDistrict',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = Selectedcity!.trim();
                        if (RegExp(
                          r'<.*?>|script|alert|on\w+=',
                          caseSensitive: false,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagesseventweleve.getMessage(
                            'invalidCharacters',
                            widget.isToggled,
                          );
                        }
                        return null;
                      },
                      builder: (FormFieldState<String> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownSearch<String>(
                              items: CityData.map<String>((item) {
                                return widget.isToggled
                                    ? (item['city_name_in_local_language'])
                                          .toString()
                                    : (item['city_name']).toString();
                              }).toList(),
                              selectedItem: Selectedcity,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: LocalizedStrings.getString(
                                    'district',
                                    widget.isToggled,
                                  ),
                                  hintStyle: AppFontStyle2.blinker(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.57,
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
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorText: state.errorText,
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  textCapitalization: TextCapitalization.words,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(
                                        r'^[a-zA-Z\u0900-\u095F\u0970-\u097F\s]+$',
                                      ),
                                    ),
                                    LengthLimitingTextInputFormatter(50),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: widget.isToggled
                                        ? 'जिल्हा शोधा...'
                                        : 'Search District...',
                                    hintStyle: AppFontStyle2.blinker(),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              dropdownButtonProps: const DropdownButtonProps(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 28,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                              onChanged: (value) {
                                log('${widget.isToggled}');
                                setState(() {
                                  Selectedcity = value;
                                  final matchedCity = CityData.firstWhere(
                                    (element) =>
                                        (widget.isToggled
                                            ? (element['city_name_in_local_language'])
                                            : element['city_name']) ==
                                        value,
                                    orElse: () => {},
                                  );
                                  SelectedId = matchedCity.isNotEmpty
                                      ? matchedCity['id'].toString()
                                      : null;
                                  if (SelectedId != null) {
                                    _fetchTaluka(SelectedId!);
                                  }
                                  state.didChange(value);
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    FormField<String>(
                      validator: (value) {
                        if (selectedTaluka == null ||
                            selectedTaluka!.trim().isEmpty) {
                          return ValidationMessagesseventweleve.getMessage(
                            'pleaseSelectTaluka',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = selectedTaluka!.trim();
                        if (RegExp(
                          r'<.*?>|script|alert|on\w+=',
                          caseSensitive: false,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagesseventweleve.getMessage(
                            'invalidCharacters',
                            widget.isToggled,
                          );
                        }
                        return null;
                      },
                      builder: (FormFieldState<String> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownSearch<String>(
                              items: talukaData.map<String>((item) {
                                return widget.isToggled
                                    ? (item['taluka_name_in_local_language'] ??
                                              item['taluka_name'] ??
                                              '')
                                          .toString()
                                    : (item['taluka_name'] ?? '').toString();
                              }).toList(),
                              selectedItem: selectedTaluka,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: LocalizedStrings.getString(
                                    'taluka',
                                    widget.isToggled,
                                  ),
                                  hintStyle: AppFontStyle2.blinker(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.57,
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
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorText: state.errorText,
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  textCapitalization: TextCapitalization.words,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[\p{L}\s]', unicode: true),
                                    ),
                                    LengthLimitingTextInputFormatter(50),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: widget.isToggled
                                        ? 'तालुका शोधा...'
                                        : 'Search Taluka...',
                                    hintStyle: AppFontStyle2.blinker(),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              dropdownButtonProps: const DropdownButtonProps(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 28,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedTaluka = value;
                                  final matchedTaluka = talukaData.firstWhere(
                                    (element) =>
                                        (widget.isToggled
                                            ? (element['taluka_name_in_local_language'] ??
                                                  element['taluka_name'])
                                            : element['taluka_name']) ==
                                        value,
                                    orElse: () => {},
                                  );
                                  selectedTalukaId = matchedTaluka.isNotEmpty
                                      ? matchedTaluka['id'].toString()
                                      : null;
                                  if (selectedTalukaId != null) {
                                    _fetchVillages(
                                      SelectedId!,
                                      selectedTalukaId!,
                                    );
                                  }
                                  state.didChange(value);
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    FormField<String>(
                      validator: (value) {
                        if (selectedVillageName == null ||
                            selectedVillageName!.trim().isEmpty) {
                          return ValidationMessagesseventweleve.getMessage(
                            'pleaseSelectVillage',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = selectedVillageName!.trim();
                        if (RegExp(
                          r'<.*?>|script|alert|on\w+=',
                          caseSensitive: false,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagesseventweleve.getMessage(
                            'invalidCharacters',
                            widget.isToggled,
                          );
                        }
                        return null;
                      },
                      builder: (FormFieldState<String> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownSearch<String>(
                              items: villageData.map<String>((item) {
                                return widget.isToggled
                                    ? (item['village_name_in_local_language'] ??
                                              item['village_name'] ??
                                              '')
                                          .toString()
                                    : (item['village_name'] ?? '').toString();
                              }).toList(),
                              selectedItem: selectedVillageName,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: LocalizedStrings.getString(
                                    'village',
                                    widget.isToggled,
                                  ),
                                  hintStyle: AppFontStyle2.blinker(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.57,
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
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorText: state.errorText,
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  textCapitalization: TextCapitalization.words,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[\p{L}\s]', unicode: true),
                                    ),
                                    LengthLimitingTextInputFormatter(50),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: widget.isToggled
                                        ? 'गाव शोधा...'
                                        : 'Search Village...',
                                    hintStyle: AppFontStyle2.blinker(),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              dropdownButtonProps: const DropdownButtonProps(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 28,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedVillageName = value;
                                  final matchedVillage = villageData.firstWhere(
                                    (element) =>
                                        (widget.isToggled
                                            ? (element['village_name_in_local_language'] ??
                                                  element['village_name'])
                                            : element['village_name']) ==
                                        value,
                                    orElse: () => {},
                                  );
                                  selectedVillageId = matchedVillage.isNotEmpty
                                      ? matchedVillage['id'].toString()
                                      : null;
                                  state.didChange(value);
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _FieldSurveyNoController,
                      decoration: InputDecoration(
                        hintText: LocalizedStrings.getString(
                          'fieldSurveyNo',
                          widget.isToggled,
                        ),
                        hintStyle: AppFontStyle2.blinker(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.57,
                          color: const Color(0xFF36322E),
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r'^[\u0900-\u097F\u0966-\u096F a-zA-Z0-9\s/]+$',
                          ),
                        ),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          String text = newValue.text;
                          text = text.replaceAll(RegExp(r'\s+'), ' ');
                          text = text.trim();
                          if (text.length > 1) {
                            final lastChar = text[text.length - 1];
                            final secondLastChar = text[text.length - 2];
                            if (lastChar == ' ' &&
                                ((RegExp(r'[0-9 /]').hasMatch(secondLastChar) &&
                                        RegExp(r'[a-zA-Z /]').hasMatch(
                                          text.substring(0, text.length - 2),
                                        )) ||
                                    (RegExp(
                                          r'[a-zA-Z]',
                                        ).hasMatch(secondLastChar) &&
                                        RegExp(r'[0-9 /]').hasMatch(
                                          text.substring(0, text.length - 2),
                                        )))) {
                              text = text.substring(0, text.length - 1);
                            }
                          }
                          return text == newValue.text
                              ? newValue
                              : TextEditingValue(
                                  text: text,
                                  selection: TextSelection.collapsed(
                                    offset: text.length,
                                  ),
                                );
                        }),
                        LengthLimitingTextInputFormatter(50),
                      ],
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return ValidationMessagesseventweleve.getMessage(
                            'pleaseEnterSurveyNo',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = value.trim();
                        if (RegExp(
                          r'<.*?>|script|alert|on\w+=',
                          caseSensitive: false,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagesseventweleve.getMessage(
                            'invalidCharacters',
                            widget.isToggled,
                          );
                        }
                        return null;
                      },
                    ),
                    if (widget.tblName == 'tbl_old_e_mutation_extract') ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _MutationNoController,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: LocalizedStrings.getString(
                                'mutationNo',
                                widget.isToggled,
                              ),
                              style: AppFontStyle2.blinker(
                                color: const Color(0xFF36322E),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      ' ${LocalizedStrings.getString('mutationNoHint', widget.isToggled)}',
                                  style: AppFontStyle2.blinker(
                                    color: const Color(0xFF36322E),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(
                              r'^[\u0900-\u097F\u0966-\u096F a-zA-Z0-9\s/]+$',
                            ),
                          ),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            String text = newValue.text;
                            text = text.replaceAll(RegExp(r'\s+'), ' ');
                            text = text.trimLeft();
                            return text == newValue.text
                                ? newValue
                                : TextEditingValue(
                                    text: text,
                                    selection: TextSelection.collapsed(
                                      offset: text.length,
                                    ),
                                  );
                          }),
                          LengthLimitingTextInputFormatter(50),
                        ],
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return ValidationMessagesseventweleve.getMessage(
                              'pleaseEnterMutationNo',
                              widget.isToggled,
                            );
                          }
                          final trimmedValue = value.trim();
                          if (RegExp(
                            r'<.*?>|script|alert|on\w+=',
                            caseSensitive: false,
                          ).hasMatch(trimmedValue)) {
                            return ValidationMessagesseventweleve.getMessage(
                              'invalidCharacters',
                              widget.isToggled,
                            );
                          }
                          return null;
                        },
                      ),
                    ],
                    if (widget.tblName == 'tbl_old_eighta_extract') ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _ByKhataNoController,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: LocalizedStrings.getString(
                                'byKhataNo',
                                widget.isToggled,
                              ),
                              style: AppFontStyle2.blinker(
                                color: const Color(0xFF36322E),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      ' ${LocalizedStrings.getString('byKhataNoHint', widget.isToggled)}',
                                  style: AppFontStyle2.blinker(
                                    color: const Color(0xFF36322E),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(
                              r'^[\u0900-\u097F\u0966-\u096F a-zA-Z0-9\s/]+$',
                            ),
                          ),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            String text = newValue.text;
                            text = text.replaceAll(RegExp(r'\s+'), ' ');
                            text = text.trimLeft();
                            return text == newValue.text
                                ? newValue
                                : TextEditingValue(
                                    text: text,
                                    selection: TextSelection.collapsed(
                                      offset: text.length,
                                    ),
                                  );
                          }),
                          LengthLimitingTextInputFormatter(50),
                        ],
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return ValidationMessagesseventweleve.getMessage(
                              'pleaseEnterByKhataNo',
                              widget.isToggled,
                            );
                          }
                          final trimmedValue = value.trim();
                          if (RegExp(
                            r'<.*?>|script|alert|on\w+=',
                            caseSensitive: false,
                          ).hasMatch(trimmedValue)) {
                            return ValidationMessagesseventweleve.getMessage(
                              'invalidCharacters',
                              widget.isToggled,
                            );
                          }
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _ByNameIncasesurveynoisnotknownController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: LocalizedStrings.getString(
                              'byName',
                              widget.isToggled,
                            ),
                            style: AppFontStyle2.blinker(
                              color: const Color(0xFF36322E),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    ' ${LocalizedStrings.getString('byNameHint', widget.isToggled)}',
                                style: AppFontStyle2.blinker(
                                  color: const Color(0xFF36322E),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^[\u0900-\u097F\u0966-\u096F a-zA-Z\s/]+$'),
                        ),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          String text = newValue.text;
                          text = text.replaceAll(RegExp(r'\s+'), ' ');
                          text = text.trimLeft();
                          return text == newValue.text
                              ? newValue
                              : TextEditingValue(
                                  text: text,
                                  selection: TextSelection.collapsed(
                                    offset: text.length,
                                  ),
                                );
                        }),
                        LengthLimitingTextInputFormatter(50),
                      ],
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return ValidationMessagesseventweleve.getMessage(
                            'pleaseEnterByName',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = value.trim();
                        if (RegExp(
                          r'<.*?>|script|alert|on\w+=',
                          caseSensitive: false,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagesseventweleve.getMessage(
                            'invalidCharacters',
                            widget.isToggled,
                          );
                        }
                        return null;
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
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
                              final String? stateId = prefs.getString(
                                'state_id',
                              );
                              final String? customerId = prefs.getString(
                                'customer_id',
                              );
                              Map<String, dynamic> formData = {
                                "tbl_name": widget.tblName,
                                "lead_id": widget.package_lead_id,
                                "customer_id": customerId,
                                "package_id": widget.packageId ?? "",
                                "state_id": stateId,
                                "city_id": SelectedId,
                                "taluka_id": selectedTalukaId,
                                "village_id": selectedVillageId,
                                "survey_no": _FieldSurveyNoController.text,
                                "name":
                                    _ByNameIncasesurveynoisnotknownController
                                        .text,
                                "mutation_no": _MutationNoController.text,
                              };
                              if (widget.tblName == 'tbl_old_eighta_extract') {
                                formData["khata_no"] =
                                    _ByKhataNoController.text;
                              }
                              submitOldServiceForm(context, formData);
                            }
                          },
                          child: Center(
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
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
