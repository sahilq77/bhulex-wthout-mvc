// lib/validations/validation_messages.dart
class ValidationMessagesrera {
  static String getMessage(String key, bool isToggled) {
    final Map<String, Map<String, String>> messages = {
      'pleaseEnterProjectName': {
        'en': 'Please enter project name',
        'local': 'कृपया प्रकल्पाचे नाव प्रविष्ट करा',
      },
      'pleaseEnterBuilderName': {
        'en': 'Please enter builder/promoter name',
        'local': 'कृपया बांधकाम व्यावसायिक/प्रवर्तकाचे नाव प्रविष्ट करा',
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
