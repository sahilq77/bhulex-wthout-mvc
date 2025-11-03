import 'dart:convert';
import 'dart:developer';

import 'package:bhulexapp/My_package/package_order_details.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/language/hindi.dart';
import 'package:bhulexapp/network/url.dart';
import 'package:bhulexapp/quicke_services_forms/pay.dart';
import 'package:bhulexapp/validations_chan_lang/adhikarabhilekhvali.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http show post;
import 'package:shared_preferences/shared_preferences.dart';

import '../form_internet.dart' show NetworkChecker;

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

    _fetchCity();
  }

  Future<void> submitLegalAdvisoryEnquiryForm(
    BuildContext context,
    Map<String, dynamic> formData,
  ) async {
    final String url = URLS().submit_legal_advisory_enquiry_form_apiUrl;
    print('🔗 Request URL: $url');
    print('📤 Request Body: ${jsonEncode(formData)}');

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
                    customerid: widget.customerid,
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

  Future<Map<String, String>> fetchOrderDetails(
    String customerId,
    String leadId,
    String tblName,
  ) async {
    final String url = 'https://seekhelp.in/bhulex/order_details';
    final requestBody = {
      "customer_id": customerId,
      "lead_id": leadId,
      "tbl_name": tblName,
    };

    print('Fetching order details - URL: $url');
    print('Request Body: ${jsonEncode(requestBody)}');

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Order details response: $responseData');

        if (responseData is List &&
            responseData.isNotEmpty &&
            responseData[0]['status'] == 'true') {
          final data = responseData[0]['data'][0];
          return {
            'orderId': data['order_id']?.toString() ?? leadId,
            'service_name': data['service_name'] ?? '',
            'service_name_in_local_language':
                data['service_name_in_local_language'] ?? '',
            'customerId': customerId,
            'customer_name': data['customer_name'] ?? '',
            'mobile_number': data['mobile_number'] ?? '',
            'email': data['email'] ?? '',
            'file_name': data['file_name'] ?? '',
            'file': data['file'] ?? '',
            'application_date': data['application_date'] ?? '',
            'status':
                data['lead_status'] == '2' ? 'Order Confirmed' : 'Pending',
            'tbl_name': tblName,
          };
        }
      }
      print('Failed to fetch order details or empty response');
      return {};
    } catch (e) {
      print('Error fetching order details: $e');
      return {};
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
      _surveyNoController.clear();
      selectedVillageName = null;
      selectedTaluka = null;
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
                  Text(
                    AdhikarAbhilekhStrings.getString(
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
                        return ValidationMessagesadhikar.getMessage(
                          'pleaseSelectDistrict',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = Selectedcity!.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return ValidationMessagesadhikar.getMessage(
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
                                errorText: state.errorText,
                                //errorStyle: AppTextStyles.error(),
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
                                  hintText:
                                      widget.isToggled
                                          ? 'जिल्हा शोधा...'
                                          : 'Search District...',
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

                                SelectedId =
                                    matchedCity.isNotEmpty
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
                        return ValidationMessagesadhikar.getMessage(
                          'pleaseSelectTaluka',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = selectedTaluka!.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return ValidationMessagesadhikar.getMessage(
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
                            items:
                                talukaData.map<String>((item) {
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
                                errorText: state.errorText,
                                // errorStyle: AppTextStyles.error(),
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
                                  hintText:
                                      widget.isToggled
                                          ? 'तालुका शोधा...'
                                          : 'Search Taluka...',
                                  hintStyle: AppFontStyle2.blinker(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.57,
                                    color: const Color(0xFF36322E),
                                  ),
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

                                selectedTalukaId =
                                    matchedTaluka.isNotEmpty
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
                        return ValidationMessagesadhikar.getMessage(
                          'pleaseSelectVillage',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = selectedVillageName!.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return ValidationMessagesadhikar.getMessage(
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
                            items:
                                villageData.map<String>((item) {
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
                                errorText: state.errorText,
                                // errorStyle: AppTextStyles.error(),
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
                                  hintText:
                                      widget.isToggled
                                          ? 'गाव शोधा...'
                                          : 'Search Village...',
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

                                selectedVillageId =
                                    matchedVillage.isNotEmpty
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
                    controller: _surveyNoController,
                    decoration: InputDecoration(
                      hintText: AdhikarAbhilekhStrings.getString(
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
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
                      ),
                      // errorStyle: AppTextStyles.error(),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^[\u0900-\u097F\u0966-\u096F a-zA-Z0-9\s/]+$'),
                      ),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        String text = newValue.text;
                        text = text.replaceAll(RegExp(r'\s+'), ' ');
                        text = text.trim();
                        if (text.length > 1) {
                          final lastChar = text[text.length - 1];
                          final secondLastChar = text[text.length - 2];
                          if (lastChar == ' ' &&
                              ((RegExp(r'[0-9]').hasMatch(secondLastChar) &&
                                      RegExp(r'[a-zA-Z]').hasMatch(
                                        text.substring(0, text.length - 2),
                                      )) ||
                                  (RegExp(
                                        r'[a-zA-Z]',
                                      ).hasMatch(secondLastChar) &&
                                      RegExp(r'[0-9]').hasMatch(
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
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return ValidationMessagesadhikar.getMessage(
                          'pleaseEnterFieldSurveyNo',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = value.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return ValidationMessagesadhikar.getMessage(
                          'invalidCharacters',
                          widget.isToggled,
                        );
                      }
                      return null;
                    },
                  ),
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
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.57,
                            color: const Color(0xFF36322E),
                          ),
                          // style: const TextStyle(
                          //   color: Color(0xFF36322E),
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.w400,
                          // ),
                          children: [
                            TextSpan(
                              text:
                                  ' ${LocalizedStrings.getString('byNameHint', widget.isToggled)}',
                              style: AppFontStyle2.blinker(
                                color: Color(0xFF36322E),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                      ),
                      // errorStyle: AppTextStyles.error(),
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
                        return ValidationMessagesadhikar.getMessage(
                          'pleaseEnterByName',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = value.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return ValidationMessagesadhikar.getMessage(
                          'invalidCharacters',
                          widget.isToggled,
                        );
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 53.0),
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
                              "lead_id": widget.package_lead_id,
                              "customer_id": customerId,
                              "package_id": widget.packageId ?? "",
                              "state_id": stateId,
                              "city_id": SelectedId,
                              "taluka_id": selectedTalukaId,
                              "village_id": selectedVillageId,
                              "survey_no": _surveyNoController.text.trim(),
                              "name":
                                  _ByNameIncasesurveynoisnotknownController.text
                                      .trim(),
                            };
                            submitLegalAdvisoryEnquiryForm(context, formData);
                          } else {
                            debugPrint("Validation failed. Fix errors.");
                          }
                        },
                        child: Center(
                          child: Text(
                            AdhikarAbhilekhStrings.getString(
                              'next',
                              widget.isToggled,
                            ),
                            style: AppFontStyle2.blinker(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1.57,
                              color: Colors.white,
                            ), // style: GoogleFonts.inter(
                            //   color: Colors.white,
                            //   fontSize: 18,
                            //   fontWeight: FontWeight.w500,
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 180),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
