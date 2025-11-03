import 'dart:convert';

import '../Core/apputility.dart';
import 'call/BatchCompleteRequest.dart';
import 'call/BatchHoldRequestcall.dart';
import 'call/BatchStartRequestcall.dart';
import 'call/BatchStopRequest.dart';
import 'call/ClientMaterialcall.dart';
import 'call/DeleteQcApicall.dart';
import 'call/GetAllOrdersapicall.dart';
import 'call/GetBatchDeleteApi.dart';
import 'call/Getbatchjobcardprintapi.dart';
import 'call/SetTempFinalDispatchApprovedApiCall.dart';
import 'call/ShotsPerHourMachineProductApiCall.dart';
import 'call/ShotsPerHourRequestCall.dart';
import 'call/TempMaterialDispatchPreviewApiCall.dart';
import 'call/TempMaterialProductVehicleLoadingApi.dart';
import 'call/addemployeecall.dart';
import 'call/allbatchlistcompletefilterapicall.dart';
import 'call/attemptedtestcall.dart';
import 'call/attemptedtestquestiondetailcall.dart';
import 'call/batchprocessinglisfiltercall.dart';
import 'call/batchprocessinglistcall.dart';
import 'call/batchsfiltercall.dart';
import 'call/bookmarknewscall.dart';
import 'call/buycoursecall.dart';
import 'call/buymembershipcall.dart';
import 'call/buytestseriescall.dart';
import 'call/coursecontentcall.dart';
import 'call/createaccountcall.dart';
import 'call/currentaffairstestcall.dart';
import 'call/deleteaccountcall.dart';
import 'call/docandvideotestcall.dart';
import 'call/downloadfileapicall.dart';
import 'call/ebookcategorycall.dart';
import 'call/ebooklistcall.dart';
import 'call/ebooksolutioncall.dart';
import 'call/ebooksubcategorycall.dart';
import 'call/ebooktestcall.dart';
import 'call/englishbookmarkcall.dart';
import 'call/exammaterialcall.dart';
import 'call/exammaterialrecentpostcall.dart';
import 'call/exammaterialsubjectcall.dart';
import 'call/exammaterialsubwisecall.dart';
import 'call/exammaterialyearscall.dart';
import 'call/examwisepdfcall.dart';
import 'call/examwisetestcall.dart';
import 'call/generateorderupdateentryapi.dart';
import 'call/getTotalOngoingOrderApiCall.dart';
import 'call/get_vehicle_loading_api_call.dart';
import 'call/get_vehicle_loading_history_apicall.dart';
import 'call/get_employee_all_notification_apicall.dart';
import 'call/getallbatchlisglobalfiltertapicall.dart';
import 'call/getclientbranchapicall.dart';
import 'call/getcouponcall.dart';
import 'call/getcurrentaffaircall.dart';
import 'call/getdistrictcall.dart';
import 'call/getdocsandvideocall.dart';
import 'call/getemployeeattendancelistcall.dart';
import 'call/getemployeelistcall.dart';
import 'call/getenglishvocabcall.dart';
import 'call/getmanagecoursecall.dart';
import 'call/getmarathivocabcall.dart';
import 'call/getmembershipcall.dart';
import 'call/getmonthattendancecall.dart';
import 'call/getnewscall.dart';
import 'call/getnotificationcall.dart';
import 'call/getotpcall.dart';
import 'call/getprofilecall.dart';
import 'call/getshiftlistcall.dart';
import 'call/gettestdetailscall.dart';
import 'call/helpmastercall.dart';
import 'call/instockfiltercall.dart';
import 'call/markattendancecall.dart';
import 'call/membershipcall.dart';
import 'call/mocktestcall.dart';
import 'call/mycontentcall.dart';
import 'call/order_detailscall.dart';
import 'call/otheroptioncall.dart';
import 'call/qclistapicall.dart';
import 'call/setuserdoubtscall.dart';
import 'call/singlecoursedetailscall.dart';
import 'call/subjectwisepdfcall.dart';
import 'call/syllabuscall.dart';
import 'call/syllabusexampdfcall.dart';
import 'call/syllabussubjectwisecall.dart';
import 'call/testseriescall.dart';
import 'call/testseriespdfcall.dart';
import 'call/testseriessinglecall.dart';
import 'call/testseriestestcall.dart';
import 'call/testsubmitcall.dart';
import 'call/updateprofilecall.dart';
import 'call/usercurrentaffairbookmarkcall.dart';
import 'call/userloggedinuser.dart';
import 'call/usermarathishabdbookmarkcall.dart';
import 'call/userprofilecall.dart';
import 'call/validateotp.dart';
import 'call/vehileloadingcall.dart';
import 'call/yeartypecall.dart';

