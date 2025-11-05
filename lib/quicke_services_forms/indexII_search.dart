import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bhulexapp/My_package/package_order_details.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/network/url.dart';
import 'package:bhulexapp/quicke_services_forms/pay.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../form_internet.dart';
import '../language/hindi.dart';
import '../validations_chan_lang/indexIIsearch.dart';

class IndexSearch1 extends StatefulWidget {
  final String id;
  final String serviceName;
  final String tblName;
  final String packageId; // Add this parameter
  final String lead_id;
  final String customer_id;
  final bool isToggled;
  final String serviceNameInLocalLanguage;
  final String package_lead_id;

  const IndexSearch1({
    Key? key,
    required this.packageId,

    required this.id,
    required this.serviceName,
    required this.tblName,
    required this.isToggled,
    required this.serviceNameInLocalLanguage,
    required this.lead_id,
    required this.customer_id,
    required this.package_lead_id,
  }) : super(key: key);

  @override
  State<IndexSearch1> createState() => _IndexSearch1State();
}

class _IndexSearch1State extends State<IndexSearch1> {
  final TextEditingController _ByNameIncasesurveynoisnotknownController =
      TextEditingController();
  final TextEditingController _CTSNoController = TextEditingController();
  List<Map<String, dynamic>> sroOfficeList = [];
  List<Map<String, dynamic>> CityData = [];
  List<Map<String, dynamic>> villageData = [];
  String? selectedSroOfficeName;
  bool isLoading = true;
  final NetworkChecker _networkChecker = NetworkChecker(); // Add NetworkChecker

  String? Selectedcity;
  String? SelectedId;
  String? selectedVillageName;
  String? selectedVillageId;
  String? selectedSroOfficeId;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _networkChecker.startMonitoring(context); // Start network monitoring

