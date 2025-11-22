class LocalizedStrings {
  static String getString(String description, bool isToggled) {
    final Map<String, Map<String, String>> descriptionTranslations = {
      'selectServices': {
        'en': 'list  of  services',
        'local': 'सेवांची यादी', // previously Hindi
      },
      'note': {
        'en':
            'Note : Our document drafting service is a professional offering provided by our in-house, highly qualified advocates. We prepare a variety of legal documents, including Sale Deeds, Wills, Gift Deeds, Mortgage Deeds, Leave and License Agreements, Lease Deeds, Partition Deeds, and other required documents, out of which some can be registered at any SRO office.',
        'local':
            'टीप: आमची दस्तऐवज तयार करण्याची सेवा ही आमच्या अंतर्गत अत्यंत पात्र वकिलांकडून दिली जाणारी व्यावसायिक सेवा आहे. आम्ही विक्री खत, वसीयत, दानपत्र, गहाणखत, सुट्टी आणि परवाना करार, भाडेपट्टी, फेरविभाग खत आणि इतर आवश्यक कायदेशीर दस्तऐवज तयार करतो, त्यापैकी काही कोणत्याही SRO कार्यालयात नोंदणी करता येऊ शकतात.',
      },
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'local': 'कृपया तुमची माहिती भरा',
      },
      'district': {'en': 'District', 'local': 'जिल्हा'},
      'taluka': {'en': 'Taluka/Tahshil', 'local': 'तालुका/तहसील'},
      'village': {'en': 'Village/ Mouza', 'local': 'गाव/मौजे'},
      'fieldSurveyNo': {
        'en': 'Field Survey No./ CTS No',
        'local': 'फील्ड सर्वे नंबर / CTS नंबर',
      },
      'byName': {'en': 'By Name', 'local': 'नावाने'},
      'byNameHint': {
        'en': '(In case survey no. is not known)',
        'local': '(सर्वे नंबर माहित नसल्यास)',
      },
      'mutationNo': {'en': 'Mutation No./Ferfar No', 'local': 'फेरफार क्रमांक'},
      'mutationNoHint': {'en': '', 'local': '(जर उपलब्ध असेल तर)'},
      'byKhataNo': {'en': 'By Khata No.', 'local': 'खाता क्रमांकाने'},
      'byKhataNoHint': {'en': '(If available)', 'local': '(जर उपलब्ध असेल तर)'},
      'next': {'en': 'Submit', 'local': 'सबमिट करा'},
      'viewSample': {'en': 'View Sample', 'local': 'नमुना पहा'},
      'bookCall': {'en': 'Book Appointment', 'local': 'अपॉइंटमेंट बुक करा'},
      'chatWithUs': {'en': 'Chat with Us', 'local': 'आमच्याशी चॅट करा'},
      'additional benefits': {
        'en': 'Comprehensive package with additional benefits',
        'local': 'अतिरिक्त फायद्यांसह संपूर्ण पॅकेज',
      },
      'selectLanguage': {'en': 'Select Language', 'local': 'भाषा निवडा'},
      'pleaseSelectLanguage': {
        'en': 'Please select a language',
        'local': 'कृपया भाषा निवडा',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return descriptionTranslations[description]?[language] ?? description;
  }

  static String getTag(String tag, bool isToggled) {
    final Map<String, Map<String, String>> tagTranslations = {
      'doc2': {'en': 'doc2', 'local': 'दस्तऐवज २'},
      'Aadhar Card': {'en': 'Aadhar Card', 'local': 'आधार कार्ड'},
      'PAN Card': {'en': 'PAN Card', 'local': 'पॅन कार्ड'},
      'Property Documents': {
        'en': 'Property Documents',
        'local': 'मालमत्ता दस्तऐवज',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return tagTranslations[tag]?[language] ?? tag;
  }

  static String getServiceName(String servicenames, bool isToggled) {
    final Map<String, Map<String, String>> serviceTranslations = {
      'Adhikar Abhilekh': {'en': 'Adhikar Abhilekh', 'local': 'अधिकार अभिलेख'},
      'Legal Drafts': {'en': 'Legal Drafts', 'local': 'कायदेशीर मसुदे'},
      'CERSAI Reports': {'en': 'CERSAI Reports', 'local': 'सर्साई अहवाल'},
      'Old 8A Extract': {'en': 'Old 8A Extract', 'local': 'जुना ८अ अर्क'},
      'Bhu Naksha Map': {'en': 'Bhu Naksha Map', 'local': 'भू - नकाशा'},
      'Index II Search': {'en': 'Index II Search', 'local': 'अनुक्रमणिका II'},
      'Digitally Signed 8A Extract': {
        'en': 'Digitally Signed 8A Extract',
        'local': 'डिजिटली स्वाक्षरी केलेले ८अ अर्क',
      },
      'Digitally Signed E-Mutation Extract': {
        'en': 'Digitally Signed E-Mutation Extract',
        'local': 'डिजिटली स्वाक्षरीकृत ई-म्युटेशन अर्क',
      },
      'Digitally Signed 7/12 EXTRACT': {
        'en': 'Digitally Signed 7/12 EXTRACT',
        'local': 'डिजिटली स्वाक्षरी केलेले ७/१२ उतारा',
      },
    };
    final language = isToggled ? 'local' : 'en';
    return serviceTranslations[servicenames.trim()]?[language] ??
        servicenames.trim();
  }
}

// lib/language/property_card_strings.dart
class PropertyCardStrings {
  // English Strings
  static const String pleaseEnterYourDetailsEn = 'Please Enter Your Details';
  static const String districtEn = 'Select District *';
  static const String talukaEn = 'Taluka/Tahshil';
  static const String villageEn = 'Village *';
  static const String nextEn = 'Submit';
  static const String noteEn =
      'Note: After payment document can be downloaded from order section only once which you can share.';
  static const String regionEn = 'Region';
  static const String officeEn = 'Select Office *';
  static const String ctsNoEn = 'CTS No.';

  // Marathi Strings
  static const String pleaseEnterYourDetailsMr =
      'कृपया आपला तपशील प्रविष्ट करा';
  static const String districtMr = 'जिल्हा *';
  static const String talukaMr = 'तालुका';
  static const String villageMr = 'गाव *';
  static const String nextMr = 'पुढे';
  static const String noteMr =
      'टीप: पेमेंट केल्यानंतर दस्तऐवज केवळ एकदाच ऑर्डर विभागातून डाउनलोड केला जाऊ शकतो, जो आपण शेअर करू शकता.';
  static const String regionMr = 'प्रदेश';
  static const String officeMr = 'कार्यालय *';
  static const String ctsNoMr = 'सीटीएस क्रमांक प्रविष्ट करा';

  // Method to get string based on toggle state
  static String getString(String key, bool isToggled) {
    switch (key) {
      case 'pleaseEnterYourDetails':
        return isToggled ? pleaseEnterYourDetailsMr : pleaseEnterYourDetailsEn;
      case 'district':
        return isToggled ? districtMr : districtEn;
      case 'taluka':
        return isToggled ? talukaMr : talukaEn;
      case 'village':
        return isToggled ? villageMr : villageEn;
      case 'next':
        return isToggled ? nextMr : nextEn;
      case 'note':
        return isToggled ? noteMr : noteEn;
      case 'region':
        return isToggled ? regionMr : regionEn;
      case 'office':
        return isToggled ? officeMr : officeEn;
      case 'ctsNo':
        return isToggled ? ctsNoMr : ctsNoEn;
      default:
        return '';
    }
  }
}

// lib/language/index_search_strings.dart
class IndexSearchStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'local': 'कृपया आपला तपशील प्रविष्ट करा',
      },
      'district': {'en': 'District', 'local': 'जिल्हा'},
      'selectSROOffice': {
        'en': 'Select SRO Office',
        'local': 'एसआरओ कार्यालय निवडा',
      },
      'selectVillage': {
        'en': 'Select Village/Town/City',
        'local': 'गाव/नगर/शहर निवडा',
      },
      'selectYear': {'en': 'Year', 'local': 'वर्ष निवडा'},
      'ctsNo': {
        'en': 'Enter CTS No./FS No./Plot No',
        'local': 'सीटीएस क्रमांक/एफएस क्रमांक/प्लॉट क्रमांक प्रविष्ट करा',
      },
      'byName': {'en': 'By Name', 'local': 'नावाने'},
      'byNameHint': {
        'en': '(In Case Survey No. Is Not Known)',
        'local': '(जर सर्व्हे क्रमांक माहित नसेल तर)',
      },
      'next': {'en': 'Submit', 'local': 'पुढे'},
      'note': {
        'en':
            'Note: After payment document can be downloaded from\norder section only once which you can share.',
        'local':
            'टीप: पेमेंट केल्यानंतर दस्तऐवज\nऑर्डर विभागातून फक्त एकदा डाउनलोड करता येईल, जे आपण शेअर करू शकता.',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ??
        key; // Fallback to key if string not found
  }
}

// lib/language/rera_certificate_strings.dart
class ReraCertificateStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'local': 'कृपया आपला तपशील प्रविष्ट करा',
      },
      'projectName': {'en': 'Project Name', 'local': 'प्रकल्पाचे नाव'},
      'builderName': {
        'en': 'Builder/Promoter Name',
        'local': 'बांधकाम व्यावसायिक/प्रवर्तकाचे नाव',
      },
      'pincode': {'en': 'Pin Code', 'local': 'पिनकोड'},
      'city': {'en': 'City', 'local': 'शहर'},
      'next': {'en': 'Submit', 'local': 'पुढे'},
      'note': {
        'en':
            'Note: After payment document can be downloaded from\norder section only once which you can share.',
        'local':
            'टीप: पेमेंट केल्यानंतर दस्तऐवज\nऑर्डर विभागातून फक्त एकदा डाउनलोड करता येईल, जे आपण शेअर करू शकता.',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ??
        key; // Fallback to key if string not found
  }
}

