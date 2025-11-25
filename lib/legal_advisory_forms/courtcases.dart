import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../Core/AppImages.dart';
import '../My_package/package_order_details.dart';
import '../colors/custom_color.dart';
import '../colors/order_fonts.dart';
import '../form_internet.dart';
import '../language/hindi.dart';
import '../network/url.dart';
import '../quicke_services_forms/pay.dart';
import '../validations_chan_lang/courtcasevali.dart';

class Courtcases extends StatefulWidget {
  final String id;
  final String serviceName;
  final String tblName;
  final bool isToggled;
  final String serviceNameInLocalLanguage;
  final String packageId;
  final String lead_id;
  final String customer_id;
  final String package_lead_id;

  const Courtcases({
    super.key,
    required this.packageId,
    required this.id,
    required this.serviceName,
    required this.tblName,
    required this.isToggled,
    required this.serviceNameInLocalLanguage,
    required this.lead_id,
    required this.customer_id,
    required this.package_lead_id,
  });

  @override
  _CourtcasesState createState() => _CourtcasesState();
}

class _CourtcasesState extends State<Courtcases> {
  List<Map<String, dynamic>> CityData = [];
  String? Selectedcity;
  String? SelectedId;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  final NetworkChecker _networkChecker = NetworkChecker();

  List<Map<String, dynamic>> courtServices = [
    {
      "id": "1",
      "name": "Supreme Court of India",
      "isSelected": false,
      "caseType": null,
      "caseNumber": "",
      "caseYear": "",
      "partyName": "",
      "partyYear": "",
    },
    {
      "id": "2",
      "name": "High Court Bombay",
      "isSelected": false,
      "caseType": null,
      "bench": null,
      "caseNumber": "",
      "caseYear": "",
      "partyName": "",
      "partyYear": "",
    },
    {
      "id": "3",
      "name": "District Courts",
      "isSelected": false,
      "caseType": null,
      "caseNumber": "",
      "caseYear": "",
      "partyName": "",
      "partyYear": "",
    },
    {
      "id": "4",
      "name": "Revenue Courts",
      "isSelected": false,
      "caseType": null,
      "department": null,
      "district": null,
      "caseNumber": "",
      "caseYear": "",
      "partyName": "",
      "partyYear": "",
    },
  ];

  final List<String> caseTypes = [
    'Civil',
    'Criminal',
    'Constitutional',
    'Family',
    'Labour',
    'Tax',
  ];

  final List<String> bombayBenches = ['Bombay', 'Nagpur', 'Aurangabad', 'Goa'];

  final List<String> revenueDepartments = [
    'Revenue Department',
    'Land Records',
    'Registration',
    'Stamps',
  ];

  final List<String> revenueDistricts = [
    'Mumbai',
    'Pune',
    'Nagpur',
    'Aurangabad',
    'Nashik',
  ];

  @override
  void initState() {
    super.initState();
    _networkChecker.startMonitoring(context);
    _fetchCity();
  }

