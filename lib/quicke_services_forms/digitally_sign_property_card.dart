import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bhulexapp/My_package/package_order_details.dart';
import 'package:bhulexapp/colors/order_fonts.dart';
import 'package:bhulexapp/form_internet.dart';
import 'package:bhulexapp/language/hindi.dart';
import 'package:bhulexapp/network/url.dart';
import 'package:bhulexapp/quicke_services_forms/pay.dart';
import 'package:bhulexapp/validations_chan_lang/propertycard.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class propertyCard extends StatefulWidget {
  final String id;
  final String serviceName;
  final String tblName;
  final String packageId; // Add this parameter
  final bool isToggled;
  final String serviceNameInLocalLanguage;
  final String package_lead_id;
  final String lead_id;
  final String customer_id;
  const propertyCard({
    Key? key,
    required this.id,
    required this.serviceName,
    required this.tblName,
    required this.isToggled,
    required this.serviceNameInLocalLanguage,
    required this.packageId,
    required this.package_lead_id,
    required this.lead_id,
    required this.customer_id,
  }) : super(key: key);

  @override
  State<propertyCard> createState() => _propertyCardState();
}

class _propertyCardState extends State<propertyCard> {
  List<Map<String, dynamic>> CityData = [];
  String? Selectedcity;
  String? SelectedId;
  List<Map<String, dynamic>> villageData = [];
  String? selectedVillageName;
  String? selectedVillageId;
  String? _selectedregion;
  String? selectedRegionId;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  final NetworkChecker _networkChecker = NetworkChecker(); // Add NetworkChecker
  String _selectedLanguage = 'en'; // Default: English
  List<Map<String, dynamic>> regionData = [];
  final TextEditingController _CTSNoController = TextEditingController();
  final TextEditingController _officeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.tblName);
    //checkNetworkConnection();
    _networkChecker.startMonitoring(context); // Start network monitoring

    _fetchCity();
    _fetchRegion();
  }

  String _getCurrentLanguage() {
    if (widget.isToggled) return 'mr'; // Marathi
    if (_selectedLanguage == 'hi') return 'hi';
    return 'en';
  }

  Future<void> submitQuickServiceForm(
    BuildContext context,
    Map<String, dynamic> formData,
  ) async {
    final String url = URLS().submit_quick_service_enquiry_form_apiUrl;

    try {
      // Print the request body
      print("Request Body: ${jsonEncode(formData)}");

      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("Response body: ${responseData}");
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Form submission failed. Please try again."),
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

  void _fetchRegion() async {
    final String url = URLS().get_all_region_apiUrl;
    log('region URL: $url');
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('➡ HTTP Status Code: ${response.statusCode}');
        log('➡ Response Body: ${response.body}');

        if (data != null &&
            data is Map<String, dynamic> &&
            data['status'].toString() == 'true' &&
            data['data'] != null &&
            data['data'] is List) {
          setState(() {
            regionData = List<Map<String, dynamic>>.from(data['data']);
            isLoading = false;
            print('Region Data Loaded: ${regionData.length} items');
            print('Region Data Content: $regionData');
          });
        } else {
          print(
            'API returned invalid data: ${data['message'] ?? 'No message'}',
          );
          setState(() {
            isLoading = false;
            regionData = []; // Ensure empty list to avoid null issues
          });
        }
      } else {
        print('Server error: ${response.statusCode}');
        setState(() {
          isLoading = false;
          regionData = [];
        });
      }
    } catch (e) {
      print('Exception: $e');
      setState(() {
        isLoading = false;
        regionData = [];
      });
    }
  }

  void _fetchCity() async {
    final String url = URLS().get_all_city_apiUrl;

    // Fetch state_id from SharedPreferences
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
        print('Response Status Code: ${response.statusCode}');
        print('Raw Response Body: "${response.body}"');
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

  void _fetchVillages(String cityId) async {
    final url = URLS().get_all_village_by_city_apiUrl;
    var requestBody = {"city_id": cityId};

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'true') {
          setState(() {
            villageData = List<Map<String, dynamic>>.from(data['data']);
          });
        }
      }
    } catch (e) {
      print("Exception while fetching villages: $e");
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      Selectedcity = null;
      _CTSNoController.clear();
      selectedVillageName = null;
      selectedRegionId = null;
      _officeController.clear();
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
            child: Container(
              height: 850,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      PropertyCardStrings.getString(
                        'pleaseEnterYourDetails',
                        widget.isToggled,
                      ),

                      style: AppFontStyle.poppins(
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
                        if (_selectedregion == null ||
                            _selectedregion!.trim().isEmpty) {
                          return 'Please select a region';
                        }
                        return null;
                      },
                      builder: (FormFieldState<String> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownSearch<String>(
                              items: regionData.map<String>((item) {
                                return widget.isToggled
                                    ? (item['region_name_in_local_language'])
                                          .toString()
                                    : (item['region_name']).toString();
                              }).toList(),
                              selectedItem: _selectedregion,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: PropertyCardStrings.getString(
                                    'region', // Changed from 'Region' to 'region' to match the key
                                    widget.isToggled,
                                  ),
                                  hintStyle: AppFontStyle2.blinker(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.57,
                                    color: const Color(0xFF36322E),
                                  ),
                                  border: OutlineInputBorder(),
                                  errorText: state.errorText,
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: widget.isToggled
                                        ? 'प्रदेश शोधा...'
                                        : 'Search Region...',
                                    hintStyle: AppFontStyle2.blinker(),
                                    border: OutlineInputBorder(),
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
                                  _selectedregion = value;
                                  final matchedRegion = regionData.firstWhere(
                                    (element) =>
                                        (widget.isToggled
                                            ? (element['region_name_in_local_language'] ??
                                                  element['region_name'])
                                            : element['region_name']) ==
                                        value,
                                    orElse: () => {},
                                  );
                                  selectedRegionId = matchedRegion.isNotEmpty
                                      ? matchedRegion['id'].toString()
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
                    FormField<String>(
                      validator: (value) {
                        if (Selectedcity == null ||
                            Selectedcity!.trim().isEmpty) {
                          return ValidationMessagespropertycard.getMessage(
                            'pleaseSelectDistrict',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = Selectedcity!.trim();
                        if (RegExp(
                          r'<.*?>|script|alert|on\w+=',
                          caseSensitive: false,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagespropertycard.getMessage(
                            'invalidCharacters',
                            widget.isToggled,
                          );
                        }
                        // if (!RegExp(
                        //   r'^[\p{L}\s]+$',
                        //   unicode: true,
                        // ).hasMatch(trimmedValue)) {
                        //   return ValidationMessagespropertycard.getMessage(
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
                              items: CityData.map<String>((item) {
                                return widget.isToggled
                                    ? (item['city_name_in_local_language'])
                                          .toString()
                                    : (item['city_name']).toString();
                              }).toList(),
                              selectedItem: Selectedcity,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: PropertyCardStrings.getString(
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
                                    hintText: widget.isToggled
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
                                if (value != null) {
                                  setState(() {
                                    Selectedcity = value;

                                    // Find the matching city based on toggled state
                                    final matchedCity = CityData.firstWhere(
                                      (element) {
                                        final displayName = widget.isToggled
                                            ? (element['city_name_in_local_language'] ??
                                                  element['city_name'] ??
                                                  '')
                                            : (element['city_name'] ?? '');
                                        return displayName == value;
                                      },
                                      orElse: () =>
                                          {}, // Return empty map if no match
                                    );

                                    // Set SelectedId safely
                                    SelectedId = matchedCity.isNotEmpty
                                        ? matchedCity['id'].toString()
                                        : null;

                                    // Fetch villages if SelectedId is valid
                                    if (SelectedId != null) {
                                      _fetchVillages(SelectedId!);
                                    } else {
                                      print(
                                        "No matching city found for value: '$value'",
                                      );
                                    }

                                    state.didChange(value);
                                  });
                                }
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
                          return ValidationMessagespropertycard.getMessage(
                            'pleaseSelectVillage',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = selectedVillageName!.trim();
                        if (RegExp(
                          r'<.*?>|script|alert|on\w+=',
                          caseSensitive: false,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagespropertycard.getMessage(
                            'invalidCharacters',
                            widget.isToggled,
                          );
                        }
                        if (!RegExp(
                          r'^[\p{L}\s]+$',
                          unicode: true,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagespropertycard.getMessage(
                            'onlyAlphabetsAllowed',
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
                                  hintText: PropertyCardStrings.getString(
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
                      controller: _officeController,
                      decoration: InputDecoration(
                        hintText: PropertyCardStrings.getString(
                          'office',
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
                      inputFormatters: [
                        // Custom formatter to allow letters and single spaces
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^[a-zA-Z\u0900-\u095F\u0970-\u097F\s]+$'),
                        ),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          // Prevent multiple spaces and leading/trailing spaces
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
                          return ValidationMessagespropertycard.getMessage(
                            'pleaseEnterOffice',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = value.trim();
                        if (RegExp(
                          r'<.*?>|script|alert|on\w+=',
                          caseSensitive: false,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagespropertycard.getMessage(
                            'invalidCharacters',
                            widget.isToggled,
                          );
                        }
                        // Validate: only letters and single spaces between words
                        if (!RegExp(
                          r'^[\p{L}]+( [\p{L}]+)*$', // Letters + optional (space + letters) repeated
                          unicode: true,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagespropertycard.getMessage(
                            'onlyAlphabetsAndSingleSpaces',
                            widget.isToggled,
                          );
                        }
                        return null;
                      },
                      style: AppFontStyle2.blinker(),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _CTSNoController,
                      decoration: InputDecoration(
                        hintText: PropertyCardStrings.getString(
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
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r'^[\u0900-\u097F\u0966-\u096F a-zA-Z0-9\s/]+$',
                          ),
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
                          return ValidationMessagespropertycard.getMessage(
                            'pleaseEnterCTSNo',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = value.trim();
                        if (RegExp(
                          r'<.*?>|script|alert|on\w+=',
                          caseSensitive: false,
                        ).hasMatch(trimmedValue)) {
                          return ValidationMessagespropertycard.getMessage(
                            'invalidCharacters',
                            widget.isToggled,
                          );
                        }
                        return null;
                      },
                      style: AppFontStyle2.blinker(),
                    ),
                    // ============== LANGUAGE DROPDOWN (NEW) ==============
                    const SizedBox(height: 16),

                    // ============== LANGUAGE DROPDOWN (3 LANGUAGES) added By Sahil ==============
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFC5C5C5)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _getCurrentLanguage(),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF9CA3AF),
                          ),
                          hint: Text(
                            LocalizedStrings.getString(
                              'selectLanguage',
                              widget.isToggled,
                            ),
                            style: AppFontStyle2.blinker(
                              fontSize: 16,
                              color: Color(0xFF36322E),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text(
                                "English",
                                style: AppFontStyle2.blinker(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'hi',
                              child: Text(
                                "हिंदी",
                                style: AppFontStyle2.blinker(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'mr',
                              child: Text(
                                "मराठी",
                                style: AppFontStyle2.blinker(fontSize: 16),
                              ),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                // Update toggle: true = Marathi, false = English, but now we support Hindi too
                                // You can extend your logic here
                                if (newValue == 'mr') {
                                  _selectedLanguage = 'mr';
                                } else if (newValue == 'hi') {
                                  _selectedLanguage = 'hi';
                                } else {
                                  _selectedLanguage = 'en';
                                }
                              });

                              // Save to SharedPreferences
                              SharedPreferences.getInstance().then((prefs) {
                                prefs.setString(
                                  'app_language',
                                  _selectedLanguage,
                                );
                              });

                              // Trigger rebuild in parent if needed
                              // widget.onLanguageChanged?.call(_selectedLanguage == 'mr');
                            }
                          },
                        ),
                      ),
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
                              final String? stateId = prefs.getString(
                                'state_id',
                              );
                              final String? customerId = prefs.getString(
                                'customer_id',
                              );
                              Map<String, dynamic> formData = {
                                "tbl_name": widget.tblName,
                                "lead_id": widget.package_lead_id,

                                "package_id":
                                    widget.packageId ??
                                    "", // Send empty string if null
                                "customer_id": customerId,
                                "state_id": stateId,
                                "city_id": SelectedId,
                                "village_id": selectedVillageId,
                                "region": selectedRegionId,
                                "sro_office": _officeController.text,
                                "cts_no": _CTSNoController.text,
                              };
                              submitQuickServiceForm(context, formData);
                            }
                          },
                          child: Center(
                            child: Text(
                              PropertyCardStrings.getString(
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

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          //    foregroundColor: Colors.black, // Text color
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'View Sample',
                          style: AppFontStyle2.blinker(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                        PropertyCardStrings.getString('note', widget.isToggled),

                        style: AppFontStyle2.blinker(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF36322E),
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