// lib/language/mortgage_reports_strings.dart
class MortgageReportsStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'local': 'कृपया आपला तपशील प्रविष्ट करा',
      },
      'district': {'en': 'District', 'local': 'जिल्हा'},
      'taluka': {'en': 'Taluka/Tahsil', 'local': 'तालुका/तहसील'},
      'village': {'en': 'Village/Mauza', 'local': 'गाव/मौजा'},
      'ctsNo': {
        'en': 'Enter CTS No./FS No./Plot No.',
        'local': 'सीटीएस क्रमांक/एफएस क्रमांक/प्लॉट क्रमांक प्रविष्ट करा',
      },
      'next': {'en': 'Submit', 'local': 'पुढे'},
      'note': {
        'en':
            'Note: After payment document can be downloaded from\norder section only once which you can share.',
        'local':
            'टीप: पेमेंट केल्यानंतर दस्तऐवज\nऑर्डर विभागातून फक्त एकदा डाउनलोड करता येईल, जे आपण शेअर करू शकता.',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ??
        key; // Fallback to key if string not found
  }
}

class RegisteredDocumentStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'local': 'कृपया आपला तपशील प्रविष्ट करा',
      },
      'district': {'en': 'District', 'local': 'जिल्हा'},
      'taluka': {'en': 'Taluka/Tahsil', 'local': 'तालुका/तहसील'},
      'village': {'en': 'Village/Mauza', 'local': 'गाव/मौजा'},
      'ctsNo': {
        'en': 'CTS No./FS No./Plot No',
        'local': 'सीटीएस क्रमांक/एफएस क्रमांक/प्लॉट क्रमांक प्रविष्ट करा',
      },
      'byName': {'en': 'Name', 'local': 'नाव'},
      'byNameHint': {'en': '', 'local': ''},
      'typeOfDocument': {
        'en': 'Type Of Document',
        'local': 'दस्तऐवजाचा प्रकार',
      },
      'next': {'en': 'Submit', 'local': 'पुढे'},
      'note': {
        'en':
            'Note : A registered title deed is the official legal document that proves ownership of a property. It is recorded with the local land registry or sub-registrar’s office after a property transaction. A registered title deed is the official legal document that proves ownership of a property. It is recorded with the local land registry or sub-registrar’s office after a property transaction. If lost you can download from BHULEX without any need to visit any office.',
        'local':
            'नोट: रजिस्टर्ड टाइटल डीड एक आधिकारिक कानूनी दस्तावेज़ होता है जो संपत्ति के स्वामित्व को प्रमाणित करता है। यह स्थानीय भूमि रजिस्ट्री या सब-रजिस्ट्रार कार्यालय में संपत्ति लेन-देन के बाद दर्ज किया जाता है। यदि यह दस्तावेज़ खो जाता है, तो आप इसे BHULEX से डाउनलोड कर सकते हैं, इसके लिए किसी कार्यालय में जाने की आवश्यकता नहीं है।',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ??
        key; // Fallback to key if string not found
  }
}

