import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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
import '../validations_chan_lang/propertycard.dart';
import 'pay.dart';

class propertyCard extends StatefulWidget {
  final String id;
  final String serviceName;
  final String tblName;
  final String packageId;
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
  List<Map<String, dynamic>> talukaData = [];
  String? selectedTaluka;
  String? selectedTalukaId;
  List<Map<String, dynamic>> villageData = [];
  String? selectedVillage;
  String? selectedVillageId;
  List<Map<String, dynamic>> officeData = [];
  String? selectedOffice;
  String? selectedOfficeId;
  String? selectedLanguage;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  final NetworkChecker _networkChecker = NetworkChecker();
  final TextEditingController _CTSNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.tblName);
    _networkChecker.startMonitoring(context);
    _fetchCity();
    _fetchOffices();
  }

  Future<void> submitQuickServiceForm(
    BuildContext context,
    Map<String, dynamic> formData,
  ) async {
    final String url = URLS().submit_quick_service_enquiry_form_apiUrl;

    try {
      print("Request Body: ${jsonEncode(formData)}");
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
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

  void _fetchTaluka(String cityId) async {
    final String url = URLS().get_all_taluka_apiUrl;
    var requestBody = {"city_id": cityId};
    log('Request Body: ${jsonEncode(requestBody)}');

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Taluka Response Status Code: ${response.statusCode}');
        print('Taluka Raw Response Body: "${response.body}"');

        if (data['status'] == 'true') {
          setState(() {
            talukaData = List<Map<String, dynamic>>.from(data['data']);
            selectedTaluka = null;
            selectedTalukaId = null;
            villageData = [];
            selectedVillage = null;
            selectedVillageId = null;
          });
        }
      }
    } catch (e) {
      print('Taluka fetch error: $e');
    }
  }

  void _fetchVillage(String talukaId) async {
    final String url = URLS().get_all_village_apiUrl;
    var requestBody = {"taluka_id": talukaId};
    log('Request Body: ${jsonEncode(requestBody)}');

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Village Response Status Code: ${response.statusCode}');
        print('Village Raw Response Body: "${response.body}"');

        if (data['status'] == 'true') {
          setState(() {
            villageData = List<Map<String, dynamic>>.from(data['data']);
          });
        }
      }
    } catch (e) {
      print('Village fetch error: $e');
    }
  }

  void _fetchOffices() async {
    // final String url =
    //     URLS().get_all_offices_apiUrl; // Ensure this URL is defined
    // var requestBody = {"state_id": "22"};
    // log('Request Body: ${jsonEncode(requestBody)}');

    // try {
    //   var response = await http.post(
    //     Uri.parse(url),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode(requestBody),
    //   );

    //   if (response.statusCode == 200) {
    //     final data = jsonDecode(response.body);
    //     print('Office Response Status Code: ${response.statusCode}');
    //     print('Office Raw Response Body: "${response.body}"');

    //     if (data['status'] == 'true') {
    //       setState(() {
    //         officeData = List<Map<String, dynamic>>.from(data['data']);
    //       });
    //     }
    //   }
    // } catch (e) {
    //   print('Office fetch error: $e');
    // }
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      Selectedcity = null;
      SelectedId = null;
      selectedTaluka = null;
      selectedTalukaId = null;
      selectedVillage = null;
      selectedVillageId = null;
      selectedOffice = null;
      selectedOfficeId = null;
      _CTSNoController.clear();
      selectedLanguage = null;
    });
    _fetchCity();
    _fetchOffices();
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
                          PropertyCardStrings.getString(
                            'note',
                            widget.isToggled,
                          ),
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
                                    borderSide: BorderSide(
                                      color: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
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
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
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
                                    final matchedCity = CityData.firstWhere((
                                      element,
                                    ) {
                                      final displayName = widget.isToggled
                                          ? (element['city_name_in_local_language'] ??
                                                element['city_name'] ??
                                                '')
                                          : (element['city_name'] ?? '');
                                      return displayName == value;
                                    }, orElse: () => {});
                                    SelectedId = matchedCity.isNotEmpty
                                        ? matchedCity['id'].toString()
                                        : null;
                                    if (SelectedId != null) {
                                      _fetchTaluka(SelectedId!);
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
                        if (selectedTaluka == null ||
                            selectedTaluka!.trim().isEmpty) {
                          return ValidationMessagespropertycard.getMessage(
                            'pleaseSelectTaluka',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = selectedTaluka!.trim();
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
                                  hintText: PropertyCardStrings.getString(
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
                                    borderSide: BorderSide(
                                      color: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
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
                                        ? 'तालुका शोधा...'
                                        : 'Search Taluka...',
                                    hintStyle: AppFontStyle2.blinker(),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
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
                                  selectedTalukaId = matchedTaluka.isNotEmpty
                                      ? matchedTaluka['id'].toString()
                                      : null;
                                  if (selectedTalukaId != null) {
                                    _fetchVillage(selectedTalukaId!);
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
                        if (selectedOffice == null ||
                            selectedOffice!.trim().isEmpty) {
                          return ValidationMessagespropertycard.getMessage(
                            'pleaseSelectOffice',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = selectedOffice!.trim();
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
                      builder: (FormFieldState<String> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownSearch<String>(
                              items: officeData.map<String>((item) {
                                return widget.isToggled
                                    ? (item['office_name_in_local_language'] ??
                                              item['office_name'] ??
                                              '')
                                          .toString()
                                    : (item['office_name'] ?? '').toString();
                              }).toList(),
                              selectedItem: selectedOffice,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
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
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
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
                                        ? 'कार्यालय शोधा...'
                                        : 'Search Office...',
                                    hintStyle: AppFontStyle2.blinker(),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
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
                                  selectedOffice = value;
                                  final matchedOffice = officeData.firstWhere(
                                    (element) =>
                                        (widget.isToggled
                                            ? (element['office_name_in_local_language'] ??
                                                  element['office_name'])
                                            : element['office_name']) ==
                                        value,
                                    orElse: () => {},
                                  );
                                  selectedOfficeId = matchedOffice.isNotEmpty
                                      ? matchedOffice['id'].toString()
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
                        if (selectedVillage == null ||
                            selectedVillage!.trim().isEmpty) {
                          return ValidationMessagespropertycard.getMessage(
                            'pleaseSelectVillage',
                            widget.isToggled,
                          );
                        }
                        final trimmedValue = selectedVillage!.trim();
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
                              selectedItem: selectedVillage,
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
                                    borderSide: BorderSide(
                                      color: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
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
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
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
                                  selectedVillage = value;
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
                          borderSide: BorderSide(color: Color(0xFFC5C5C5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFC5C5C5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFC5C5C5)),
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
                    const SizedBox(height: 16),
                    FormField<String>(
                      validator: (value) {
                        if (selectedLanguage == null ||
                            selectedLanguage!.trim().isEmpty) {
                          return ValidationMessagespropertycard.getMessage(
                            'pleaseSelectLanguage',
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
                              items: const ["English", "Marathi"],
                              selectedItem: selectedLanguage,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: LocalizedStrings.getString(
                                    'selectLanguage',
                                    widget.isToggled,
                                  ),
                                  labelText: LocalizedStrings.getString(
                                    'selectLanguage',
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
                                    borderSide: BorderSide(
                                      color: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
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
                                      RegExp(r'^[a-zA-Z\s]+$'),
                                    ),
                                    LengthLimitingTextInputFormatter(50),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: widget.isToggled
                                        ? 'भाषा शोधा...'
                                        : 'Search Language...',
                                    hintStyle: AppFontStyle2.blinker(),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC5C5C5),
                                      ),
                                    ),
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
                                  selectedLanguage = value;
                                  state.didChange(value);
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
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
                                "package_id": widget.packageId ?? "",
                                "customer_id": customerId,
                                "state_id": stateId,
                                "city_id": SelectedId,
                                "taluka_id": selectedTalukaId,
                                "village_id": selectedVillageId,
                                "sro_office": selectedOfficeId,
                                "cts_no": _CTSNoController.text,
                                "language": selectedLanguage,
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
                    const SizedBox(height: 16),
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
