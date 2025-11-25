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

  // SELECT ONLY ONE COURT AT A TIME
  void _selectOnlyThisCourt(Map<String, dynamic> selectedService) {
    setState(() {
      for (var service in courtServices) {
        if (service == selectedService) {
          service['isSelected'] = true;
        } else {
          service['isSelected'] = false;
          // Clear data of deselected courts
          service['caseType'] = null;
          service['bench'] = null;
          service['department'] = null;
          service['district'] = null;
          service['caseNumber'] = '';
          service['caseYear'] = '';
          service['partyName'] = '';
          service['partyYear'] = '';
        }
      }
    });
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

        if (widget.packageId.isNotEmpty) {
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
        } else {
          setState(() => isLoading = false);
        }
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      log('City Fetch Error: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      Selectedcity = null;
      // Reset all courts
      for (var service in courtServices) {
        service['isSelected'] = false;
        service['caseType'] = null;
        service['bench'] = null;
        service['department'] = null;
        service['district'] = null;
        service['caseNumber'] = '';
        service['caseYear'] = '';
        service['partyName'] = '';
        service['partyYear'] = '';
      }
    });
    _fetchCity();
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Description Box
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
                  const SizedBox(height: 16),

                  // Court Selection Cards
                  ...courtServices.map((service) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
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
                            // Header with Switch
                            InkWell(
                              onTap: () => _selectOnlyThisCourt(service),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: service['isSelected']
                                      ? const Border(
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        service['name'],
                                        style: AppFontStyle2.blinker(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF36322E),
                                        ),
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.7,
                                      child: Switch(
                                        value: service['isSelected'],
                                        onChanged: (value) {
                                          if (value) {
                                            _selectOnlyThisCourt(service);
                                          }
                                          // Else: Do nothing — user cannot turn off the last selected
                                        },
                                        activeColor: Colors.white,
                                        activeTrackColor: Colors.black,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Colors.black26,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Expanded Form Fields
                            if (service['isSelected']) ...[
                              const SizedBox(height: 12),

                              // High Court Bombay - Bench
                              if (service['name'] == 'High Court Bombay') ...[
                                _buildDropdown(
                                  hint: CourtcasesStrings.getString(
                                    'selectBench',
                                    widget.isToggled,
                                  ),
                                  items: bombayBenches,
                                  value: service['bench'],
                                  onChanged: (val) =>
                                      setState(() => service['bench'] = val),
                                  validator: () => service['bench'] == null
                                      ? 'Select bench'
                                      : null,
                                ),
                                const SizedBox(height: 12),
                              ],

                              // Revenue Courts - Department & District
                              if (service['name'] == 'Revenue Courts') ...[
                                _buildDropdown(
                                  hint: CourtcasesStrings.getString(
                                    'department',
                                    widget.isToggled,
                                  ),
                                  items: revenueDepartments,
                                  value: service['department'],
                                  onChanged: (val) => setState(
                                    () => service['department'] = val,
                                  ),
                                  validator: () => service['department'] == null
                                      ? 'Select department'
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                _buildDropdown(
                                  hint: CourtcasesStrings.getString(
                                    'district',
                                    widget.isToggled,
                                  ),
                                  items: revenueDistricts,
                                  value: service['district'],
                                  onChanged: (val) =>
                                      setState(() => service['district'] = val),
                                  validator: () => service['district'] == null
                                      ? 'Select district'
                                      : null,
                                ),
                                const SizedBox(height: 12),
                              ],

                              // Case Type (All Courts)
                              _buildDropdown(
                                hint: CourtcasesStrings.getString(
                                  'caseType',
                                  widget.isToggled,
                                ),
                                items: caseTypes,
                                value: service['caseType'],
                                onChanged: (val) =>
                                    setState(() => service['caseType'] = val),
                                validator: () => service['caseType'] == null
                                    ? 'Select case type'
                                    : null,
                              ),
                              const SizedBox(height: 12),

                              // Case Number & Year
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        'caseNumber',
                                        service,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildTextField(
                                        'caseYear',
                                        service,
                                        isNumber: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Party Name & Year (If case number unknown)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      CourtcasesStrings.getString(
                                        'ifNotKnown',
                                        widget.isToggled,
                                      ),
                                      style: AppFontStyle2.blinker(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    _buildTextField('partyName', service),
                                    const SizedBox(height: 12),
                                    _buildTextField(
                                      'partyYear',
                                      service,
                                      isNumber: true,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ],
                        ),
                      ),
                    );
                  }).toList(),

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
                        if (_formKey.currentState!.validate() &&
                            courtServices.any((s) => s['isSelected'])) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final customerId = prefs.getString('customer_id');
                          final stateId = prefs.getString('state_id');

                          Map<String, dynamic> formData = {
                            "tbl_name": widget.tblName,
                            "customer_id": customerId,
                            "package_id": widget.packageId,
                            "state_id": stateId,
                            "lead_id": widget.package_lead_id,
                            "service_name": widget.isToggled
                                ? widget.serviceNameInLocalLanguage
                                : widget.serviceName,
                            "city_id": SelectedId,
                            "selected_courts": courtServices
                                .where((s) => s['isSelected'])
                                .map(
                                  (s) => {
                                    "court_id": s['id'],
                                    "case_type": s['caseType'],
                                    "bench": s['bench'],
                                    "department": s['department'],
                                    "district": s['district'],
                                    "case_number": s['caseNumber'],
                                    "case_year": s['caseYear'],
                                    "party_name": s['partyName'],
                                    "party_year": s['partyYear'],
                                  },
                                )
                                .toList(),
                          };

                          submitLegalAdvisoryEnquiryForm(context, formData);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                courtServices.any((s) => s['isSelected'])
                                    ? "Please fill all required fields."
                                    : "Please select one court to proceed.",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(
                        CourtcasesStrings.getString('next', widget.isToggled),
                        style: const TextStyle(
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
                      onPressed: () => print("View Sample Pressed"),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colorfile.borderDark),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
            ),
          ),
        ),
      ),
    );
  }

  // Helper: Dropdown Field
  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
    required String? Function() validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: FormField<String>(
        validator: (_) => validator(),
        builder: (state) => DropdownSearch<String>(
          items: items,
          selectedItem: value,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: hint,
              errorText: state.errorText,
              errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
              ),
            ),
          ),
          popupProps: const PopupProps.menu(showSearchBox: true),
          onChanged: (val) {
            onChanged(val);
            state.didChange(val);
          },
        ),
      ),
    );
  }

  // Helper: Text Field
  Widget _buildTextField(
    String key,
    Map<String, dynamic> service, {
    bool isNumber = false,
  }) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: CourtcasesStrings.getString(key, widget.isToggled),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFC5C5C5)),
        ),
      ),
      onChanged: (val) => service[key] = val,
    );
  }
}