// lib/language/investigation_strings.dart
class InvestigationStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'local': 'कृपया आपला तपशील प्रविष्ट करा',
      },
      'district': {'en': 'District', 'local': 'जिल्हा'},
      'taluka': {'en': 'Taluka/Tahsil', 'local': 'तालुका/तहसील'},
      'village': {'en': 'Village/Mauza', 'local': 'गाव/मौजा'},
      'ctsNo': {
        'en': 'CTS No./FS No./Plot No',
        'local': 'सीटीएस क्रमांक/एफएस क्रमांक/प्लॉट क्रमांक निवडा',
      },
      'byName': {'en': 'Name Of owner/ Name Of Requester', 'local': 'आपले नाव'},
      // 'byNameHint': {
      //   'en': '(In Case Survey No. Is Not Known)',
      //   'local': '(जर सर्व्हे क्रमांक माहित नसेल तर)',
      // },
      'next': {'en': 'Submit', 'local': 'पुढे'},
      'description': {
        'en':
            'Our document drafting service is a professional offering provided by our in-house, highly qualified advocates. We prepare a variety of legal documents, including Sale Deeds, Wills, Gift Deeds, Mortgage Deeds, Leave and Licence Agreements, Lease Deeds, Partition Deeds, and other required documents, all of which can be registered at any SRO office.',
        'local':
            'आमची दस्तऐवज मसुदा सेवा ही आमच्या इन-हाउस, उच्च पात्र वकिलांद्वारे प्रदान केलेली व्यावसायिक सेवा आहे. आम्ही विक्री करार, मृत्युपत्र, भेटपत्र, गहाणखत, परवाना आणि करार सोडणे, भाडेपट्टा करार, विभाजन करार आणि इतर आवश्यक दस्तऐवज तयार करतो, जे सर्व कोणत्याही SRO कार्यालयात नोंदणीकृत केले जाऊ शकतात.',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ??
        key; // Fallback to key if string not found
  }
}

