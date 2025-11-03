import 'dart:convert';
import 'dart:developer';

import 'package:bhulexapp/My_package/package_order_details.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/language/hindi.dart';
import 'package:bhulexapp/network/url.dart';
import 'package:bhulexapp/quicke_services_forms/pay.dart';
import 'package:bhulexapp/validations_chan_lang/courtcasevali.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


import 'package:shared_preferences/shared_preferences.dart';

import '../form_internet.dart';

class Courtcases extends StatefulWidget {
  final String id;
  final String serviceName;
  final String tblName;
  final bool isToggled; // Added for language toggle
  final String serviceNameInLocalLanguage; // Added for local service name
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
  final TextEditingController _CTSNoController = TextEditingController();
  final TextEditingController _ByNameIncasesurveynoisnotknownController =
      TextEditingController();
  final TextEditingController _partynamesController = TextEditingController();
  final TextEditingController _casenoController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  List<Map<String, dynamic>> CityData = [];
  String? Selectedcity;
  String? SelectedId;
  String? selectedCourtId;
  String? _selectedCourt;
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> _rawCourtData = [];
  List<String> _courtList = [];
  bool isLoading = true;
  final NetworkChecker _networkChecker = NetworkChecker(); // Add NetworkChecker

  @override
  void initState() {
    super.initState();
    _networkChecker.startMonitoring(context); // Start network monitoring

    _fetchCourtList(cityId: ""); // Or pass dynamically
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
        // Check if packageId is empty
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
              builder:
                  (context) => PackageService(
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

    // Fetch state_id from SharedPreferences and set it to "22" for testing
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

  void _fetchCourtList({required String cityId}) async {
    final String url = URLS().get_all_court_apiUrl;
    print('Request URL: $url');

    try {
      var requestBody = {"city_id": cityId};
      print('Request Body: ${jsonEncode(requestBody)}');

      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response Status Code: ${response.statusCode}');
      log('Response Body court: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'].toString().toLowerCase() == 'true') {
          setState(() {
            _rawCourtData = List<Map<String, dynamic>>.from(data['data']);
            _courtList =
                _rawCourtData.map((e) => e['court_name'].toString()).toList();
          });
          for (var item in data['data']) {
            log('Court ID: ${item['id']}, Court Name: ${item['court_name']}');
          }
        } else {
          print('Failed to load court list: ${data['message']}');
        }
      } else {
        print('Failed to load court list. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      Selectedcity = null;
      _selectedCourt = null;
      _CTSNoController.clear();
      _casenoController.clear();
      yearController.clear();
      _partynamesController.clear();
      _ByNameIncasesurveynoisnotknownController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    String displayServiceName =
        widget.isToggled
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
                      height: 95,
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
                  const SizedBox(height: 16),
                  FormField<String>(
                    validator: (value) {
                      if (Selectedcity == null ||
                          Selectedcity!.trim().isEmpty) {
                        return ValidationMessagescourtcase.getMessage(
                          'pleaseSelectDistrict',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = Selectedcity!.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return ValidationMessagescourtcase.getMessage(
                          'invalidCharacters',
                          widget.isToggled,
                        );
                      }
                      // if (!RegExp(
                      //   r'^[\p{L}\s]+$',
                      //   unicode: true,
                      // ).hasMatch(trimmedValue)) {
                      //   return ValidationMessagescourtcase.getMessage(
                      //     'onlyAlphabetsAllowed',
                      //     widget.isToggled,
                      //   );
                      // }
                      return null;
                    },
                    builder: (FormFieldState<String> state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownSearch<String>(
                            items:
                                CityData.map<String>((item) {
                                  return widget.isToggled
                                      ? (item['city_name_in_local_language'])
                                          .toString()
                                      : (item['city_name']).toString();
                                }).toList(),

                            selectedItem: Selectedcity,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: CourtcasesStrings.getString(
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
                                      (r'^[a-zA-Z\u0900-\u095F\u0970-\u097F\s]+$'),
                                    ),
                                  ),

                                  LengthLimitingTextInputFormatter(50),
                                ],
                                decoration: InputDecoration(
                                  hintText:
                                      widget.isToggled
                                          ? 'जिल्हा शोधा...'
                                          : 'Search District...',
                                  hintStyle: AppFontStyle2.blinker(),

                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            // onChanged: (value) {
                            //   setState(() {
                            //     Selectedcity = value;
                            //     SelectedId =
                            //         CityData.firstWhere(
                            //           (element) =>
                            //               element['city_name'] == value,
                            //         )['id'].toString();
                            //     _fetchCourtList(
                            //       cityId: SelectedId!,
                            //     ); // Fetch courts based on selected city
                            //     state.didChange(value);
                            //   });
                            // },
                            dropdownButtonProps: DropdownButtonProps(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                Selectedcity = value;

                                final matchedCity = CityData.firstWhere(
                                  (element) =>
                                      (widget.isToggled
                                          ? (element['city_name_in_local_language'] ??
                                              element['city_name'])
                                          : element['city_name']) ==
                                      value,
                                  orElse: () => {},
                                );

                                SelectedId =
                                    matchedCity.isNotEmpty
                                        ? matchedCity['id'].toString()
                                        : null;

                                if (SelectedId != null) {
                                  _fetchCourtList(cityId: SelectedId!);
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
                      if (_selectedCourt == null ||
                          _selectedCourt!.trim().isEmpty) {
                        return ValidationMessagescourtcase.getMessage(
                          'pleaseSelectCourt',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = _selectedCourt!.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=0-9',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return ValidationMessagescourtcase.getMessage(
                          'invalidCharacters',
                          widget.isToggled,
                        );
                      }
                      // if (!RegExp(
                      //   r'^[\p{L}\s]+$',
                      //   unicode: true,
                      // ).hasMatch(trimmedValue)) {
                      //   return ValidationMessagescourtcase.getMessage(
                      //     'onlyAlphabetsAllowed',
                      //     widget.isToggled,
                      //   );
                      // }
                      return null;
                    },
                    builder: (FormFieldState<String> state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownSearch<String>(
                            items:
                                _rawCourtData.map<String>((item) {
                                  return widget.isToggled
                                      ? (item['court_name_in_local_language'] ??
                                              item['court_name'] ??
                                              '')
                                          .toString()
                                      : (item['court_name'] ?? '').toString();
                                }).toList(),
                            selectedItem: _selectedCourt,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: CourtcasesStrings.getString(
                                  'selectCourt',
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
                                      (r'^[a-zA-Z\u0900-\u095F\u0970-\u097F\s]+$'),
                                    ),
                                  ),

                                  LengthLimitingTextInputFormatter(50),
                                ],
                                decoration: InputDecoration(
                                  hintText:
                                      widget.isToggled
                                          ? 'न्यायालय शोधा...'
                                          : 'Search Court...',
                                  hintStyle: AppFontStyle2.blinker(),

                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            dropdownButtonProps: DropdownButtonProps(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCourt = newValue;

                                final matchedCourt = _rawCourtData.firstWhere(
                                  (element) =>
                                      (widget.isToggled
                                          ? (element['court_name_in_local_language'] ??
                                              element['court_name'])
                                          : element['court_name']) ==
                                      newValue,
                                  orElse: () => {},
                                );

                                selectedCourtId =
                                    matchedCourt.isNotEmpty
                                        ? matchedCourt['id'].toString()
                                        : null;

                                state.didChange(newValue);
                              });

                              print("Selected Court Name: $_selectedCourt");
                              print("Selected Court ID: $selectedCourtId");
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _partynamesController,
                    decoration: InputDecoration(
                      hintText: CourtcasesStrings.getString(
                        'partyNames',
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
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[\p{L}\s]', unicode: true),
                      ),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        String text = newValue.text;
                        // Replace multiple spaces with single space
                        text = text.replaceAll(RegExp(r'\s+'), ' ');
                        // Remove leading space
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
                        return ValidationMessagescourtcase.getMessage(
                          'pleaseEnterPartyNames',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = value.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return ValidationMessagescourtcase.getMessage(
                          'invalidCharacters',
                          widget.isToggled,
                        );
                      }
                      if (!RegExp(
                        r'^[\p{L}\s]+$',
                        unicode: true,
                      ).hasMatch(trimmedValue)) {
                        return ValidationMessagescourtcase.getMessage(
                          'onlyAlphabetsAllowed',
                          widget.isToggled,
                        );
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // TextFormField(
                  //   controller: _casenoController,
                  //   decoration: InputDecoration(
                  //     hintText: CourtcasesStrings.getString(
                  //       'caseNo',
                  //       widget.isToggled,
                  //     ),
                  //     hintStyle: const TextStyle(color: Color(0xFF36322E)),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(6),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(6),
                  //       borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(6),
                  //       borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
                  //     ),
                  //   ),
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.allow(RegExp("[0-9 /A-Z]")),
                  //   ],
                  //   textCapitalization: TextCapitalization.words,
                  //   validator: (value) {
                  //     if (value == null || value.trim().isEmpty) {
                  //       return ValidationMessagescourtcase.getMessage(
                  //         'pleaseEnterCaseNo',
                  //         widget.isToggled,
                  //       );
                  //     }

                  //     final trimmedValue = value.trim();
                  //     if (RegExp(
                  //       r'<.*?>|script|alert|on\w+=',
                  //       caseSensitive: false,
                  //     ).hasMatch(trimmedValue)) {
                  //       return ValidationMessagescourtcase.getMessage(
                  //         'invalidCharacters',
                  //         widget.isToggled,
                  //       );
                  //     }
                  //     return null;
                  //   },
                  // ),
                  TextFormField(
                    controller: _casenoController,
                    decoration: InputDecoration(
                      hintText: CourtcasesStrings.getString(
                        'caseNo',
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
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                          (r'^[\u0900-\u097F\u0966-\u096F a-zA-Z0-9\s/]+$'),
                        ), // Simplified to allow numbers, letters, and spaces
                      ),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        String text = newValue.text;
                        // Replace multiple spaces with single space
                        text = text.replaceAll(RegExp(r'\s+'), ' ');
                        // Remove leading space
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
                    // textCapitalization:
                    //     TextCapitalization.characters, // Ensure uppercase
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return ValidationMessagescourtcase.getMessage(
                          'pleaseEnterCaseNo',
                          widget.isToggled,
                        );
                      }

                      final trimmedValue = value.trim();

                      // Case number validation (matches PAN format)
                      // final _casePattern = r'^[A-Z /]{5}[0-9]{4}[A-Z /]{1}$';
                      // if (!RegExp(_casePattern).hasMatch(trimmedValue)) {
                      //   return 'Enter valid case number (e.g., ABCDE1234F)';
                      // }

                      // Prevent HTML/script injections
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return ValidationMessagescourtcase.getMessage(
                          'invalidCharacters',
                          widget.isToggled,
                        );
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  TextFormField(
                    controller: yearController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                        setState(() {
                          yearController.text = formattedDate;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: CourtcasesStrings.getString(
                        'dateFormatHint',
                        widget.isToggled,
                      ),
                      hintStyle: AppFontStyle2.blinker(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.57,
                        color: const Color(0xFF36322E),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return ValidationMessagescourtcase.getMessage(
                          'dateRequired',
                          widget.isToggled,
                        );
                      }
                      if (!RegExp(
                        r'^\d{2}-\d{2}-\d{4}$',
                      ).hasMatch(value.trim())) {
                        return ValidationMessagescourtcase.getMessage(
                          'invalidDateFormat',
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
                        color: const Color(0xFFF57C03),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final String? stateId = prefs.getString('state_id');
                            final String? customerId = prefs.getString(
                              'customer_id',
                            );

                            Map<String, dynamic> formData = {
                              "tbl_name": widget.tblName,
                              "customer_id": customerId,
                              "package_id":
                                  widget.packageId ??
                                  "", // Send empty string if null
                              "state_id": stateId,
                              "lead_id": widget.package_lead_id,
                              "service_name":
                                  widget.isToggled
                                      ? widget.serviceNameInLocalLanguage
                                      : widget.serviceName,
                              "city_id": SelectedId,
                              "court_id": selectedCourtId,
                              "party_name": _partynamesController.text.trim(),
                              "case_no": _casenoController.text.trim(),
                              "year": yearController.text.trim(),
                            };
                            submitLegalAdvisoryEnquiryForm(context, formData);
                          } else {
                            debugPrint("Validation failed. Fix errors.");
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