  Future<void> submitLegalAdvisoryEnquiryForm(
    BuildContext context,
    Map<String, dynamic> formData,
  ) async {
    final String url = URLS().submit_legal_advisory_enquiry_form_apiUrl;
    print('Request URL: $url');
    print('Request Body: ${jsonEncode(formData)}');

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("Form submitted successfully: $responseData");
        if (widget.packageId == "") {
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
        print("Failed to submit form: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Form submission failed. Please try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Exception occurred during submission: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No internet connection. Please check your network."),
          backgroundColor: Colors.red,
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

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      Selectedcity = null;
      courtServices = courtServices.map((service) {
        return {
          ...service,
          'isSelected': false,
          'caseType': null,
          'bench': null,
          'department': null,
          'district': null,
          'caseNumber': '',
          'caseYear': '',
          'partyName': '',
          'partyYear': '',
        };
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
            physics: const AlwaysScrollableScrollPhysics(),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0x40F57C03),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 0.5,
                        color: const Color(0xFFC5C5C5),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(14, 14, 18, 14),
                    child: Text(
                      CourtcasesStrings.getString(
                        'description',
                        widget.isToggled,
                      ),
                      textAlign: TextAlign.justify,
                      style: AppFontStyle2.blinker(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF36322E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    CourtcasesStrings.getString(
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
                  const SizedBox(height: 8),
                  Column(
                    children: courtServices.map((service) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFC5C5C5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: service['isSelected']
                                        ? Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1.0,
                                            ),
                                          )
                                        : null,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        service['isSelected'] =
                                            !service['isSelected'];
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              service['name'],
                                              style: AppFontStyle2.blinker(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF36322E),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Transform.scale(
                                          scale:
                                              0.7, // Adjust scale to make the switch smaller (0.7 is ~30% smaller)
                                          child: Switch(
                                            value: service['isSelected'],
                                            onChanged: (value) {
                                              setState(() {
                                                service['isSelected'] = value;
                                              });
                                            },
                                            activeColor: Colors.white,
                                            activeTrackColor: Colors.black,
                                            inactiveThumbColor: Colors.white,
                                            inactiveTrackColor: Colors.black26,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap, // Minimize tap area
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              if (service['isSelected']) ...[
                                if (service['name'] == 'High Court Bombay') ...[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8,
                                    ),
                                    child: FormField<String>(
                                      validator: (value) {
                                        if (service['bench'] == null) {
                                          return 'Please select a bench';
                                        }
                                        return null;
                                      },
                                      builder: (FormFieldState<String> state) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DropdownSearch<String>(
                                              items: bombayBenches,
                                              selectedItem: service['bench'],
                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                dropdownSearchDecoration: InputDecoration(
                                                  hintText:
                                                      CourtcasesStrings.getString(
                                                        'selectBench',
                                                        widget.isToggled,
                                                      ),
                                                  hintStyle:
                                                      AppFontStyle2.blinker(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.57,
                                                        color: const Color(
                                                          0xFF36322E,
                                                        ),
                                                      ),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 14,
                                                      ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    borderSide:
                                                        const BorderSide(
                                                          color: Color(
                                                            0xFFC5C5C5,
                                                          ),
                                                        ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color: Color(
                                                                0xFFC5C5C5,
                                                              ),
                                                            ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color: Color(
                                                                0xFFC5C5C5,
                                                              ),
                                                            ),
                                                      ),
                                                  errorText: state.errorText,
                                                  errorStyle: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              popupProps: PopupProps.menu(
                                                showSearchBox: true,
                                                searchFieldProps: TextFieldProps(
                                                  textCapitalization:
                                                      TextCapitalization.words,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(
                                                      RegExp(r'^[a-zA-Z\s]+$'),
                                                    ),
                                                    LengthLimitingTextInputFormatter(
                                                      50,
                                                    ),
                                                  ],
                                                  decoration: InputDecoration(
                                                    hintText: widget.isToggled
                                                        ? 'बेंच शोधा...'
                                                        : 'Search Bench...',
                                                    hintStyle:
                                                        AppFontStyle2.blinker(),
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFFC5C5C5,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              dropdownButtonProps:
                                                  const DropdownButtonProps(
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 28,
                                                      color: Color(0xFF9CA3AF),
                                                    ),
                                                  ),
                                              onChanged: (value) {
                                                setState(() {
                                                  service['bench'] = value;
                                                  state.didChange(value);
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                if (service['name'] == 'Revenue Courts') ...[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8,
                                    ),
                                    child: FormField<String>(
                                      validator: (value) {
                                        if (service['department'] == null) {
                                          return 'Please select a department';
                                        }
                                        return null;
                                      },
                                      builder: (FormFieldState<String> state) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DropdownSearch<String>(
                                              items: revenueDepartments,
                                              selectedItem:
                                                  service['department'],
                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                dropdownSearchDecoration: InputDecoration(
                                                  hintText:
                                                      CourtcasesStrings.getString(
                                                        'department',
                                                        widget.isToggled,
                                                      ),
                                                  hintStyle:
                                                      AppFontStyle2.blinker(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.57,
                                                        color: const Color(
                                                          0xFF36322E,
                                                        ),
                                                      ),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 14,
                                                      ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    borderSide:
                                                        const BorderSide(
                                                          color: Color(
                                                            0xFFC5C5C5,
                                                          ),
                                                        ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color: Color(
                                                                0xFFC5C5C5,
                                                              ),
                                                            ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color: Color(
                                                                0xFFC5C5C5,
                                                              ),
                                                            ),
                                                      ),
                                                  errorText: state.errorText,
                                                  errorStyle: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              popupProps: PopupProps.menu(
                                                showSearchBox: true,
                                                searchFieldProps: TextFieldProps(
                                                  textCapitalization:
                                                      TextCapitalization.words,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(
                                                      RegExp(r'^[a-zA-Z\s]+$'),
                                                    ),
                                                    LengthLimitingTextInputFormatter(
                                                      50,
                                                    ),
                                                  ],
                                                  decoration: InputDecoration(
                                                    hintText: widget.isToggled
                                                        ? 'विभाग शोधा...'
                                                        : 'Search Department...',
                                                    hintStyle:
                                                        AppFontStyle2.blinker(),
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFFC5C5C5,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              dropdownButtonProps:
                                                  const DropdownButtonProps(
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 28,
                                                      color: Color(0xFF9CA3AF),
                                                    ),
                                                  ),
                                              onChanged: (value) {
                                                setState(() {
                                                  service['department'] = value;
                                                  state.didChange(value);
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8,
                                    ),
                                    child: FormField<String>(
                                      validator: (value) {
                                        if (service['district'] == null) {
                                          return 'Please select a district';
                                        }
                                        return null;
                                      },
                                      builder: (FormFieldState<String> state) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DropdownSearch<String>(
                                              items: revenueDistricts,
                                              selectedItem: service['district'],
                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                dropdownSearchDecoration: InputDecoration(
                                                  hintText:
                                                      CourtcasesStrings.getString(
                                                        'district',
                                                        widget.isToggled,
                                                      ),
                                                  hintStyle:
                                                      AppFontStyle2.blinker(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.57,
                                                        color: const Color(
                                                          0xFF36322E,
                                                        ),
                                                      ),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 14,
                                                      ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    borderSide:
                                                        const BorderSide(
                                                          color: Color(
                                                            0xFFC5C5C5,
                                                          ),
                                                        ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color: Color(
                                                                0xFFC5C5C5,
                                                              ),
                                                            ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color: Color(
                                                                0xFFC5C5C5,
                                                              ),
                                                            ),
                                                      ),
                                                  errorText: state.errorText,
                                                  errorStyle: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              popupProps: PopupProps.menu(
                                                showSearchBox: true,
                                                searchFieldProps: TextFieldProps(
                                                  textCapitalization:
                                                      TextCapitalization.words,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(
                                                      RegExp(r'^[a-zA-Z\s]+$'),
                                                    ),
                                                    LengthLimitingTextInputFormatter(
                                                      50,
                                                    ),
                                                  ],
                                                  decoration: InputDecoration(
                                                    hintText: widget.isToggled
                                                        ? 'जिल्हा शोधा...'
                                                        : 'Search District...',
                                                    hintStyle:
                                                        AppFontStyle2.blinker(),
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFFC5C5C5,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              dropdownButtonProps:
                                                  const DropdownButtonProps(
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 28,
                                                      color: Color(0xFF9CA3AF),
                                                    ),
                                                  ),
                                              onChanged: (value) {
                                                setState(() {
                                                  service['district'] = value;
                                                  state.didChange(value);
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8,
                                  ),
                                  child: FormField<String>(
                                    validator: (value) {
                                      if (service['caseType'] == null) {
                                        return 'Please select a case type';
                                      }
                                      return null;
                                    },
                                    builder: (FormFieldState<String> state) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DropdownSearch<String>(
                                            items: caseTypes,
                                            selectedItem: service['caseType'],
                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                              dropdownSearchDecoration: InputDecoration(
                                                hintText:
                                                    CourtcasesStrings.getString(
                                                      'caseType',
                                                      widget.isToggled,
                                                    ),
                                                hintStyle:
                                                    AppFontStyle2.blinker(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.57,
                                                      color: const Color(
                                                        0xFF36322E,
                                                      ),
                                                    ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 14,
                                                    ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFC5C5C5),
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFFC5C5C5,
                                                            ),
                                                          ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFFC5C5C5,
                                                            ),
                                                          ),
                                                    ),
                                                errorText: state.errorText,
                                                errorStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            popupProps: PopupProps.menu(
                                              showSearchBox: true,
                                              searchFieldProps: TextFieldProps(
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                    RegExp(r'^[a-zA-Z\s]+$'),
                                                  ),
                                                  LengthLimitingTextInputFormatter(
                                                    50,
                                                  ),
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: widget.isToggled
                                                      ? 'केस प्रकार शोधा...'
                                                      : 'Search Case Type...',
                                                  hintStyle:
                                                      AppFontStyle2.blinker(),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                          color: Color(
                                                            0xFFC5C5C5,
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            dropdownButtonProps:
                                                const DropdownButtonProps(
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 28,
                                                    color: Color(0xFF9CA3AF),
                                                  ),
                                                ),
                                            onChanged: (value) {
                                              setState(() {
                                                service['caseType'] = value;
                                                state.didChange(value);
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText:
                                                CourtcasesStrings.getString(
                                                  'caseNumber',
                                                  widget.isToggled,
                                                ),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFC5C5C5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFC5C5C5),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFC5C5C5),
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            service['caseNumber'] = value;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText:
                                                CourtcasesStrings.getString(
                                                  'caseYear',
                                                  widget.isToggled,
                                                ),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFC5C5C5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFC5C5C5),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFC5C5C5),
                                              ),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            service['caseYear'] = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8,
                                      ),
                                      child: Text(
                                        CourtcasesStrings.getString(
                                          'ifNotKnown',
                                          widget.isToggled,
                                        ),
                                        style: AppFontStyle2.blinker(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF36322E),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8,
                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText:
                                              CourtcasesStrings.getString(
                                                'partyName',
                                                widget.isToggled,
                                              ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFC5C5C5),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFC5C5C5),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFC5C5C5),
                                            ),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          service['partyName'] = value;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8,
                                        bottom: 8,
                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText:
                                              CourtcasesStrings.getString(
                                                'partyYear',
                                                widget.isToggled,
                                              ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFC5C5C5),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFC5C5C5),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFC5C5C5),
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          service['partyYear'] = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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
                          if (_formKey.currentState!.validate() &&
                              courtServices.any(
                                (service) => service['isSelected'],
                              )) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final String? stateId = prefs.getString('state_id');
                            final String? customerId = prefs.getString(
                              'customer_id',
                            );

                            Map<String, dynamic> formData = {
                              "tbl_name": widget.tblName,
                              "customer_id": customerId,
                              "package_id": widget.packageId ?? "",
                              "state_id": stateId,
                              "lead_id": widget.package_lead_id,
                              "service_name": widget.isToggled
                                  ? widget.serviceNameInLocalLanguage
                                  : widget.serviceName,
                              "city_id": SelectedId,
                              "selected_courts": courtServices
                                  .where((service) => service['isSelected'])
                                  .map(
                                    (service) => {
                                      "court_id": service['id'],
                                      "case_type": service['caseType'],
                                      "bench": service['bench'],
                                      "department": service['department'],
                                      "district": service['district'],
                                      "case_number": service['caseNumber'],
                                      "case_year": service['caseYear'],
                                      "party_name": service['partyName'],
                                      "party_year": service['partyYear'],
                                    },
                                  )
                                  .toList(),
                            };
                            submitLegalAdvisoryEnquiryForm(context, formData);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  courtServices.any(
                                        (service) => service['isSelected'],
                                      )
                                      ? "Please fix form errors."
                                      : "Please select at least one court.",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Center(
                          child: Text(
                            CourtcasesStrings.getString(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
