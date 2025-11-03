// class LocalizedStrings {
//   // English Strings
//   static const String pleaseSelectStateEn = 'Please select your state';
//   static const String quickServicesEn = 'Quick Services';
//   static const String oldRecordsEn = 'Old Records of Rights';
//   static const String legalAdvisoryEn = 'Legal Advisory';
//   static const String investigativeReportsEn = 'Investigative Reports';
//   static const String eApplicationsEn = 'E-Applications';
//   static const String instantEn = 'Instant';
//   static const String within12HoursEn = 'within 12 hours';
//   static const String within24HoursEn = 'within 24 hours';
//   static const String pleaseEnterYourDetailsEn = 'Please Enter Your Details';
//   static const String districtEn = 'District';
//   static const String talukaEn = 'Taluka/Tahashil';
//   static const String villageEn = 'Village/Mauza';
//   static const String fieldSurveyNoEn = 'Field Survey No';
//   static const String byNameEn = 'By Name';
//   static const String byNameHintEn = '(In Case Survey No. Is Not known)';
//   static const String nextEn = 'Next';
//   static const String noteEn =
//       'Note: After payment document can be downloaded from\norder section only once which you can share.';
//   static const List<String> statesEn = ['Maharashtra', 'Madhya Pradesh'];
//   static const List<String> labelsEn = [
//     'Digitally Signed 7/12 Extract',
//     'Digitally Signed 8A Extract',
//     'Digitally Signed E-Mutation Extract',
//     'Digitally Signed Property Card',
//     'Index-II Search',
//     'RERA Certificate',
//     'Bhu Naksha Map',
//     'CTS Map',
//   ];

  
//   // Method to get strings based on language toggle
  
// }

// class LocalizedStringpropertycard {
//   // English Strings (existing ones remain unchanged)
//   static const String regionEn = 'Region';
  
//   static const String officeEn = 'Office';
//   static const String ctsNoEn = 'CTS No';

//   // Marathi Strings (existing ones remain unchanged)
//   static const String regionMr = 'प्रदेश';
//   static const String officeMr = 'कार्यालय';
//   static const String ctsNoMr = 'CTS क्रमांक';

//   // Updated getString method (add new cases)
//   static String getString(String key, bool isToggled) {
//     switch (key) {
//       // Existing cases...
//       case 'region':
//         return isToggled ? regionMr : regionEn;
//       case 'office':
//         return isToggled ? officeMr : officeEn;
//       case 'ctsNo':
//         return isToggled ? ctsNoMr : ctsNoEn;
//       // Other existing cases...
//       default:
//         return '';
//     }
//   }
// }
