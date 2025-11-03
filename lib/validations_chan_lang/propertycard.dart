class ValidationMessagespropertycard {
  // English Validation Messages (existing ones remain unchanged)
  static const String pleaseSelectRegionEn = 'Please select a region';
  static const String pleaseSelectDistrictEn = 'Please select a district';
  static const String pleaseSelectVillageEn = 'Please select a village/mauza';

  static const String pleaseEnterOfficeEn = 'Please enter Office';
  static const String pleaseEnterCTSNoEn = 'Please enter CTS No.';

  // Marathi Validation Messages (existing ones remain unchanged)
  static const String pleaseSelectRegionMr = 'कृपया प्रदेश निवडा';
  static const String pleaseSelectDistrictMr = 'कृपया जिल्हा निवडा';
  static const String pleaseSelectVillageMr = 'कृपया गाव निवडा';
  static const String pleaseEnterOfficeMr = 'कृपया कार्यालय प्रविष्ट करा';
  static const String pleaseEnterCTSNoMr = 'कृपया सीटीएस क्रमांक प्रविष्ट करा';

  // Updated getMessage method (add new cases)
  static String getMessage(String key, bool isToggled) {
    switch (key) {
      // Existing cases...
      case 'pleaseSelectRegion':
        return isToggled ? pleaseSelectRegionMr : pleaseSelectRegionEn;
      case 'pleaseSelectDistrict':
        return isToggled ? pleaseSelectDistrictMr : pleaseSelectDistrictEn;
      case 'pleaseSelectVillage':
        return isToggled ? pleaseSelectVillageMr : pleaseSelectVillageEn;
      case 'pleaseEnterOffice':
        return isToggled ? pleaseEnterOfficeMr : pleaseEnterOfficeEn;
      case 'pleaseEnterCTSNo':
        return isToggled ? pleaseEnterCTSNoMr : pleaseEnterCTSNoEn;
      // Other existing cases...
      default:
        return '';
    }
  }
}