// lib/language/legaldrafts_strings.dart
class LegaldraftsStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'local': 'कृपया आपला तपशील प्रविष्ट करा',
      },
      'district': {'en': 'District', 'local': 'जिल्हा'},
      'taluka': {'en': 'Taluka/Tahsil', 'local': 'तालुका/तहसील'},
      'village': {'en': 'Village/Mauza', 'local': 'गाव/मौजा'},
      'ctsNo': {
        'en': 'Please enter CTS No./FS No./Plot No',
        'local': 'सीटीएस क्रमांक/एफएस क्रमांक/प्लॉट क्रमांक निवडा',
      },
      'partyNames': {'en': 'Party Name', 'local': 'पक्षकारांची नावे'},
      'shortBrief': {
        'en': 'Short Description Of Draft',
        'local': 'आवश्यक W मसुद्याचे संक्षिप्त वर्णन',
      },
      'next': {'en': 'Next', 'local': 'पुढे'},
      'description': {
        'en':
            'Our document drafting service is a professional offering provided by our in-house, highly qualified advocates. We prepare a variety of legal documents, including Sale Deeds, Wills, Gift Deeds, Mortgage Deeds, Leave and Licence Agreements, Lease Deeds, Partition Deeds, and other required documents, all of which can be registered at any SRO office.',
        'local':
            'आमची दस्तऐवज मसुदा सेवा ही आमच्या इन-हाउस, उच्च पात्र वकिलांद्वारे प्रदान केलेली व्यावसायिक सेवा आहे. आम्ही विक्री करार, मृत्युपत्र, भेटपत्र, गहाणखत, परवाना आणि करार सोडणे, भाडेपट्टा करार, विभाजन करार आणि इतर आवश्यक दस्तऐवज तयार करतो, जे सर्व कोणत्याही SRO कार्यालयात नोंदणीकृत केले जाऊ शकतात.',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ??
        key; // Fallback to key if string not found
  }
}

// Localized strings for property valuation
class PropertyStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'description': {
        'en':
            '​Note : The e-Valuation system by the Department of Registration & Stamps, Government of Maharashtra, is an online platform designed to determine the market value of properties across the state. This system aids in calculating the appropriate stamp duty and registration fees for property transactions and its valuation.​',
        'hi':
            'नोट: महाराष्ट्र शासन के पंजीयन और मुद्रांक विभाग द्वारा विकसित ई-मूल्यांकन प्रणाली एक ऑनलाइन मंच है, जिसका उद्देश्य राज्य भर में संपत्तियों का बाजार मूल्य निर्धारित करना है। यह प्रणाली संपत्ति लेन-देन के लिए उपयुक्त मुद्रांक शुल्क और पंजीकरण शुल्क की गणना करने में सहायक है।',
      },
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'hi': 'कृपया अपनी संपत्ति का विवरण दर्ज करें',
      },
      'propertyType': {
        'en': 'Select Property Type',
        'hi': 'संपत्ति का प्रकार चुनें',
      },
      'natureOfProperty': {
        'en': 'Select Nature of Property',
        'hi': 'संपत्ति की प्रकृति चुनें',
      },
      'district': {'en': 'District', 'hi': 'जिला चुनें'},
      'taluka': {'en': 'Taluka', 'hi': 'तहसील चुनें'},
      'village': {'en': 'Village', 'hi': 'गाँव चुनें'},
      'cornerPlot': {'en': 'Corner Plot', 'hi': 'कोने का प्लॉट'},
      'surveyNumber': {'en': 'Survey No.', 'hi': 'सर्वे नंबर'},
      'next': {'en': 'Submit', 'hi': 'आगे'},
      'viewSample': {'en': 'View Sample', 'hi': 'नमूना देखें'},
      'chatWithUs': {'en': 'Chat with Us', 'hi': 'हमसे चैट करें'},
    };
    return isToggled ? strings[key]!['hi']! : strings[key]!['en']!;
  }
}

