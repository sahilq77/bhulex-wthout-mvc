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

class EPropertyValuationPage extends StatefulWidget {
  final String id;
  final String packageId;
  final String serviceName;
  final String tblName;
  final bool isToggled;
  final String serviceNameInLocalLanguage;
  final String lead_id;
  final String customer_id;
  final String package_lead_id;

  const EPropertyValuationPage({
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
  _EPropertyValuationPageState createState() => _EPropertyValuationPageState();
}

class _EPropertyValuationPageState extends State<EPropertyValuationPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  List<Map<String, dynamic>> propertyTypes = [
    {
      "id": "1",
      "name": "Rural",
      "isSelected": false,
      "natureOfProperty": null,
      "district": null,
      "taluka": null,
      "village": null,
      "cornerPlot": null,
      "surveyNumber": ""
    },
    {
      "id": "2",
      "name": "Urban",
      "isSelected": false,
      "natureOfProperty": null,
      "district": null,
      "taluka": null,
      "village": null,
      "cornerPlot": null,
      "surveyNumber": ""
    },
  ];

  final List<String> natureOfProperties = [
    'Residential',
    'Commercial',
    'Agricultural',
    'Industrial'
  ];

  final List<String> districts = [
    'Mumbai',
    'Pune',
    'Nagpur',
    'Aurangabad',
    'Nashik'
  ];

  final List<String> talukas = ['Haveli', 'Khed', 'Mulshi', 'Shirur', 'Daund'];

  final List<String> villages = [
    'Wagholi',
    'Hadapsar',
    'Kharadi',
    'Hinjewadi',
    'Baner'
  ];

  final List<String> cornerPlotOptions = ['Yes', 'No'];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
      propertyTypes = propertyTypes.map((property) {
        return {
          ...property,
          'isSelected': false,
          'natureOfProperty': null,
          'district': null,
          'taluka': null,
          'village': null,
          'cornerPlot': null,
          'surveyNumber': ''
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
                      PropertyStrings.getString(
                          'description', widget.isToggled),
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
                        'pleaseEnterYourDetails', widget.isToggled),
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
                    children: propertyTypes.map((property) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFC5C5C5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: property['isSelected']
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
                                        property['isSelected'] =
                                            !property['isSelected'];
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
                                              property['name'],
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
                                            value: property['isSelected'],
                                            onChanged: (value) {
                                              setState(() {
                                                property['isSelected'] = value;
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
                              if (property['isSelected']) ...[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: FormField<String>(
                                    validator: (value) {
                                      if (property['natureOfProperty'] ==
                                          null) {
                                        return 'Please select nature of property';
                                      }
                                      return null;
                                    },
                                    builder: (FormFieldState<String> state) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DropdownSearch<String>(
                                            items: natureOfProperties,
                                            selectedItem:
                                                property['natureOfProperty'],
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                hintText:
                                                    PropertyStrings.getString(
                                                        'natureOfProperty',
                                                        widget.isToggled),
                                                hintStyle:
                                                    AppFontStyle2.blinker(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.57,
                                                  color:
                                                      const Color(0xFF36322E),
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
                                                      BorderRadius.circular(6),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFC5C5C5),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFC5C5C5),
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
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(r'^[a-zA-Z\s]+$'),
                                                  ),
                                                  LengthLimitingTextInputFormatter(
                                                      50),
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: widget.isToggled
                                                      ? 'संपत्ति की प्रकृति शोधा...'
                                                      : 'Search Nature of Property...',
                                                  hintStyle:
                                                      AppFontStyle2.blinker(),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xFFC5C5C5),
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
                                                property['natureOfProperty'] =
                                                    value;
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
                                      left: 8.0, right: 8),
                                  child: FormField<String>(
                                    validator: (value) {
                                      if (property['district'] == null) {
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
                                            selectedItem: property['district'],
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                hintText:
                                                    PropertyStrings.getString(
                                                        'district',
                                                        widget.isToggled),
                                                hintStyle:
                                                    AppFontStyle2.blinker(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.57,
                                                  color:
                                                      const Color(0xFF36322E),
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
                                                      BorderRadius.circular(6),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFC5C5C5),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFC5C5C5),
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
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(r'^[a-zA-Z\s]+$'),
                                                  ),
                                                  LengthLimitingTextInputFormatter(
                                                      50),
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
                                                      color: Color(0xFFC5C5C5),
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
                                                property['district'] = value;
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
                                      left: 8.0, right: 8),
                                  child: FormField<String>(
                                    validator: (value) {
                                      if (property['taluka'] == null) {
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
                                            selectedItem: property['taluka'],
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                hintText:
                                                    PropertyStrings.getString(
                                                        'taluka',
                                                        widget.isToggled),
                                                hintStyle:
                                                    AppFontStyle2.blinker(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.57,
                                                  color:
                                                      const Color(0xFF36322E),
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
                                                      BorderRadius.circular(6),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFC5C5C5),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFC5C5C5),
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
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(r'^[a-zA-Z\s]+$'),
                                                  ),
                                                  LengthLimitingTextInputFormatter(
                                                      50),
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
                                                      color: Color(0xFFC5C5C5),
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
                                                property['taluka'] = value;
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
                                      left: 8.0, right: 8),
                                  child: FormField<String>(
                                    validator: (value) {
                                      if (property['village'] == null) {
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
                                            selectedItem: property['village'],
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                hintText:
                                                    PropertyStrings.getString(
                                                        'village',
                                                        widget.isToggled),
                                                hintStyle:
                                                    AppFontStyle2.blinker(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.57,
                                                  color:
                                                      const Color(0xFF36322E),
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
                                                      BorderRadius.circular(6),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFC5C5C5),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFC5C5C5),
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
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(r'^[a-zA-Z\s]+$'),
                                                  ),
                                                  LengthLimitingTextInputFormatter(
                                                      50),
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
                                                      color: Color(0xFFC5C5C5),
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
                                                property['village'] = value;
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
                                      left: 8.0, right: 8),
                                  child: FormField<bool>(
                                    validator: (value) {
                                      if (property['cornerPlot'] == null) {
                                        return 'Please select corner plot option';
                                      }
                                      return null;
                                    },
                                    builder: (FormFieldState<bool> state) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFFC5C5C5)),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 14),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  PropertyStrings.getString(
                                                      'cornerPlot',
                                                      widget.isToggled),
                                                  style: AppFontStyle2.blinker(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.57,
                                                    color:
                                                        const Color(0xFF36322E),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          property[
                                                                  'cornerPlot'] =
                                                              true;
                                                          state.didChange(true);
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 20,
                                                            height: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: property[
                                                                          'cornerPlot'] ==
                                                                      true
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .transparent,
                                                              border:
                                                                  Border.all(
                                                                color: const Color(
                                                                    0xFFC5C5C5),
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: property[
                                                                        'cornerPlot'] ==
                                                                    true
                                                                ? const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 16,
                                                                    ),
                                                                  )
                                                                : null,
                                                          ),
                                                          const SizedBox(
                                                              width: 4),
                                                          Text(
                                                            'Yes',
                                                            style: AppFontStyle2
                                                                .blinker(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: const Color(
                                                                  0xFF36322E),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          property[
                                                                  'cornerPlot'] =
                                                              false;
                                                          state
                                                              .didChange(false);
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 20,
                                                            height: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: property[
                                                                          'cornerPlot'] ==
                                                                      false
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .transparent,
                                                              border:
                                                                  Border.all(
                                                                color: const Color(
                                                                    0xFFC5C5C5),
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: property[
                                                                        'cornerPlot'] ==
                                                                    false
                                                                ? const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 16,
                                                                    ),
                                                                  )
                                                                : null,
                                                          ),
                                                          const SizedBox(
                                                              width: 4),
                                                          Text(
                                                            'No',
                                                            style: AppFontStyle2
                                                                .blinker(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: const Color(
                                                                  0xFF36322E),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (state.errorText != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8, bottom: 8),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: PropertyStrings.getString(
                                          'surveyNumber', widget.isToggled),
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
                                      property['surveyNumber'] = value;
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
                              propertyTypes
                                  .any((property) => property['isSelected'])) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final String? stateId = prefs.getString('state_id');
                            final String? customerId =
                                prefs.getString('customer_id');

                            Map<String, dynamic> formData = {
                              "tbl_name": widget.tblName,
                              "customer_id": customerId,
                              "package_id": widget.packageId ?? "",
                              "state_id": stateId,
                              "lead_id": widget.package_lead_id,
                              "service_name": widget.isToggled
                                  ? widget.serviceNameInLocalLanguage
                                  : widget.serviceName,
                              "selected_properties": propertyTypes
                                  .where((property) => property['isSelected'])
                                  .map((property) => {
                                        "property_type": property['name'],
                                        "nature_of_property":
                                            property['natureOfProperty'],
                                        "district": property['district'],
                                        "taluka": property['taluka'],
                                        "village": property['village'],
                                        "corner_plot": property['cornerPlot'],
                                        "survey_number":
                                            property['surveyNumber'],
                                      })
                                  .toList(),
                            };

                            // Log formData or proceed with API call
                            developer.log("Form Data: $formData");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  propertyTypes.any(
                                          (property) => property['isSelected'])
                                      ? "Please fix form errors."
                                      : "Please select at least one property type.",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Center(
                          child: Text(
                            PropertyStrings.getString('next', widget.isToggled),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colorfile.borderDark,
                              ),
                              color: Colorfile.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: () {
                                developer.log("View Sample button pressed");
                              },
                              child: Center(
                                child: Text(
                                  PropertyStrings.getString(
                                      'viewSample', widget.isToggled),
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
                              border: Border.all(
                                color: Colorfile.lightwhite,
                              ),
                              color: Colorfile.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: () {
                                developer.log("Chat with Us button pressed");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppImages.whatsapp,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    PropertyStrings.getString(
                                        'chatWithUs', widget.isToggled),
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
