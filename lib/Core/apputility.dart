import 'package:flutter/services.dart';

class AppUtility {
  static String login_id = "";
  static String isloginfirst = "";
  static String fullName = "";
  static String mobileNumber = "";
  static String email = "";
  static String gender = "";
  static String address = "";
  static String state_id = "";
  static String state_name = "";
  static String district_id = "";
  static String district_name = "";
  static String dayStatus = "";
  static String profileimage = "";
  static String image_path = "";
  static const platform = MethodChannel("quickensolcrm");
  static String device_os_version = "";
  static String device_id = "";
  static String device_manufacture = "";
  static String device_modal = "";
  static String taget_sdk = "";
  static String app_current_version = "";
  static String push_token = "";
  static String storage_permission = "0";
  static String notification_permission = "0";
  static String camera_permission = "0";
  static String location_always_permission = "0";
}