// Localization class for AreaConverterPage
class AreaConverterStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'description': {
        'en':
            'Note: Aapli Chawadi is a digital platform developed by the Government of Maharashtra to promote transparency and efficiency in local governance. It serves as a communication bridge between Gram Panchayats and citizens. The portal allows villagers to access important documents, notices, and meeting information online. It enhances public participation by providing real-time updates on Gram Sabha decisions and development works. Overall, Aapli Chawadi strengthens e-governance at the grassroots level. This section will provide information about any third-party rights created on a property.',
        'hi':
            'नोट: आपली चावडी महाराष्ट्र सरकार द्वारा विकसित एक डिजिटल प्लेटफॉर्म है, जिसका उद्देश्य स्थानीय शासन में पारदर्शिता और दक्षता को बढ़ावा देना है। यह ग्राम पंचायतों और नागरिकों के बीच संवाद का माध्यम है। इस पोर्टल के ज़रिए ग्रामीण महत्वपूर्ण दस्तावेज़, सूचनाएं और बैठकों की जानकारी ऑनलाइन प्राप्त कर सकते हैं। यह ग्राम सभा के निर्णयों और विकास कार्यों की रियल-टाइम अपडेट प्रदान कर जनभागीदारी को बढ़ाता है। कुल मिलाकर, आपली चावडी जमीनी स्तर पर ई-गवर्नेंस को मजबूत करती है। इस अनुभाग में किसी भी संपत्ति पर बनाए गए तृतीय पक्ष अधिकारों की जानकारी उपलब्ध कराई जाएगी।',
      },
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'hi': 'कृपया अपनी संपत्ति का विवरण दर्ज करें',
      },
      'stateHint': {'en': 'Select State', 'hi': 'राज्य चुनें'},
      'stateError': {'en': 'Please select a state', 'hi': 'कृपया राज्य निवडा'},
      'stateSearchHint': {'en': 'Search State...', 'hi': 'राज्य शोधा...'},
      'inputHint': {
        'en': 'Enter No. of Units',
        'hi': 'रूपांतरण के लिए मान दर्ज करें',
      },
      'unitHint': {'en': 'Unit', 'hi': 'एकक'},
      'swapTooltip': {'en': 'Swap Units', 'hi': 'एकके बदला'},
      'resultPlaceholder': {
        'en': 'Enter a value to convert',
        'hi': 'रूपांतरासाठी मूल्य प्रविष्ट करा',
      },
      'submit': {'en': 'Submit', 'hi': 'जमा करें'},
      'successMessage': {
        'en': 'Form submitted successfully!',
        'hi': 'फॉर्म यशस्वीरीत्या सबमिट केला!',
      },
      'errorMessage': {
        'en': 'Please fix form errors.',
        'hi': 'कृपया फॉर्ममधील त्रुटी दुरुस्त करा.',
      },
    };
    final language = isToggled ? 'hi' : 'en';
    return strings[key]?[language] ?? key;
  }
}

class Aaplichawli {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'description': {
        'en':
            'Note : Aapli Chawadi is a digital platform developed by the Government of Maharashtra to promote transparency and efficiency in local governance. It serves as a communication bridge between Gram Panchayats and citizens. The portal allows villagers to access important documents, notices, and meeting information online. It enhances public participation by providing real-time updates on Gram Sabha decisions and development works. Overall, Aapli Chawadi strengthens e-governance at the grassroots level. Here will provide information of third party rights created on any property.​',
        'hi':
            'नोट: आपली चावडी महाराष्ट्र सरकार द्वारा विकसित एक डिजिटल प्लेटफॉर्म है, जिसका उद्देश्य स्थानीय शासन में पारदर्शिता और दक्षता को बढ़ावा देना है। यह ग्राम पंचायतों और नागरिकों के बीच संवाद का सेतु बनता है। इस पोर्टल के माध्यम से ग्रामीण महत्वपूर्ण दस्तावेज़, सूचनाएं और बैठक संबंधी जानकारी ऑनलाइन प्राप्त कर सकते हैं। यह ग्राम सभा के निर्णयों और विकास कार्यों की वास्तविक समय में जानकारी देकर जनभागीदारी को बढ़ाता है। कुल मिलाकर, आपली चावडी जमीनी स्तर पर ई-शासन को सशक्त बनाती है। यहाँ किसी भी संपत्ति पर बनाए गए तृतीय पक्ष अधिकारों की जानकारी प्रदान की जाएगी।',
      },
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'hi': 'कृपया अपनी संपत्ति का विवरण दर्ज करें',
      },
      'propertyType': {
        'en': 'Select Property Type',
        'hi': 'संपत्ति का प्रकार चुनें',
      },
      'natureOfProperty': {
        'en': 'Select Nature of Property',
        'hi': 'संपत्ति की प्रकृति चुनें',
      },
      'district': {'en': 'District', 'hi': 'जिला चुनें'},
      'taluka': {'en': 'Taluka', 'hi': 'तहसील चुनें'},
      'village': {'en': 'Village', 'hi': 'गाँव चुनें'},
      'cornerPlot': {'en': 'Corner Plot', 'hi': 'कोने का प्लॉट'},
      'surveyNumber': {'en': 'Survey No.', 'hi': 'सर्वे नंबर'},
      'next': {'en': 'Submit', 'hi': 'आगे'},
      'viewSample': {'en': 'View Sample', 'hi': 'नमूना देखें'},
      'office': {'en': 'Office', 'hi': 'कार्यालय चुनें'},
      'chatWithUs': {'en': 'Chat with Us', 'hi': 'हमसे चैट करें'},
      'state': {'en': 'State', 'hi': 'राज्य चुनें'}, // Added state key
      'submit': {'en': 'Submit', 'hi': 'जमा करें'}, // Added submit key
    };
    return isToggled ? strings[key]!['hi']! : strings[key]!['en']!;
  }
}

class CourtcasesStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'local': 'कृपया आपला तपशील प्रविष्ट करा',
      },
      'district': {'en': 'District', 'local': 'जिल्हा'},
      'selectCourt': {'en': 'Select Court', 'local': 'न्यायालय निवडा'},
      'partyNames': {'en': 'Party Name', 'local': 'पक्षकारांची नावे'},
      'caseNo': {'en': 'Case No.', 'local': 'प्रकरण क्रमांक'},
      'dateFormatHint': {'en': 'DD-MM-YYYY', 'local': 'दिनांक-महिना-वर्ष'},
      'next': {'en': 'Submit', 'local': 'पुढे'},
      'description': {
        'en':
            "Note: Here, you can search for litigations between parties or if you know the case number. We provide comprehensive information regarding cases pending or disposed of in the Hon'ble Supreme Court, Hon'ble Bombay High Court and its benches, as well as lower courts.",
        'local':
            "नोट: यहां आप पक्षकारों के बीच मुकदमे या यदि आपको मामला संख्या ज्ञात हो, तो उसकी जानकारी खोज सकते हैं। हम माननीय सर्वोच्च न्यायालय, माननीय बॉम्बे उच्च न्यायालय और उसकी पीठों तथा अधीनस्थ न्यायालयों में लंबित या निपटाए गए मामलों की संपूर्ण जानकारी प्रदान करते हैं।",
      },
      'caseType': {'en': 'Case Type', 'local': 'प्रकरणाचा प्रकार'},
      'caseNumber': {'en': 'Case Number', 'local': 'प्रकरण क्रमांक'},
      'caseYear': {'en': 'Case Year', 'local': 'प्रकरण वर्ष'},
      'ifNotKnown': {'en': 'if not known then', 'local': 'जर माहित नसेल'},
      'partyName': {'en': 'Party Name', 'local': 'पक्षकाराचे नाव'},
      'partyYear': {'en': 'Party Year', 'local': 'पक्षकार वर्ष'},
      'selectBench': {'en': 'Select Bench', 'local': 'बेंच निवडा'},
      'department': {'en': 'Department', 'local': 'विभाग'},
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ??
        key; // Fallback to key if string not found
  }
}

// lib/language/adhikar_abhilekh_strings.dart
class AdhikarAbhilekhStrings {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      'pleaseEnterYourDetails': {
        'en': 'Please Enter Your Details',
        'local': 'कृपया आपला तपशील प्रविष्ट करा',
      },
      'district': {'en': 'District', 'local': 'जिल्हा'},
      'taluka': {'en': 'Taluka/Tahsil', 'local': 'तालुका/तहसील'},
      'village': {'en': 'Village/Mauza', 'local': 'गाव/मौजा'},
      'fieldSurveyNo': {
        'en': 'Field Survey No',
        'local': 'शेत सर्वेक्षण क्रमांक',
      },
      'byName': {'en': 'By Name', 'local': 'नावाने'},
      'inCaseSurveyNotKnown': {
        'en': '(In Case Survey No. Is Not known)',
        'local': '(सर्वेक्षण क्रमांक माहित नसल्यास)',
      },
      'next': {'en': 'Next', 'local': 'पुढे'},
      'note': {
        'en':
            'Note: Legal consultation clears the haze, guiding you through the complex legal maze. Protect your rights, avoid the fall — smart advice can save it all. Need legal advice? We\'re here to guide, with trusted experts by your side. From contracts to court, we’ve got your back. Book your consultation — stay on track.',
        'local':
            'नोट: पेमेंट के बाद दस्तावेज़ को ऑर्डर सेक्शन से केवल एक बार डाउनलोड किया जा सकता है, जिसे आप शेयर कर सकते हैं।',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ??
        key; // Fallback to key if string not found
  }
}

