class URLS {
  static String baseUrl = "https://seekhelp.in/bhulex/";
  //get_all_service_package
  String login_apiUrl = "${baseUrl}login_customer";
  int get_all_service_package = 8;
  String get_all_service_packageapiUrl = "${baseUrl}get_all_service_master";
  int get_all_package_orders = 73;
  String get_all_package_ordersapiUrl = "${baseUrl}get_all_package_orders";
  int get_all_package_master = 74;
  String get_all_package_masterapiUrl = "${baseUrl}get_all_package_master";

  String verify_otp_apiUrl = "${baseUrl}validate_otp";
  String update_customer_profile_apiUrl = "${baseUrl}update_customer_profile";
  String get_all_city_apiUrl = "${baseUrl}get_all_city";
  String get_all_state_apiUrl = "${baseUrl}get_all_state";
  String get_all_category_apiUrl = "${baseUrl}get_all_category";
  String get_all_services_apiUrl = "${baseUrl}get_all_services";
  String submit_enquiry_form_apiUrl = "${baseUrl}submit_enquiry_form";
  String get_group_of_form_apiUrl = "${baseUrl}get_group_of_form";
  String submit_quick_service_enquiry_form_apiUrl =
      "${baseUrl}submit_quick_service_enquiry_form";
  String get_all_packageUrl = "${baseUrl}get_all_package";
  int get_all_package = 5;
  String package_detailsUrl = "${baseUrl}package_details";
  int package_details = 6;
  String package_enquiry_formUrl = "${baseUrl}package_enquiry_form";
  int package_enquiry_form = 7;
  String get_all_ordersUrl = "${baseUrl}get_all_orders";
  int get_all_orders = 72;
  String order_detailsUrl = "${baseUrl}order_details";
  int order_details = 9;
  String download_fileUrl = "${baseUrl}download_file";
  int download_file = 10;
  String submit_old_record_enquiry_form_apiUrl =
      "${baseUrl}submit_old_record_enquiry_form";
  String submit_investigative_report_enquiry_form_apiUrl =
      "${baseUrl}submit_investigative_report_enquiry_form";
  String get_all_taluka_apiUrl = "${baseUrl}get_all_taluka";
  String get_all_village_apiUrl = "${baseUrl}get_all_village";
  String get_all_court_apiUrl = "${baseUrl}get_all_court";

  String submit_legal_advisory_enquiry_form_apiUrl =
      "${baseUrl}submit_legal_advisory_enquiry_form";
  String get_all_region_apiUrl = "${baseUrl}get_all_region";
  String get_all_sro_office_apiUrl = "${baseUrl}get_all_sro_office";
  String get_customer_profile_apiUrl = baseUrl + "get_customer_profile";
  String get_disclaimer_apiUrl = baseUrl + "get_disclaimer";
  String get_all_village_by_city_apiUrl = baseUrl + "get_all_village_by_city";
  String get_privacy_apiUrl = baseUrl + "get_privacy";
  String get_terms_apiUrl = baseUrl + "get_terms";
  String check_form_filled_statusapiurl = baseUrl + "check_form_filled_status";
}
