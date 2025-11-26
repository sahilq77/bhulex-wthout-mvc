import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

// Assuming these are defined in your project
import '../Core/AppImages.dart';
import '../colors/custom_color.dart';
import '../colors/order_fonts.dart';
import '../language/hindi.dart';

class AapliChawadiPage extends StatefulWidget {
  final String id;
  final String packageId;
  final String serviceName;
  final String tblName;
  final bool isToggled;
  final String serviceNameInLocalLanguage;
  final String lead_id;
  final String customer_id;
  final String package_lead_id;

  const AapliChawadiPage({
    Key? key,
    required this.id,
    required this.packageId,
    required this.serviceName,
    required this.tblName,
    required this.isToggled,
    required this.serviceNameInLocalLanguage,
    required this.lead_id,
    required this.customer_id,
    required this.package_lead_id,
  }) : super(key: key);

  @override
  _AapliChawadiPageState createState() => _AapliChawadiPageState();
}

class _AapliChawadiPageState extends State<AapliChawadiPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  List<Map<String, dynamic>> documentTypes = [
    {
      "id": "1",
      "name": "7/12 Extract Mutation",
      "isSelected": false,
      "district": null,
      "taluka": null,
      "village": null,
      "surveyNumber": "",
    },
    {
      "id": "2",
      "name": "Property Card Mutation",
      "isSelected": false,
      "district": null,
      "taluka": null,
      "village": null,
      "office": null,
      "surveyNumber": "",
    },
  ];

  final List<String> districts = [
    'Mumbai',
    'Pune',
    'Nagpur',
    'Aurangabad',
    'Nashik',
  ];

  final List<String> talukas = ['Haveli', 'Khed', 'Mulshi', 'Shirur', 'Daund'];

  final List<String> villages = [
    'Wagholi',
    'Hadapsar',
    'Kharadi',
    'Hinjewadi',
    'Baner',
  ];

  final List<String> offices = [
    'City Survey Office',
    'Land Records Office',
    'Sub-Registrar Office',
    'Revenue Office',
    'Municipal Office',
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      documentTypes = documentTypes.map((document) {
        return {
          ...document,
          'isSelected': false,
          'district': null,
          'taluka': null,
          'village': null,
          'office': null,
          'surveyNumber': '',
        };
      }).toList();
      isLoading = false;
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
                      Aaplichawli.getString('description', widget.isToggled),
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
                    PropertyStrings.getString(
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
                    children: documentTypes.map((document) {
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
                                    border: document['isSelected']
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
                                        document['isSelected'] =
                                            !document['isSelected'];
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
                                              document['name'],
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
                                            value: document['isSelected'],
                                            onChanged: (value) {
                                              setState(() {
                                                document['isSelected'] = value;
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
                              const SizedBox(height: 12),
                              if (document['isSelected']) ...[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8,
                                  ),
                                  child: FormField<String>(
                                    validator: (value) {
                                      if (document['district'] == null) {
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
                                            items: districts,
                                            selectedItem: document['district'],
                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                              dropdownSearchDecoration: InputDecoration(
                                                hintText: Aaplichawli.getString(
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
                                                document['district'] = value;
                                                state.didChange(value);
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                if (document['name'] ==
                                    "Property Card Mutation") ...[
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8,
                                    ),
                                    child: FormField<String>(
                                      validator: (value) {
                                        if (document['office'] == null) {
                                          return 'Please select an office';
                                        }
                                        return null;
                                      },
                                      builder: (FormFieldState<String> state) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DropdownSearch<String>(
                                              items: offices,
                                              selectedItem: document['office'],
                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                dropdownSearchDecoration: InputDecoration(
                                                  hintText:
                                                      Aaplichawli.getString(
                                                        'office',
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
                                                        ? 'कार्यालय शोधा...'
                                                        : 'Search Office...',
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
                                                  document['office'] = value;
                                                  state.didChange(value);
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8,
                                  ),
                                  child: FormField<String>(
                                    validator: (value) {
                                      if (document['taluka'] == null) {
                                        return 'Please select a taluka';
                                      }
                                      return null;
                                    },
                                    builder: (FormFieldState<String> state) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DropdownSearch<String>(
                                            items: talukas,
                                            selectedItem: document['taluka'],
                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                              dropdownSearchDecoration: InputDecoration(
                                                hintText: Aaplichawli.getString(
                                                  'taluka',
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
                                                      ? 'तहसील शोधा...'
                                                      : 'Search Taluka...',
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
                                                document['taluka'] = value;
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
                                      if (document['village'] == null) {
                                        return 'Please select a village';
                                      }
                                      return null;
                                    },
                                    builder: (FormFieldState<String> state) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DropdownSearch<String>(
                                            items: villages,
                                            selectedItem: document['village'],
                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                              dropdownSearchDecoration: InputDecoration(
                                                hintText: Aaplichawli.getString(
                                                  'village',
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
                                                      ? 'गाँव शोधा...'
                                                      : 'Search Village...',
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
                                                document['village'] = value;
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
                                    bottom: 8,
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: Aaplichawli.getString(
                                        'surveyNumber',
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
                                      document['surveyNumber'] = value;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter survey number';
                                      }
                                      return null;
                                    },
                                  ),
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
                              documentTypes.any(
                                (document) => document['isSelected'],
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
                              "selected_documents": documentTypes
                                  .where((document) => document['isSelected'])
                                  .map(
                                    (document) => {
                                      "document_type": document['name'],
                                      "district": document['district'],
                                      "taluka": document['taluka'],
                                      "village": document['village'],
                                      "office": document['office'],
                                      "survey_number": document['surveyNumber'],
                                    },
                                  )
                                  .toList(),
                            };

                            // Log formData or proceed with API call
                            developer.log("Form Data: $formData");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  documentTypes.any(
                                        (document) => document['isSelected'],
                                      )
                                      ? "Please fix form errors."
                                      : "Please select at least one document type.",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Center(
                          child: Text(
                            Aaplichawli.getString('next', widget.isToggled),
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
                          developer.log("View Sample button pressed");
                        },
                        child: Center(
                          child: Text(
                            Aaplichawli.getString(
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