// lib/language/localization_strings_instant.dart
class LocalizationStringsinstant {
  static String getString(String key, bool isToggled) {
    final Map<String, Map<String, String>> strings = {
      // Bottom Navigation Strings
      'home': {'en': 'Home', 'local': 'होम'},
      'customerCare': {'en': 'Customer Care', 'local': 'ग्राहक सेवा'},
      'myOrder': {'en': 'My Order', 'local': 'माझी ऑर्डर'},
      'myProfile': {'en': 'My Profile', 'local': 'माझे प्रोफाइल'},
      'packages': {'en': 'Packages', 'local': 'पॅकेजेस'},

      // Delivery Time Strings
      'instant': {'en': 'Instant', 'local': 'तत्काल'},
      'within12Hours': {'en': 'Within 12 Hours', 'local': '12 तासांच्या आत'},
      'within24Hours': {'en': 'Within 24 Hours', 'local': '24 तासांच्या आत'},
    };

    final language = isToggled ? 'local' : 'en';
    return strings[key]?[language] ?? key; // Fallback to key if not found
  }
}

// lib/language/order_strings.dart
// ignore: camel_case_types
class localizationOrderStrings {
  static String getServiceName(String serviceName, bool isToggled) {
    final Map<String, Map<String, String>> serviceNames = {
      'Property Search': {'en': 'Property Search', 'local': 'मालमत्ता शोध'},
      'Rera Certificate': {
        'en': 'Rera Certificate',
        'local': 'रेरा प्रमाणपत्र',
      },
      'Land Records': {'en': 'Land Records', 'local': 'जमीन नोंदी'},
    };

    final language = isToggled ? 'local' : 'en';
    return serviceNames[serviceName]?[language] ?? serviceName;
  }
}

// lib/language/order_strings.dart
class localizationOrderdetailsStrings {
  static String getServiceName(String serviceName, bool isToggled) {
    final Map<String, Map<String, String>> serviceTranslations = {
      'Quick Services': {'en': 'Quick Services', 'local': 'त्वरित सेवा'},
      'Old Records of Rights': {
        'en': 'Old Records of Rights',
        'local': 'जुने हक्कांचे रेकॉर्ड',
      },
      'Legal Advisory': {'en': 'Legal Advisory', 'local': 'कायदेशीर सल्ला'},
      'Investigative Reports': {
        'en': 'Investigative Reports',
        'local': 'तपास अहवाल',
      },
      'E-Applications': {'en': 'E-Applications', 'local': 'ई-अर्ज'},
    };

    final language = isToggled ? 'local' : 'en';
    return serviceTranslations[serviceName]?[language] ?? serviceName;
  }
}

// lib/language/package_strings.dart
class PackageStrings {
  static String getPackageName(String packageName, bool isToggled) {
    final Map<String, Map<String, String>> packageTranslations = {
      'package1': {'en': 'package1', 'local': 'पॅकेज १'},
      'Basic Package': {'en': 'Basic Package', 'local': 'मूलभूत पॅकेज'},
      'Premium Package': {'en': 'Premium Package', 'local': 'प्रिमियम पॅकेज'},
    };

    final language = isToggled ? 'local' : 'en';
    return packageTranslations[packageName]?[language] ?? packageName;
  }