    // checkNetworkConnection();
    _fetchCity();
  }

  void _fetchSroOffice(int cityId) async {
    final String url = URLS().get_all_sro_office_apiUrl;
    print('Request URL: $url');
    var requestBody = {"city_id": cityId};
    print('Request Body: ${jsonEncode(requestBody)}');

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      print('SRO Office Response Status Code: ${response.statusCode}');
      print('SRO Office Raw Response Body: "${response.body}"');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'true') {
          setState(() {
            sroOfficeList = List<Map<String, dynamic>>.from(data['data'] ?? []);
            print('SRO Office List: $sroOfficeList');
          });
          log('Fetched SRO Office Data: ${data['data']}');
        } else {
          print(
            'Failed to load SRO Office: ${data['message'] ?? 'Unknown error'}',
          );
        }
      } else {
        print('Failed to load SRO Office. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching SRO Office: $e');
    }
  }

  Future<void> submitQuickServiceForm(
    BuildContext context,
    Map<String, dynamic> formData,
  ) async {
    final String url = URLS().submit_quick_service_enquiry_form_apiUrl;
    print("Submitting to URL: $url");
    print("Form Data: ${jsonEncode(formData)}");

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("Success Response Data: $responseData");

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Form submission failed. Status Code: ${response.statusCode}. Response: ${response.body}",
            ),
          ),
        );
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
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _fetchCity() async {
    final String url = URLS().get_all_city_apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('state_id', '22');
    print('state_id 22 saved to SharedPreferences');

    var requestBody = {"state_id": "22"};
    print('Request URL: $url');
    print('Request Body: ${jsonEncode(requestBody)}');

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Raw Response Body: "${response.body}"');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'true') {
          setState(() {
            CityData = List<Map<String, dynamic>>.from(data['data'] ?? []);
            isLoading = false;
          });
          print('Fetched City Data: ${data['data']}');
        } else {
          print('Failed to load city: ${data['message'] ?? 'Unknown error'}');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      Selectedcity = null;
      _CTSNoController.clear();
      selectedVillageName = null;
      selectedSroOfficeName = null;
      _ByNameIncasesurveynoisnotknownController.clear();
    });
    _fetchCity();
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

          style: AppFontStyle.poppins(
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    IndexSearchStrings.getString(
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
                        return indexValidationMessages.getMessage(
                          'pleaseSelectDistrict',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = Selectedcity!.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return indexValidationMessages.getMessage(
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
                                      ? (item['city_name_in_local_language'] ??
                                              item['city_name'] ??
                                              '')
                                          .toString()
                                      : (item['city_name'] ?? '').toString();
                                }).toList(),
                            selectedItem: Selectedcity,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: IndexSearchStrings.getString(
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
                              setState(() {
                                Selectedcity = value;
                                final selectedItem = CityData.firstWhere(
                                  (element) =>
                                      (widget.isToggled
                                          ? (element['city_name_in_local_language'] ??
                                              element['city_name'])
                                          : element['city_name']) ==
                                      value,
                                  orElse: () => {},
                                );

                                SelectedId =
                                    selectedItem.isNotEmpty
                                        ? selectedItem['id']?.toString()
                                        : null;

                                if (SelectedId != null) {
                                  _fetchSroOffice(int.parse(SelectedId!));
                                } else {
                                  print(
                                    'No matching city found for value: $value',
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
                      if (selectedSroOfficeName == null ||
                          selectedSroOfficeName!.trim().isEmpty) {
                        return indexValidationMessages.getMessage(
                          'pleaseSelectSROOffice',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = selectedSroOfficeName!.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return indexValidationMessages.getMessage(
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
                                sroOfficeList.map<String>((item) {
                                  return widget.isToggled
                                      ? (item['sro_office_name_in_local_language'] ??
                                              item['sro_office_name'] ??
                                              '')
                                          .toString()
                                      : (item['sro_office_name'] ?? '')
                                          .toString();
                                }).toList(),
                            selectedItem: selectedSroOfficeName,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: IndexSearchStrings.getString(
                                  'selectSROOffice',
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
                                    RegExp(r'[\p{L}\s]', unicode: true),
                                  ),
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                decoration: InputDecoration(
                                  hintText:
                                      widget.isToggled
                                          ? 'एसआरओ कार्यालय शोधा...'
                                          : 'Search SRO Office...',
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
                                selectedSroOfficeName = value;

                                final selectedItem = sroOfficeList.firstWhere(
                                  (item) =>
                                      (widget.isToggled
                                          ? (item['sro_office_name_in_local_language'] ??
                                              item['sro_office_name'])
                                          : item['sro_office_name']) ==
                                      value,
                                  orElse: () => {},
                                );

                                selectedSroOfficeId =
                                    selectedItem.isNotEmpty
                                        ? selectedItem['id']?.toString()
                                        : null;

                                print(
                                  "Selected SRO Office ID: $selectedSroOfficeId",
                                );

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
                    controller: _CTSNoController,
                    decoration: InputDecoration(
                      hintText: RegisteredDocumentStrings.getString(
                        'ctsNo',
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
                        RegExp(r'^[\u0900-\u097F\u0966-\u096F a-zA-Z0-9\s/]+$'),
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
                        return indexValidationMessages.getMessage(
                          'pleaseEnterCTSNo',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = value.trim();
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return indexValidationMessages.getMessage(
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
                            color: Color(0xFF36322E),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
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
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^[\u0900-\u097F\u0966-\u096F a-zA-Z\s/]+$'),
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
                        return indexValidationMessages.getMessage(
                          'pleaseEnterByName',
                          widget.isToggled,
                        );
                      }
                      final trimmedValue = value.trim();

                      // Check for invalid characters (scripts, HTML tags, etc.)
                      if (RegExp(
                        r'<.*?>|script|alert|on\w+=',
                        caseSensitive: false,
                      ).hasMatch(trimmedValue)) {
                        return indexValidationMessages.getMessage(
                          'invalidCharacters',
                          widget.isToggled,
                        );
                      }

                      // Check if matches pattern: letters + optional (space + letters) repeated
                      if (!RegExp(
                        r'^[\p{L}]+( [\p{L}]+)*$',
                        unicode: true,
                      ).hasMatch(trimmedValue)) {
                        return indexValidationMessages.getMessage(
                          'onlyAlphabetsAndSingleSpaces',
                          widget.isToggled,
                        );
                      }

                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
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
                              "package_id":
                                  widget.packageId ??
                                  "", // Send empty string if null                              "
                              "city_id": SelectedId,
                              "state_id": stateId,
                              "sro_office_id": selectedSroOfficeId,
                              "cts_no": _CTSNoController.text,
                              "name":
                                  _ByNameIncasesurveynoisnotknownController
                                      .text,
                              "customer_id": customerId,
                              "lead_id": widget.package_lead_id,
                            };

                            submitQuickServiceForm(context, formData);
                          } else {
                            debugPrint("Validation failed. Fix errors.");
                          }
                        },
                        child: Center(
                          child: Text(
                            IndexSearchStrings.getString(
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),
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
                        IndexSearchStrings.getString('note', widget.isToggled),

                        style: AppFontStyle2.blinker(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF36322E),
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
