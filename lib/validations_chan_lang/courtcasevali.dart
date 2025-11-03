// lib/validations/validation_messages.dart
class ValidationMessagescourtcase {
  static String getMessage(String key, bool isToggled) {
    final Map<String, Map<String, String>> messages = {
      'pleaseSelectDistrict': {
        'en': 'Please select a district',
        'local': 'कृपया जिल्हा निवडा',
      },
      'pleaseSelectCourt': {
        'en': 'Please select a court',
        'local': 'कृपया न्यायालय निवडा',
      },
      'pleaseEnterPartyNames': {
        'en': 'Please enter party name',
        'local': 'कृपया पक्षकारांचे नाव प्रविष्ट करा',
      },
      'pleaseEnterCaseNo': {
        'en': 'Please enter Case no',
        'local': 'कृपया प्रकरण क्रमांक प्रविष्ट करा',
      },
      'dateRequired': {'en': 'Date is required', 'local': 'दिनांक आवश्यक आहे'},
      'invalidDateFormat': {
        'en': 'Enter date in dd-mm-yyyy format',
        'local': 'दिनांक दिनांक-महिना-वर्ष स्वरूपात प्रविष्ट करा',
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
