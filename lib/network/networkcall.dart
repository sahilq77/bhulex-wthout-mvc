//for response parse or handle
import 'dart:developer';

import 'package:bhulexapp/network/response/get_all_mypackage_api_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


import '../Core/apputility.dart';
import '../Core/errorLogger.dart';
import 'response/Generateorderdeleteapiresponse.dart';
import 'response/GetAllShotsPerHourHistoryDataApiResponse.dart';
import 'response/GetMoldMaterialTotalInStockProductionApiresponse.dart';

import 'response/Getallbatchlistapiresponse.dart';
import 'response/Getallclientsapiresponse.dart';
import 'response/Getallmachineapiresponse.dart';
import 'response/Getallshotsperhourdataapiresponse.dart';
import 'response/Getbatchcompleteapiresponse.dart';
import 'response/Getbatchcompletedlistapiresponse.dart';
import 'response/Getbatchdeleteapiresponse.dart';
import 'response/Getbatchholdapiresponse.dart';
import 'response/Getbatchjobcardprintapiresponse.dart';
import 'response/Getbatchstartapiresponse.dart';
import 'response/Getbatchstopapiresponse.dart';
import 'response/Getmachinestatusapiresponse.dart';
import 'response/Getmoldmaterialtotaloutwardproductionapiresponse.dart';
import 'response/Getpackingmaterialtotalinstockproductionapiresponse.dart';
import 'response/Getpackingmaterialtotaloutwardproductionapiresponse.dart';
import 'response/Getrawmaterialtotalinstockproductionapiresponse.dart';
import 'response/Getrawmaterialtotaloutwardproductionapiresponse.dart';
import 'response/Gettotalcompletedorderapiresponse.dart';
import 'response/Gettotalongoingorderapiresponse.dart';
import 'response/Gettotalpendingorderapiresponse.dart';
import 'response/Moldmaterialdispatchlistapiapiresponse.dart';
import 'response/QcDeleteApiResponse.dart';
import 'response/Qclistapiresponse.dart';
import 'response/Rawmaterialdispatchlistapiresponse.dart';
import 'response/Readystocklistresponse.dart';
import 'response/RecentGetMoldMaterialInStockProductionApiresponse.dart';
import 'response/RecentGetpackingmaterialinstockproductionapiresponse.dart';
import 'response/RecentGetrawmaterialinstockproductionapiresponse.dart';
import 'response/SetTempFinalDispatchApprovedApiResponse.dart';
import 'response/Setshotsperhourdataapiapiresponse.dart';
import 'response/Shotsperhourmachineproductapiresponse.dart';
import 'response/TempMaterialDispatchDeleteApiresponse.dart';
import 'response/TempMaterialDispatchPreviewApiUrlResponse.dart';
import 'response/Tempmaterialproductvehicleloadingapiresponse.dart';
import 'response/addemployeeresponse.dart';
import 'response/download_file_api_response.dart';
import 'response/finalmaterialdispatchlistapiresponse.dart';
import 'response/get_all_orders_api_response.dart';
import 'response/get_all_package_api_response.dart';
import 'response/get_all_service_package_api_response.dart';
import 'response/get_client_branch_api_response.dart';
import 'response/get_client_material_api_response.dart';
import 'response/get_contractor_list_api_response.dart';
import 'response/get_employee_all_notification_api_response.dart';
import 'response/get_machine_product_api_response.dart';
import 'response/get_products_api_response.dart';
import 'response/get_unique_tbl_app_shots_per_hour_api_response.dart';
import 'response/get_vehicle_loading_api_response.dart';
import 'response/get_vehicle_loading_history_api_response.dart';
import 'response/getemployeeattendancelistresponse.dart';
import 'response/getemployeelistresponse.dart';
import 'response/getgenerateorderdataresponse.dart';
import 'response/getshiftlistresponse.dart';
import 'response/markattendanceresponse.dart';
import 'response/monthattendanceresponse.dart';
import 'response/order_details_api_response.dart';
import 'response/package_details_api_response.dart';
import 'response/package_enquiry_form_api_response.dart';
import 'response/tempmaterialdispatchlistapiresponse.dart';
import 'response/userprofileresponse.dart';

