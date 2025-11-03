// lib/validations/validation_messages.dart
class ValidationMessagesinvestigate {
  static String getMessage(String key, bool isToggled) {
    final Map<String, Map<String, String>> messages = {
      'pleaseSelectDistrict': {
        'en': 'Please select a district',
        'local': 'कृपया जिल्हा निवडा',
      },
      'pleaseSelectTaluka': {
        'en': 'Please select a taluka/tahsil',
        'local': 'कृपया तालुका निवडा',
      },
      'pleaseSelectVillage': {
        'en': 'Please select a village/mauza',
        'local': 'कृपया गाव निवडा',
      },
      'pleaseEnterCTSNo': {
        'en': 'Please enter CTS No/FS No./plot No',
        'local': 'कृपया सीटीएस क्रमांक/एफएस क्रमांक/प्लॉट क्रमांक प्रविष्ट करा',
      },
      'pleaseEnterByName': {
        'en': 'Please enter by name',
        'local': 'कृपया आपले नाव प्रविष्ट करा!',
      },
      'invalidCharacters': {
        'en': 'Invalid characters or script content detected',
        'local': 'अवैध अक्षरे किंवा स्क्रिप्ट सामग्री आढळली',
      },
      'onlyAlphabetsAllowed': {
        'en': 'Only alphabets and spaces allowed',
        'local': 'फक्त अक्षरे आणि रिकाम्या जागा परवानगी आहेत',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return messages[key]?[language] ??
        key; // Fallback to key if message not found
  }
}
