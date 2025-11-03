class ValidationMessagesseventweleve {
  // English Validation Messages
  static const String pleaseSelectDistrictEn = 'Please select a district';
  static const String pleaseSelectTalukaEn = 'Please select a taluka/tahsil';
  static const String pleaseSelectVillageEn = 'Please select a village/mauza';
  static const String pleaseEnterSurveyNoEn = 'Please enter field survey no.';
  static const String pleaseEnterByNameEn = 'Please enter by name';
  static const String invalidCharactersEn =
      'Invalid characters or script content detected';
  static const String onlyAlphabetsAllowedEn =
      'Only alphabets and spaces allowed';

  // Marathi Validation Messages
  static const String pleaseSelectDistrictMr = 'कृपया जिल्हा निवडा';
  static const String pleaseSelectTalukaMr = 'कृपया तालुका निवडा';
  static const String pleaseSelectVillageMr = 'कृपया गाव निवडा';
  static const String pleaseEnterSurveyNoMr =
      'कृपया फील्ड सर्वे क्रमांक प्रविष्ट करा';
  static const String pleaseEnterByNameMr = 'कृपया नाव प्रविष्ट करा';
  static const String invalidCharactersMr =
      'अवैध वर्ण किंवा स्क्रिप्ट सामग्री आढळली';
  static const String onlyAlphabetsAllowedMr =
      'फक्त अक्षरे आणि रिक्त स्थानांना परवानगी आहे';

  // Method to get validation message based on language toggle
  static String getMessage(String key, bool isToggled) {
    switch (key) {
      case 'pleaseSelectDistrict':
        return isToggled ? pleaseSelectDistrictMr : pleaseSelectDistrictEn;
      case 'pleaseSelectTaluka':
        return isToggled ? pleaseSelectTalukaMr : pleaseSelectTalukaEn;
      case 'pleaseSelectVillage':
        return isToggled ? pleaseSelectVillageMr : pleaseSelectVillageEn;
      case 'pleaseEnterSurveyNo':
        return isToggled ? pleaseEnterSurveyNoMr : pleaseEnterSurveyNoEn;
      case 'pleaseEnterByName':
        return isToggled ? pleaseEnterByNameMr : pleaseEnterByNameEn;
      case 'invalidCharacters':
        return isToggled ? invalidCharactersMr : invalidCharactersEn;
      case 'onlyAlphabetsAllowed':
        return isToggled ? onlyAlphabetsAllowedMr : onlyAlphabetsAllowedEn;
      default:
        return '';
    }
  }
}