class Networkcall {
  Future<List<Object?>?> postMethod(
    int requestCode,
    String url,
    String body,
    BuildContext context,
  ) async {
    final errorLogger = ErrorLogger();
    try {
      var response = await post(Uri.parse(url), body: body);

      var data = response.body;
      if (response.statusCode == 200) {
        String str = "[" + response.body + "]";
        log(
          "Request code: $requestCode \n URL: $url \nRequestBody: $body \nResponse:\n$str ",
        );

        switch (requestCode) {
          case 2:
            final getotp = tempmaterialdispatchlistapiresponseFromJson(str);
            return getotp;
          case 3:
            final getotp = finalmaterialdispatchlistapiresponseFromJson(str);
            return getotp;
          case 4:
            final getotp = moldmaterialdispatchlistapiapiresponseFromJson(str);
            return getotp;
          case 5:
            final getotp = getAllPackageApiResponseFromJson(str);
            return getotp;

          case 6:
            final getotp = packageDetailsApiResponseFromJson(str);
            return getotp;
          case 7:
            final getotp = packageEnquiryFormApiResponseFromJson(str);
            return getotp;
          case 8:
            final getotp = getAllServicePackageApiResponseFromJson(str);
            return getotp;
          case 9:
            final getotp = orderDetailsApiResponseFromJson(str);
            return getotp;
          case 10:
            final getotp = downloadFileApiResponseFromJson(str);
            return getotp;
          case 12:
            final getotp = getbatchholdapiresponseFromJson(str);
            return getotp;
          case 13:
            final getotp = getbatchstopapiresponseFromJson(str);
            return getotp;
          case 14:
            final getotp = getbatchcompleteapiresponseFromJson(str);
            return getotp;
          case 15:
            final getotp = getbatchjobcardprintapiresponseFromJson(str);
            return getotp;
          case 16:
            final getotp = getbatchcompletedlistapiresponseFromJson(str);
            return getotp;
          case 17:
            final getotp = getbatchdeleteapiresponseFromJson(str);
            return getotp;
          case 18:
            final getotp = tempmaterialproductvehicleloadingapiresponseFromJson(
              str,
            );
            return getotp;
          case 20:
            final shift = getshiftlistresponseFromJson(str);
            return shift;
          case 21:
            final addemployee = addemployeeresponseFromJson(str);
            return addemployee;
          case 22:
            final getemployee = getemployeelistresponseFromJson(str);
            return getemployee;
          case 23:
            final markattendance = markattendanceresponseFromJson(str);
            return markattendance;
          case 24:
            final monthattendance = monthattendanceresponseFromJson(str);
            return monthattendance;
          case 25:
            final employeelist = getemployeeattendancelistresponseFromJson(str);
            return employeelist;
          case 26:
            final userprofile = userprofileresponseFromJson(str);
            return userprofile;
          case 30:
            final userprofile = shotsperhourmachineproductapiresponseFromJson(
              str,
            );
            return userprofile;
          case 31:
            final userprofile = setshotsperhourdataapiapiresponseFromJson(str);
            return userprofile;
          case 32:
            final getotp = getallshotsperhourdataapiresponseFromJson(str);
            return getotp;
          case 38:
            final getreadystock = readystocklistresponseFromJson(str);
            return getreadystock;
          case 41:
            final deleteQc = qcDeleteApiResponseFromJson(str);
            return deleteQc;
          case 42:
            final getreadystock = gettotalongoingorderapiresponseFromJson(str);
            return getreadystock;
          case 44:
            final getreadystock = gettotalcompletedorderapiresponseFromJson(
              str,
            );
            return getreadystock;

          case 45:
            final getreadystock = getmachinestatusapiresponseFromJson(str);
            return getreadystock;
          case 46:
            final getreadystock =
                getrawmaterialtotalinstockproductionapiresponseFromJson(str);
            return getreadystock;
          case 47:
            final getreadystock =
                getpackingmaterialtotalinstockproductionapiresponseFromJson(
                  str,
                );
            return getreadystock;
          case 48:
            final getreadystock =
                getMoldMaterialTotalInStockProductionApiresponseFromJson(str);
            return getreadystock;
          case 49:
            final getreadystock =
                getrawmaterialinstockproductionapiresponseFromJson(str);
            return getreadystock;
          case 50:
            final getreadystock =
                getpackingmaterialinstockproductionapiresponseFromJson(str);
            return getreadystock;
          case 51:
            final getreadystock =
                getmoldmaterialinstockproductionapiresponseFromJson(str);
            return getreadystock;
          case 53:
            final getreadystock =
                getmoldmaterialtotaloutwardproductionapiresponseFromJson(str);
            return getreadystock;
          case 54:
            final getreadystock =
                getrawmaterialtotaloutwardproductionapiresponseFromJson(str);
            return getreadystock;
          case 55:
            final getreadystock =
                getpackingmaterialtotaloutwardproductionapiresponseFromJson(
                  str,
                );
            return getreadystock;
          case 56:
            final userprofile = setTempFinalDispatchApprovedApiResponseFromJson(
              str,
            );
            return userprofile;
          case 57:
            final userprofile =
                tempMaterialDispatchPreviewApiUrlResponseFromJson(str);
            return userprofile;
          case 58:
            final userprofile = tempMaterialDispatchDeleteApiresponseFromJson(
              str,
            );
            return userprofile;
          case 59:
            final userprofile = tempMaterialDispatchDeleteApiresponseFromJson(
              str,
            );
            return userprofile;
          case 61:
            final userprofile = tempMaterialDispatchDeleteApiresponseFromJson(
              str,
            );
            return userprofile;
          case 62:
            final userprofile = tempMaterialDispatchDeleteApiresponseFromJson(
              str,
            );
            return userprofile;
          case 63:
            final getreadystock =
                getAllShotsPerHourHistoryDataApiResponseFromJson(str);
            return getreadystock;
          case 64:
            final getreadystock = getClientBranchApiResponseFromJson(str);
            return getreadystock;
          case 65:
            final getreadystock = getProductsApiResponseFromJson(str);
            return getreadystock;
          case 66:
            final getreadystock =
                getUniqueTblAppShotsPerHourApiResponseFromJson(str);
            return getreadystock;
          case 67:
            final getreadystock = getMachineProductApiResponseFromJson(str);
            return getreadystock;
          case 68:
            final getreadystock = getClientMaterialApiResponseFromJson(str);
            return getreadystock;
          case 69:
            final getreadystock = getEmployeeAllNotificationApiResponseFromJson(
              str,
            );
            return getreadystock;
          case 70:
            final getreadystock = getVehicleLoadingHistoryApiResponseFromJson(
              str,
            );
            return getreadystock;
          case 71:
            final getreadystock = getVehicleLoadingApiResponseFromJson(str);
            return getreadystock;
          case 72:
            final getotp = getAllOrdersApiResponseFromJson(str);
            return getotp;
            case 73: // Case 9 (example)
        final packageOrders = getAllPackageOrdersApiResponseFromJson(str);
        return packageOrders;
           case 73: // Case 9 (example)
        final packagefilterOrders = getAllPackageOrdersApiResponseFromJson(str);
        return packagefilterOrders;
          // case 1:
          //   final getotp = getloginotpresponseFromJson(str);
          //   return getotp;
        }
      } else {
        log("URL: $url\nRequestBody:\n$body\nResponse:\n${response.body}");
      }
    } catch (e, stackTrace) {
      await errorLogger.setUserId(AppUtility.login_id);
      await errorLogger.logError(
        errorMessage: e.toString(),
        errorLocation: url,
        userId: AppUtility.login_id,
        stackTrace: stackTrace,
      );
    }
    return null;
  }

  Future<List<Object?>?> getMethod(
    int requestCode,
    String url,
    BuildContext context,
  ) async {
    final errorLogger = ErrorLogger();
    try {
      var response = await get(Uri.parse(url));
      var data = response.body;

      if (response.statusCode == 200) {
        String str = "[" + response.body + "]";
        log("URL: $url\nResponse:\n$str");

        switch (requestCode) {
          case 1:
            final getotp = getgenerateorderdataresponseFromJson(str);
            return getotp;

          case 11:
            final getotp = getallmachineapiresponseFromJson(str);
            return getotp;

          case 29:
            final getotp = getallclientsapiresponseFromJson(str);
            return getotp;

          case 43:
            final getreadystock = gettotalpendingorderapiresponseFromJson(str);
            return getreadystock;
          case 72:
            final getreadystock = getContractorListApiResponseFromJson(str);
            return getreadystock;
        }
      } else {
        log("URL: $url\nResponse:\n${response.body}");
      }
    } catch (e, stackTrace) {
      await errorLogger.setUserId(AppUtility.login_id);
      await errorLogger.logError(
        errorMessage: e.toString(),
        errorLocation: url,
        userId: AppUtility.login_id,
        stackTrace: stackTrace,
      );
    }
    return null;
  }
}