class Createjson {
  String createJsonForGenerateOrderDeleteApi(String id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      GenerateOrderDeleteApicall loginjsonCreation = GenerateOrderDeleteApicall(
        id: id,
      );
      var result = GenerateOrderDeleteApicall.fromJson(
        loginjsonCreation.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForGenerateOrderUpdateEntryApi(String id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      generateOrderUpdateEntryApi loginjsonCreation =
          generateOrderUpdateEntryApi(id: id);
      var result = generateOrderUpdateEntryApi.fromJson(
        loginjsonCreation.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForBatchStart(
    String id,
    String machineName,
    String startDate,
    String startTime,
    String userId,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      BatchStartRequest batchStartRequest = BatchStartRequest(
        id: id,
        machineName: machineName,
        startDate: startDate,
        startTime: startTime,
        userId: userId,
      );
      var result = BatchStartRequest.fromJson(batchStartRequest.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForBatchHold(
    String id,
    String batchQuantity,
    String producedQuantity,
    String balanceQuantity,
    String holdRemark,
    String userId,
    String previousQuantity,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      BatchHoldRequest batchHoldRequest = BatchHoldRequest(
        id: id,
        batchQuantity: batchQuantity,
        producedQuantity: producedQuantity,
        balanceQuantity: balanceQuantity,
        holdRemark: holdRemark,
        userId: userId,
        previousQuantity: previousQuantity,
      );
      var result = BatchHoldRequest.fromJson(batchHoldRequest.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForBatchStop(
    String id,
    String endDate,
    String endTime,
    String batchQuantity,
    String producedQuantity,
    String balanceQuantity,
    String stopRemark,
    String productName,
    String userId,
    String previousQuantity,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');

      // Create the batch stop request object
      BatchStopRequest batchStopRequest = BatchStopRequest(
        id: id,
        endDate: endDate,
        endTime: endTime,
        batchQuantity: batchQuantity,
        producedQuantity: producedQuantity,
        balanceQuantity: balanceQuantity,
        remark: stopRemark, // Use stop_remark only
        productName: productName,
        userId: userId,
        previousQuantity: previousQuantity,
      );

      // Convert the object to JSON and return as string
      var result = BatchStopRequest.fromJson(batchStopRequest.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForBatchComplete(
    String id,
    String endDate,
    String endTime,
    String batchQuantity,
    String producedQuantity,
    String balanceQuantity,
    String completeRemark,
    String productName,
    userId,
    previousQuantity,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');

      // Create the batch complete request object
      BatchCompleteRequest batchCompleteRequest = BatchCompleteRequest(
        id: id,
        endDate: endDate,
        endTime: endTime,
        batchQuantity: batchQuantity,
        producedQuantity: producedQuantity,
        balanceQuantity: balanceQuantity,
        completeRemark: completeRemark, // Use complete_remark
        productName: productName,
        userId: userId,
        previousQuantity: previousQuantity,
      );

      // Convert the object to JSON and return as string
      var result = BatchCompleteRequest.fromJson(batchCompleteRequest.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForGetbatchjobcardprintapi(List<String> ids) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getbatchjobcardprintapi getbatchjobcardprintapi = Getbatchjobcardprintapi(
        selectedIds: ids,
      );
      var result = Getbatchjobcardprintapi.fromJson(
        getbatchjobcardprintapi.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForPackageDetailsApi(String customer_id, String package_id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      PackageDetailsApi requestBody = PackageDetailsApi(
        customer_id: customer_id,
        package_id: package_id,
      );
      var result = PackageDetailsApi.fromJson(requestBody.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForTempMaterialProductVehicleLoadingApi(String id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      TempMaterialProductVehicleLoadingApi
      tempMaterialProductVehicleLoadingApi =
          TempMaterialProductVehicleLoadingApi(id: id);
      var result = TempMaterialProductVehicleLoadingApi.fromJson(
        tempMaterialProductVehicleLoadingApi.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForVehicleLoading(String id, List<RowData> updatedData) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      VehicleLoading vehicleLoading = VehicleLoading(id: id, data: updatedData);
      var result = VehicleLoading.fromJson(vehicleLoading.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetshift(String employeetype) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getshiftlistcall loginjsonCreation = Getshiftlistcall(
        employeeType: employeetype,
      );
      var result = Getshiftlistcall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForpackageEnquiryForm(
    String package_id,
    customer_id,
    // service_id,
    // first_name,
    // last_name,
    // email,
    // mobile_number,
    // message,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      packageEnquiryFormCall loginjsonCreation = packageEnquiryFormCall(
        package_id: package_id,
        customer_id: customer_id,
        // service_id: service_id,
        // first_name: first_name,
        // last_name: last_name,
        // email: email,
        // mobile_number: mobile_number,
        // message: message,
      );
      var result = packageEnquiryFormCall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetemployee(
    String? employeetypeid,
    String? shiftid, [
    String contractorId = "",
  ]) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getemployeelistcall loginjsonCreation = Getemployeelistcall(
        employeeType: employeetypeid!,
        shiftid: shiftid!,
        contractorId: contractorId,
      );
      var result = Getemployeelistcall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonformarkattendance(
    String? selectedDate,
    String? selectedTime,
    String? selectshiftid,
    List<Attendance> attendanceList,
    String contractorId,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Markattendancecall loginjsonCreation = Markattendancecall(
        date: selectedDate!,
        time: selectedTime!,
        userId: AppUtility.login_id,
        attendance: attendanceList,
        shiftId: selectshiftid!,
        contractorId: contractorId,
      );
      var result = Markattendancecall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetmonthattendance(
    int month,
    int year,
    String? selectshiftid,
    selectemployeetypeid,
    contractorId,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getmonthattendancecall loginjsonCreation = Getmonthattendancecall(
        selectemployeetypeid: selectemployeetypeid,
        shiftType: selectshiftid!,
        month: month.toString(),
        year: year.toString(),
        contractorId: contractorId,
      );

      var result = Getmonthattendancecall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetattendacelist(
    String selecteddate,
    String shiftid,
    selectemployeetypeid,
    contractorId,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getemployeeattendancelistcall loginjsonCreation =
          Getemployeeattendancelistcall(
            date: selecteddate,
            shiftType: shiftid,
            selectemployeetypeid: selectemployeetypeid,
            contractorId: contractorId,
          );
      var result = Getemployeeattendancelistcall.fromJson(
        loginjsonCreation.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetprofile(String userid) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Userprofilecall loginjsonCreation = Userprofilecall(userId: userid);
      var result = Userprofilecall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForShotsPerHourApi(String machineId) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      ShotsPerHourMachineProductApi apiCall = ShotsPerHourMachineProductApi(
        machineId: machineId,
      );
      var result = ShotsPerHourMachineProductApi.fromJson(apiCall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForShotsPerHour(
    String date,
    String machineId,
    List<Map<String, dynamic>> updatedData,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent(''); // Format the JSON
      var result = {
        "date": date,
        "machine_id": machineId,
        "shots_per_hour_data": updatedData,
      };
      String str = encoder.convert(result); // Convert to pretty-printed JSON
      return str;
    } catch (e) {
      print(e.toString());
      return ""; // Return empty string in case of error
    }
  }

  String createJsonForQcDeleteApi(String id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      DeleteQcApi requestBody = DeleteQcApi(id: id);
      var result = DeleteQcApi.fromJson(requestBody.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForSetTempFinalDispatchApproved(
    String dispatchType,
    String id,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      SetTempFinalDispatchApprovedApi requestBody =
          SetTempFinalDispatchApprovedApi(dispatchType: dispatchType, id: id);
      var result = SetTempFinalDispatchApprovedApi.fromJson(
        requestBody.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForTempMaterialDispatchPreviewApi(String id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      TempMaterialDispatchPreviewApi requestBody =
          TempMaterialDispatchPreviewApi(id: id);
      var result = TempMaterialDispatchPreviewApi.fromJson(
        requestBody.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonFortempMaterialDispatchDeleteApi(String id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      TempMaterialDispatchPreviewApi requestBody =
          TempMaterialDispatchPreviewApi(id: id);
      var result = TempMaterialDispatchPreviewApi.fromJson(
        requestBody.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForrawMaterialDispatchDeleteApi(String id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      TempMaterialDispatchPreviewApi requestBody =
          TempMaterialDispatchPreviewApi(id: id);
      var result = TempMaterialDispatchPreviewApi.fromJson(
        requestBody.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonFormoldMaterialDispatchDeleteApi(String id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      TempMaterialDispatchPreviewApi requestBody =
          TempMaterialDispatchPreviewApi(id: id);
      var result = TempMaterialDispatchPreviewApi.fromJson(
        requestBody.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForvalidateotp(
    String mobile_number,
    String otp,
    String push_token,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Validateotpcall loginjsonCreation = Validateotpcall(
        mobileNumber: mobile_number,
        otp: otp,
        pushToken: push_token,
      );
      var result = Validateotpcall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForGetProfile(String login_id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getprofilecall loginjsonCreation = Getprofilecall(loginId: login_id);
      var result = Getprofilecall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForSetDoubts(String login_id, String question) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Setuserdoubtscall loginjsonCreation = Setuserdoubtscall(
        login_id: login_id,
        doubtQuestion: question,
      );
      var result = Setuserdoubtscall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetDistrict(String state_id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getdistrictcall getdistrictcall = Getdistrictcall(stateId: state_id);
      var result = Getdistrictcall.fromJson(getdistrictcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForCreateAccount(
    String fullname,
    address,
    mobile_number,
    email,
    districtid,
    stateid,
    gender,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Createaccountcall createaccountcall = Createaccountcall(
        fullName: fullname,
        address: address,
        mobileNumber: mobile_number,
        gender: gender,
        email: email,
        districtId: districtid,
        stateId: stateid,
      );
      var result = Createaccountcall.fromJson(createaccountcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForUpdateProfile(
    String fullname,
    login_id,
    address,
    mobile_number,
    email,
    profile,
    gender,
    state_id,
    district_id,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Updateprofilecall updateprofilecall = Updateprofilecall(
        fullName: fullname,
        loginId: login_id,
        address: address,
        mobileNumber: mobile_number,
        profileImage: profile,
        gender: gender,
        stateId: state_id,
        districtId: district_id,
        email: email,
      );
      var result = Updateprofilecall.fromJson(updateprofilecall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForGetCurrentAffair(
    String category_id,
    String login_id,
    int limit,
    int offset,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getcurrentaffaircall getnewscall = Getcurrentaffaircall(
        category: category_id,
        loginId: login_id,
        limit: limit.toString(),
        offset: offset.toString(),
      );
      var result = Getcurrentaffaircall.fromJson(getnewscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForGetNews(
    String category_id,
    String login_id,
    int page,
    int limit,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getnewscall getnewscall = Getnewscall(
        category: category_id,
        loginId: login_id,
        limit: limit.toString(),
        offset: page.toString(),
      );
      var result = Getnewscall.fromJson(getnewscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforsavecurrentaffair(
    String login_id,
    String currentAffairId,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Usercurrentaffairbookmarkcall bookmarkcall =
          Usercurrentaffairbookmarkcall(
            currentAffairId: currentAffairId,
            loginId: login_id,
          );
      var result = Usercurrentaffairbookmarkcall.fromJson(
        bookmarkcall.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForBookmarkNews(String newsid, String login_id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Bookmarknewscall bookmarkcall = Bookmarknewscall(
        newsId: newsid,
        loginId: login_id,
      );
      var result = Bookmarknewscall.fromJson(bookmarkcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetmanagecourse(int limit, int page) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getcoursecall bookmarkcall = Getcoursecall(
        limit: limit,
        offset: page,
        loginId: AppUtility.login_id,
      );
      var result = Getcoursecall.fromJson(bookmarkcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetdocsandvideos(
    int limit,
    int page,
    String loginid,
    String type,
    source_type,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getdocsandvideoscall docvideos = Getdocsandvideoscall(
        limit: limit.toString(),
        offset: page.toString(),
        loginId: loginid,
        type: type,
        source_type: source_type,
      );
      var result = Getdocsandvideoscall.fromJson(docvideos.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetmembershipstatus(String login_id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getmembershipcall membership = Getmembershipcall(loginId: login_id);
      var result = Getmembershipcall.fromJson(membership.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetotheroption(int limit, int page, String categoryid) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Otheroptioncall otheroptioncall = Otheroptioncall(
        limit: limit,
        offset: page,
        otherOptionCategoryId: categoryid,
      );
      var result = Otheroptioncall.fromJson(otheroptioncall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsongetmembershipplan(String login_id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Membershipcall otheroptioncall = Membershipcall(loginId: login_id);
      var result = Membershipcall.fromJson(otheroptioncall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforhelpmaster(int type) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Helpmastercall helpmastercall = Helpmastercall(type: type);
      var result = Helpmastercall.fromJson(helpmastercall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforebookcategorycall(String login_id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Ebookcategorycall ebookcategorycall = Ebookcategorycall(
        loginId: login_id,
      );
      var result = Ebookcategorycall.fromJson(ebookcategorycall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforebooksubcategorycall(String login_id, String categoryid) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Ebooksubcategorycall ebooksubcategorycall = Ebooksubcategorycall(
        loginId: login_id,
        categoryId: categoryid,
      );
      var result = Ebooksubcategorycall.fromJson(ebooksubcategorycall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforebooklist(
    String login_id,
    String categoryid,
    String subcategoryid,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Ebooklistcall ebooklistcall = Ebooklistcall(
        loginId: login_id,
        categoryId: categoryid,
        subCategoryId: subcategoryid,
      );
      var result = Ebooklistcall.fromJson(ebooklistcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforebooksolution(String login_id, String ebookid) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Ebooklsolutioncall ebooklsolutioncall = Ebooklsolutioncall(
        loginId: login_id,
        ebookId: ebookid,
      );
      var result = Ebooklsolutioncall.fromJson(ebooklsolutioncall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetcoupon(String login_id, String type) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Getcouponcall couponcall = Getcouponcall(loginId: login_id, type: type);
      var result = Getcouponcall.fromJson(couponcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforbuycourse(
    String login_id,
    courseid,
    transactionid,
    paymentstatus,
    is_coupon_applied,
    applied_coupon_id,
    payment_amount,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Buycoursecall buycoursecall = Buycoursecall(
        loginId: login_id,
        courseId: courseid,
        transactionId: transactionid,
        paymentStatus: paymentstatus,
        isCouponApplied: is_coupon_applied,
        appliedCouponId: applied_coupon_id,
        paymentAmount: payment_amount.toString(),
      );
      var result = Buycoursecall.fromJson(buycoursecall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgettestdetails(String login_id, testid) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Gettestdetailscall testdetailscall = Gettestdetailscall(
        loginId: login_id,
        testId: testid,
      );
      var result = Gettestdetailscall.fromJson(testdetailscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetcoursecontent(String login_id, courseid) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Coursecontentcall coursecontentcall = Coursecontentcall(
        loginId: login_id,
        courseId: courseid,
      );
      var result = Coursecontentcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForsubmittest(
    String login_id,
    testid,
    module,
    DateTime submittedon,
    List<AnswerList> anslist,
    attempted_test_id,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Testsubmitcall coursecontentcall = Testsubmitcall(
        loginId: login_id,
        testId: testid,
        parent_module: module,
        attempted_test_id: attempted_test_id,
        submittedOn: submittedon,
        answerList: anslist,
      );
      var result = Testsubmitcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonFormycontent(String login_id, int page, limit) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Mycontentcall coursecontentcall = Mycontentcall(
        loginId: login_id,
        limit: limit,
        offset: page,
      );
      var result = Mycontentcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonFortestseries(String login_id, int page, limit) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Testseriescall coursecontentcall = Testseriescall(
        loginId: login_id,
        limit: limit,
        offset: page,
      );
      var result = Testseriescall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonfortestseries(
    String login_id,
    testid,
    transactionid,
    paymentstatus,
    is_coupon_applied,
    applied_coupon_id,
    payment_amount,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Buytestseriescall buycoursecall = Buytestseriescall(
        loginId: login_id,
        testId: testid,
        transactionId: transactionid,
        paymentStatus: paymentstatus,
        isCouponApplied: is_coupon_applied,
        appliedCouponId: applied_coupon_id,
        paymentAmount: payment_amount.toString(),
      );
      var result = Buytestseriescall.fromJson(buycoursecall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonFortestseriespdf(String login_id, test_id, int page, limit) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Testseriespdfcall coursecontentcall = Testseriespdfcall(
        loginId: login_id,
        limit: limit,
        offset: page,
        testId: test_id,
      );
      var result = Testseriespdfcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonFortestseriestest(
    String login_id,
    test_id,
    int page,
    limit,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Testseriestestcall coursecontentcall = Testseriestestcall(
        loginId: login_id,
        limit: limit,
        offset: page,
        testId: test_id,
      );
      var result = Testseriestestcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonFortestsingleseries(String test_id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Testseriessinglecall coursecontentcall = Testseriessinglecall(
        testId: test_id,
        loginId: AppUtility.login_id,
      );
      var result = Testseriessinglecall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForattemptedtest(
    String test_id,
    attemptedtestid,
    parentmodule,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Attemptedtestcall coursecontentcall = Attemptedtestcall(
        testId: test_id,
        loginId: AppUtility.login_id,
        attemptedTestId: attemptedtestid,
        parentModule: parentmodule,
      );
      var result = Attemptedtestcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForattemptedtestquestiondetail(
    String test_id,
    attemptedtestid,
    parentmodule,
    questionstatus,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Attemptedtestquestiondetailcall coursecontentcall =
          Attemptedtestquestiondetailcall(
            testId: test_id,
            loginId: AppUtility.login_id,
            attemptedTestId: attemptedtestid,
            parentModule: parentmodule,
            questionStatus: questionstatus,
          );
      var result = Attemptedtestquestiondetailcall.fromJson(
        coursecontentcall.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForcurrentaffairstest(String categoryid, int page, limit) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Currentaffairstestcall coursecontentcall = Currentaffairstestcall(
        categoryId: categoryid,
        loginId: AppUtility.login_id,
        limit: limit,
        offset: page,
      );
      var result = Currentaffairstestcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonFormocktest(String login_id, int page, limit) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Mocktestcall coursecontentcall = Mocktestcall(
        loginId: login_id,
        limit: limit,
        offset: page,
      );
      var result = Mocktestcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForebooktestlist(
    String login_id,
    int page,
    limit,
    String chapterid,
    ebookid,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Ebooktestcall coursecontentcall = Ebooktestcall(
        loginId: login_id,
        limit: limit,
        offset: page,
        chapterId: chapterid,
        ebookId: ebookid,
      );
      var result = Ebooktestcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonFordocandvideotest(String login_id, int page, limit) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Docvideotestcall coursecontentcall = Docvideotestcall(
        loginId: login_id,
        limit: limit,
        offset: page,
      );
      var result = Docvideotestcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForexammaterial(String login_id, int page, limit) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Exammaterialcall coursecontentcall = Exammaterialcall(
        loginId: login_id,
        limit: limit,
        offset: page,
      );
      var result = Exammaterialcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForexamsubjectmaterial(String login_id, int page, limit) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Exammaterialsubjectcall coursecontentcall = Exammaterialsubjectcall(
        loginId: login_id,
        limit: limit,
        offset: page,
      );
      var result = Exammaterialsubjectcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForexamyear(
    String login_id,
    String exammaterialid,
    int page,
    int limit,
    String examid,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Exammaterialyearscall coursecontentcall = Exammaterialyearscall(
        loginId: login_id,
        limit: limit,
        offset: page,
        examMaterialId: exammaterialid,
        examId: examid,
      );
      var result = Exammaterialyearscall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForexamyeartype(
    String login_id,
    String exammaterialid,
    int page,
    int limit,
    String examid,
    String yearid,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Yeartypecall coursecontentcall = Yeartypecall(
        loginId: login_id,
        limit: limit,
        offset: page,
        examMaterialId: exammaterialid,
        examId: examid,
        yearId: yearid,
      );
      var result = Yeartypecall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForgetproductsapi(
    String clientId,
    String itemGroup,
    String branchName,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      getproductsapicall coursecontentcall = getproductsapicall(
        clientId: clientId,
        itemGroup: itemGroup,
        branchName: branchName,
      );
      var result = getproductsapicall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForexampdf(
    String login_id,
    String exammaterialid,
    int page,
    int limit,
    String examid,
    String yearid,
    String typeid,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Examwisepdfcall coursecontentcall = Examwisepdfcall(
        loginId: login_id,
        limit: limit,
        offset: page,
        examMaterialId: exammaterialid,
        examId: examid,
        examTypeId: typeid,
        examYearId: yearid,
      );
      var result = Examwisepdfcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  // String createjsonForexamtest(String login_id, String exammaterialid, String page,
  //   ) {
  //   try {
  //     JsonEncoder encoder = JsonEncoder.withIndent('');
  //     Examwisetestcall coursecontentcall = Examwisetestcall(
  //         loginId: login_id,
  //         limit: limit,
  //         offset: page,
  //         examMaterialId: exammaterialid,
  //         examId: examid,
  //         examTypeId: typeid,
  //         examYearId: yearid);
  //     var result = Examwisetestcall.fromJson(coursecontentcall.toJson());
  //     String str = encoder.convert(result);
  //     return str;
  //   } catch (e) {
  //     print(e.toString());
  //     return "";
  //   }
  // }

  String createjsonForsubjectpdf(
    String login_id,
    String exammaterialid,
    int page,
    int limit,
    String subjectid,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Subjectwisepdfcall coursecontentcall = Subjectwisepdfcall(
        loginId: login_id,
        limit: limit,
        offset: page,
        examMaterialId: exammaterialid,
        subjectId: subjectid,
      );
      var result = Subjectwisepdfcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForsyllabusexampdf(
    String login_id,
    int page,
    int limit,
    String examid,
    String yearid,
    String typeid,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Syllabusexampdfcall coursecontentcall = Syllabusexampdfcall(
        loginId: login_id,
        limit: limit,
        offset: page,
        examId: examid,
        examTypeId: typeid,
        examYearId: yearid,
      );
      var result = Syllabusexampdfcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForGetMarathiVocab(
    String category_id,
    String login_id,
    int limit,
    int offset,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      GetMarathiVocabCall getnewscall = GetMarathiVocabCall(
        category: category_id,
        loginId: login_id,
        limit: limit.toString(),
        offset: offset.toString(),
      );
      var result = GetMarathiVocabCall.fromJson(getnewscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforsavemarathishabd(String login_id, String marathiSabdId) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Usermarathishabdbookmarkcall bookmarkcall = Usermarathishabdbookmarkcall(
        marathiSabdId: marathiSabdId,
        loginId: login_id,
      );
      var result = Usermarathishabdbookmarkcall.fromJson(bookmarkcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforsaveenglish(String login_id, String marathiSabdId) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      EnglishBookmarkCall bookmarkcall = EnglishBookmarkCall(
        englishWordId: marathiSabdId,
        loginId: login_id,
      );
      var result = EnglishBookmarkCall.fromJson(bookmarkcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForGetEnglishVocab(
    String category_id,
    String login_id,
    int limit,
    int offset,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      GetEnglishVocabCall getnewscall = GetEnglishVocabCall(
        category: category_id,
        loginId: login_id,
        limit: limit.toString(),
        offset: offset.toString(),
      );
      var result = GetEnglishVocabCall.fromJson(getnewscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetsinglecoursedetails(String id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Singlecoursedetailscall getnewscall = Singlecoursedetailscall(
        courseId: id,
        loginId: AppUtility.login_id,
      );
      var result = Singlecoursedetailscall.fromJson(getnewscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforbuymembership(
    String login_id,
    membershipid,
    transactionid,
    paymentstatus,
    is_coupon_applied,
    applied_coupon_id,
    payment_amount,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Buymembershipcall buycoursecall = Buymembershipcall(
        loginId: login_id,
        membershipId: membershipid,
        transactionId: transactionid,
        paymentStatus: paymentstatus,
        isCouponApplied: is_coupon_applied,
        appliedCouponId: applied_coupon_id,
        paymentAmount: payment_amount.toString(),
      );
      var result = Buymembershipcall.fromJson(buycoursecall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForGetnotification(String login_id, int limit, int offset) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      GetNotificationCall getnewscall = GetNotificationCall(
        loginId: login_id,
        limit: limit.toString(),
        offset: offset.toString(),
      );
      var result = GetNotificationCall.fromJson(getnewscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonforgetclientbranchapi(String client_id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      getclientbranchapiCall membership = getclientbranchapiCall(
        client_id: client_id,
      );
      var result = getclientbranchapiCall.fromJson(membership.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetallbatchlistcompleteapi(int limit, int offset) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Syllabuscall getnewscall = Syllabuscall(limit: limit, offset: offset);
      var result = Syllabuscall.fromJson(getnewscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetallbatchlistcompletefilterapi(
    int limit,
    int offset,
    String clientId,
    String productName,
    // String fromDate,
    // String toDate,
    String itemGroup,
    String branchId,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      allbatchlistcompletefilterapicall getnewscall =
          allbatchlistcompletefilterapicall(
            limit: limit,
            offset: offset,
            clientId: clientId,
            productName: productName,
            // fromDate: fromDate,
            // toDate: toDate,
            itemGroup: itemGroup,
            branchId: branchId,
          );
      var result = allbatchlistcompletefilterapicall.fromJson(
        getnewscall.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createjsonForexamwisesubjectmaterial(
    String login_id,
    int page,
    int limit,
    String examMaterialId,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Exammaterialsubwisecall coursecontentcall = Exammaterialsubwisecall(
        loginId: login_id,
        limit: limit,
        offset: page,
        examMaterialId: examMaterialId, // Pass the new parameter
      );
      var result = Exammaterialsubwisecall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForSetUserData({
    required String project,
    required String username,
    required String deviceId,
    required String userId,
    required String name,
    required String mobileNo,
    String? email,
    required Map<String, dynamic> deviceDetails,
    required List<Map<String, dynamic>> permissionDetails,
  }) {
    try {
      // Ensure no null values for required fields
      username = username ?? '';
      deviceId = deviceId ?? '';
      name = name ?? '';
      mobileNo = mobileNo ?? '';
      email = email ?? '';

      // Create UserLoginCall object
      UserLoginCall userLoginCall = UserLoginCall(
        project: project,
        username: username,
        deviceId: deviceId,
        userId: userId,
        name: name,
        mobileNo: mobileNo,
        email: email ?? '',
        password: '',
        deviceDetails: DeviceDetails.fromJson(deviceDetails),
        permissionDetails: List<PermissionDetails>.from(
          permissionDetails.map(
            (permission) => PermissionDetails.fromJson(permission),
          ),
        ),
      );

      // Convert UserLoginCall to JSON and return it
      String jsonString = json.encode(userLoginCall.toJson());
      print(
        'Generated JSON: $jsonString',
      ); // Debugging: Check the generated JSON

      return jsonString;
    } catch (e) {
      print('Error in createJsonForSetUserData: ${e.toString()}');
      return ""; // Return empty string in case of error
    }
  }

  String createJsonForGetAllShotsPerHourHistoryData(
    String machineId,
    String productId,
    String date,
    int limit,
    offset,
    // Added parameter
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');

      Examwisetestcall coursecontentcall = Examwisetestcall(
        machineId: machineId,
        productId: productId,
        date: date,
        limit: limit,
        offset: offset,
      );

      var result = Examwisetestcall.fromJson(coursecontentcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForMachineReport(
    String fromDate,
    String toDate,
    String machineId, {
    int limit = 10,
    offset = 0,
  }) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      Exammaterialrecentpostcall coursecontentcall = Exammaterialrecentpostcall(
        fromDate: fromDate,
        toDate: toDate,
        machineId: machineId, // Pass the new parameter
        limit: limit,
        offset: offset,
      );
      var result = Exammaterialrecentpostcall.fromJson(
        coursecontentcall.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetclientbranchapi(String clientId) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      getclientbranchapicall loginjsonCreation = getclientbranchapicall(
        clientId: clientId,
      );
      var result = getclientbranchapicall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetallbatchlistapi(
    String clientName,
    String productName,
    String fromDate,
    String toDate,
    int limit,
    int offset, {
    String itemGroup = "",
    String branchId = "",
  }) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      batchprocessinglistcall getnewscall = batchprocessinglistcall(
        limit: limit,
        offset: offset ?? 0,
        clientName: clientName ?? "",
        productName: productName ?? "",
        fromDate: fromDate ?? "",
        toDate: toDate ?? "",
        itemGroup: itemGroup,
        branchId: branchId,
      );
      var result = batchprocessinglistcall.fromJson(
        getnewscall.toJson(),
      ); //this line is very imp!!
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetallbatchlisfiltertapi(
    String machineId,
    String productId,
    String fromDate,
    String toDate,
    int limit,
    int offset, {
    String itemGroup = "",
    String branchId = "",
  }) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      batchprocessinglisfiltercall getnewscall = batchprocessinglisfiltercall(
        limit: limit,
        offset: offset ?? 0,
        machineId: machineId ?? "",
        productId: productId ?? "",
        fromDate: fromDate ?? "",
        toDate: toDate ?? "",
        itemGroup: itemGroup,
        branchId: branchId,
      );
      var result = batchprocessinglisfiltercall.fromJson(
        getnewscall.toJson(),
      ); //this line is very imp!!
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetallbatchlisglobalfiltertapi(
    String machineId,
    String productId,
    String fromDate,
    String toDate,
    int limit,
    int offset,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      getallbatchlisglobalfiltertapicall getnewscall =
          getallbatchlisglobalfiltertapicall(
            limit: limit,
            offset: offset ?? 0,
            machineId: machineId ?? "",
            productId: productId ?? "",
            fromDate: fromDate ?? "",
            toDate: toDate ?? "",
          );
      var result = getallbatchlisglobalfiltertapicall.fromJson(
        getnewscall.toJson(),
      ); //this line is very imp!!
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForqclistapi(
    int offset,
    int limit,
    String machineId,
    String productId, {
    String itemGroup = "",
    String branchId = "",
    String orderId = "",
    String batchId = "",
  }) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      qclistapicall apiCall = qclistapicall(
        offset: offset,
        limit: limit,
        machineId: machineId,
        productId: productId,
        itemGroup: itemGroup,
        branchId: branchId,
        orderId: orderId,
        batchId: batchId,
      );
      var result = qclistapicall.fromJson(apiCall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForbatchsfilter(
    int limit,
    int offset,
    String clientId,
    String branchId,
    String financialYear,
    String fromDate,
    String toDate, {
    String itemGroup = "",
  }) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      batchsfiltercall getnewscall = batchsfiltercall(
        limit: limit,
        offset: offset,
        clientId: clientId,
        branchId: branchId,
        financialYear: financialYear,
        fromDate: fromDate,
        toDate: toDate,
        itemGroup: itemGroup,
      );
      var result = batchsfiltercall.fromJson(getnewscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForinstockfilter(
    int limit,
    int offset,
    String clientId,
    String branchId,
    String itemName,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      instockfiltercall getnewscall = instockfiltercall(
        limit: limit,
        offset: offset,
        clientId: clientId,
        branchId: branchId,
        itemName: itemName,
      );
      var result = instockfiltercall.fromJson(getnewscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForClientMaterial(
    String clientId,
    String itemgroup,
    String branchId,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      ClientMaterialcall getnewscall = ClientMaterialcall(
        clientId: clientId,
        branchId: branchId,
        item_group: itemgroup,
      );
      var result = ClientMaterialcall.fromJson(getnewscall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetEmployeeAllNotificationApi(
    String userid,
    int limit,
    int offset,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      getemployeeallnotificationapicall loginjsonCreation =
          getemployeeallnotificationapicall(
            userId: userid,
            limit: limit,
            offset: offset,
          );
      var result = getemployeeallnotificationapicall.fromJson(
        loginjsonCreation.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetVehicleLoadingApi(String id) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      getvehicleloadinghistoryapicall loginjsonCreation =
          getvehicleloadinghistoryapicall(history_id: id);
      var result = getvehicleloadinghistoryapicall.fromJson(
        loginjsonCreation.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForgetvehicleloadingapi(
    String customerId, {
    int offset = 0,
    int limit = 10,
    String? packageId,
    required String lang,
  }) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      getvehicleloadingapicall loginjsonCreation = getvehicleloadingapicall(
        customerId: customerId,
        offset: offset,
        limit: limit,
        packageId: packageId ?? "",
      );
      var result = getvehicleloadingapicall.fromJson(
        loginjsonCreation.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  // String createJsonForGetAllOrdersapi(
  //   String customerId, {
  //   int offset = 0,
  //   int limit = 10,
  //   String? packageId, required String language,
  // }) {
  //   try {
  //     JsonEncoder encoder = JsonEncoder.withIndent('');
  //     GetAllOrdersapicall loginjsonCreation = GetAllOrdersapicall(
  //       customerId: customerId,
  //       offset: offset,
  //       limit: limit,
  //       service_id: packageId ?? "",
  //     );
  //     var result = GetAllOrdersapicall.fromJson(loginjsonCreation.toJson());
  //     String str = encoder.convert(result);
  //     return str;
  //   } catch (e) {
  //     print(e.toString());
  //     return "";
  //   }
  // }
  String createJsonForGetAllOrdersapi(
    String customerId, {
    int offset = 0,
    int limit = 10,
    String? packageId,
    required String language,
    String? serviceid, // Made required as per your second version
  }) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      GetAllOrdersapicall orderJson = GetAllOrdersapicall(
        customerId: customerId,
        offset: offset,
        limit: limit,
        package_id: "",
        serviceId: packageId ?? "", // Changed to serviceId to match model
        // language: language, // Added language field
      );
      var result = GetAllOrdersapicall.fromJson(orderJson.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print('Error creating JSON for GetAllOrders API: $e');
      return "";
    }
  }

  String createjsonforgetTotalOngoingOrderApi(
    String? userId,
    String? pushToken,
  ) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      getTotalOngoingOrderApiCall loginjsonCreation =
          getTotalOngoingOrderApiCall(user_id: userId!, pushtoken: pushToken!);
      var result = getTotalOngoingOrderApiCall.fromJson(
        loginjsonCreation.toJson(),
      );
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForOrderDetails({
    String? customerId,
    String? leadId,
    String? tblName,
    required String language, required ,
  }) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      orderdetailscall loginjsonCreation = orderdetailscall(
        customerId: customerId!,
        leadId: leadId!,
        tblName: tblName!,
      );
      var result = orderdetailscall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonFordownloadfileapi({
    String? customerId,
    String? documentId,
    String? tblName,
  }) {
    try {
      JsonEncoder encoder = JsonEncoder.withIndent('');
      downloadfileapicall loginjsonCreation = downloadfileapicall(
        customerId: customerId!,
        document_id: documentId!,
        tblName: tblName!,
      );
      var result = downloadfileapicall.fromJson(loginjsonCreation.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  String createJsonForGetAllPackageOrdersapi(
    String customerId, {
    required int offset,
    required int limit,
    String? packageId,
    String? tblName, // Allow tblName to be null
    required String language, String? lead_id,
  }) {
    try {
      Map<String, dynamic> jsonMap = {
        "customer_id": customerId,
        "offset": offset,
        "limit": limit,
        "language": language,
        //"tbl_name": tblName, // Include tbl_name (can be null)
      };

      if (packageId != null && packageId.isNotEmpty) {
        jsonMap["package_id"] = packageId;
      }

      return json.encode(jsonMap);
    } catch (e) {
      print('Error creating JSON: $e');
      return '';
    }
  }
}
// lib/network/createjson.dart

//   String createJsonForOrderDetails({
//     required String customerId,
//     required String leadId,
//     required String tblName,
//     String? language,
//   }) {
//     Map<String, dynamic> json = {
//       "customer_id": customerId,
//       "lead_id": leadId,
//       "tbl_name": tblName,
//     };
//     if (language != null) {
//       json["lang"] = language; // Add language to API request
//     }
//     return jsonEncode(json);
//   }

//   String createJsonFordownloadfileapi({
//     required String customerId,
//     required String documentId,
//     required String tblName,
//   }) {
//     return jsonEncode({
//       "customer_id": customerId,
//       "document_id": documentId,
//       "tbl_name": tblName,
//     });
//   }
// }