  static String getShortDescription(String description, bool isToggled) {
    final Map<String, Map<String, String>> descriptionTranslations = {
      'package': {'en': 'package', 'local': 'पॅकेज'},
      'Includes basic services': {
        'en': 'Includes basic services',
        'local': 'मूलभूत सेवा समाविष्ट करते',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return descriptionTranslations[description]?[language] ?? description;
  }

  static String getTag(String tag, bool isToggled) {
    final Map<String, Map<String, String>> tagTranslations = {
      'doc2': {'en': 'doc2', 'local': 'दस्तऐवज २'},
      'Aadhar Card': {'en': 'Aadhar Card', 'local': 'आधार कार्ड'},
      'PAN Card': {'en': 'PAN Card', 'local': 'पॅन कार्ड'},
      'Property Documents': {
        'en': 'Property Documents',
        'local': 'मालमत्ता दस्तऐवज',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return tagTranslations[tag]?[language] ?? tag;
  }

  static String getServiceName(String servicenames, bool isToggled) {
    final Map<String, Map<String, String>> serviceTranslations = {
      'Adhikar Abhilekh': {'en': 'Adhikar Abhilekh', 'local': 'अधिकार अभिलेख'},
      'Legal Drafts': {'en': 'Legal Drafts', 'local': 'कायदेशीर मसुदे'},
      'CERSAI Reports': {'en': 'CERSAI Reports', 'local': 'सर्साई अहवाल'},
      'Old 8A Extract': {'en': 'Old 8A Extract', 'local': 'जुना ८अ अर्क'},
      'Bhu Naksha Map': {'en': 'Bhu Naksha Map', 'local': 'भू - नकाशा'},
      'Index II Search': {'en': 'Index II Search', 'local': 'अनुक्रमणिका II'},
      'Digitally Signed 8A Extract': {
        'en': 'Digitally Signed 8A Extract',
        'local': 'डिजिटली स्वाक्षरी केलेले ८अ अर्क',
      },
      'Digitally Signed E-Mutation Extract': {
        'en': 'Digitally Signed E-Mutation Extract',
        'local': 'डिजिटली स्वाक्षरीकृत ई-म्युटेशन अर्क',
      },
      'Digitally Signed 7/12 EXTRACT': {
        'en': 'Digitally Signed 7/12 EXTRACT',
        'local': 'डिजिटली स्वाक्षरी केलेले ७/१२ उतारा',
      },
    };
    final language = isToggled ? 'local' : 'en';
    return serviceTranslations[servicenames.trim()]?[language] ??
        servicenames.trim();
  }
}

// lib/language/package_strings.dart
class allPackageStrings {
  static String getPackageName(String packageName, bool isToggled) {
    final Map<String, Map<String, String>> packageTranslations = {
      'package1': {'en': 'package1', 'local': 'पॅकेज १'},
      'Basic Package': {'en': 'Basic Package', 'local': 'मूलभूत पॅकेज'},
      'Premium Package': {'en': 'Premium Package', 'local': 'प्रिमियम पॅकेज'},
    };

    final language = isToggled ? 'local' : 'en';
    return packageTranslations[packageName]?[language] ?? packageName;
  }

  static String getShortDescription(String description, bool isToggled) {
    final Map<String, Map<String, String>> descriptionTranslations = {
      'package': {'en': 'package', 'local': 'पॅकेज'},
      'Includes basic services': {
        'en': 'Includes basic services',
        'local': 'मूलभूत सेवा समाविष्ट करते',
      },
      'Comprehensive package with additional benefits': {
        'en': 'Comprehensive package with additional benefits',
        'local': 'अतिरिक्त लाभांसह व्यापक पॅकेज',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return descriptionTranslations[description]?[language] ?? description;
  }

  static String getTag(String tag, bool isToggled) {
    final Map<String, Map<String, String>> tagTranslations = {
      'doc2': {'en': 'doc2', 'local': 'दस्तऐवज २'},
      'Aadhar Card': {'en': 'Aadhar Card', 'local': 'आधार कार्ड'},
      'PAN Card': {'en': 'PAN Card', 'local': 'पॅन कार्ड'},
      'Property Documents': {
        'en': 'Property Documents',
        'local': 'मालमत्ता दस्तऐवज',
      },
    };

    final language = isToggled ? 'local' : 'en';
    return tagTranslations[tag]?[language] ?? tag;
  }

  static String getServiceName(String servicenames, bool isToggled) {
    final Map<String, Map<String, String>> serviceTranslations = {
      'Adhikar Abhilekh': {'en': 'Adhikar Abhilekh', 'local': 'अधिकार अभिलेख'},
      'Legal Drafts': {'en': 'Legal Drafts', 'local': 'कायदेशीर मसुदे'},
      'CERSAI Reports': {'en': 'CERSAI Reports', 'local': 'सर्साई अहवाल'},
      'Old 8A Extract': {'en': 'Old 8A Extract', 'local': 'जुना ८अ अर्क'},
      'Bhu Naksha Map': {'en': 'Bhu Naksha Map', 'local': 'भू - नकाशा'},
      'Index II Search': {'en': 'Index II Search', 'local': 'अनुक्रमणिका II'},
      'Digitally Signed 8A Extract': {
        'en': 'Digitally Signed 8A Extract',
        'local': 'डिजिटली स्वाक्षरी केलेले ८अ अर्क',
      },
      'Digitally Signed E-Mutation Extract': {
        'en': 'Digitally Signed E-Mutation Extract',
        'local': 'डिजिटली स्वाक्षरीकृत ई-म्युटेशन अर्क',
      },
      'Digitally Signed 7/12 EXTRACT': {
        'en': 'Digitally Signed 7/12 EXTRACT',
        'local': 'डिजिटली स्वाक्षरी केलेले ७/१२ उतारा',
      },
    };
    final language = isToggled ? 'local' : 'en';
    return serviceTranslations[servicenames.trim()]?[language] ??
        servicenames.trim();
  }
}
