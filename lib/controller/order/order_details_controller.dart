import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/response/order_details_api_response.dart';
import '../../network/response/download_file_api_response.dart';
import '../../network/url.dart';
import '../order/language controller.dart'; // Import LanguageController

class OrderDetailsController extends GetxController {
  RxList<OrderDetailsApiResponseDatum> orderDetails =
      <OrderDetailsApiResponseDatum>[].obs;
  RxBool isLoading = false.obs;
  RxString filePath = ''.obs;
  RxString selectedDocumentId = ''.obs;
  final LanguageController languageController = Get.find<LanguageController>();
  RxMap<String, bool> downloadStatus = <String, bool>{}.obs;
  static var refreshPackages;

  Future<void> fetchOrderDetails(
    String customerId,
    String leadId,
    String tblName,
  ) async {
    try {
      isLoading.value = true;
      orderDetails.clear();
      filePath.value = '';
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? customerid1 = prefs.getString('customer_id');

      String lang = languageController.isToggled.value ? 'mr' : 'en';
      String createJson = Createjson().createJsonForOrderDetails(
        customerId: customerid1,
        leadId: leadId,

        tblName: tblName,
        language: lang, // Pass language to API
      );

      List<Object?>? list = await Networkcall().postMethod(
        URLS().order_details,

        URLS().order_detailsUrl,
        //URLS().get_all_service_packageapiUrl,
        createJson,
        Get.context!,
      );

      if (list != null) {
        List<OrderDetailsApiResponse> response = List.from(list);
        if (response.isNotEmpty && response[0].status == "true") {
          orderDetails.assignAll(response[0].data);
          filePath.value = response[0].filePath;
        }
      }
    } catch (e) {
      print('Error fetching order details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> downloadFile(
    String customerId,
    String documentId,
    String tblName,
  ) async {
    try {
      String createJson = Createjson().createJsonFordownloadfileapi(
        customerId: customerId,
        documentId: documentId,
        tblName: tblName,
      );

      List<Object?>? list = await Networkcall().postMethod(
        URLS().download_file,
        URLS().download_fileUrl,
        createJson,
        Get.context!,
      );

      if (list != null) {
        List<DownloadFileApiResponse> response = List.from(list);
        if (response.isNotEmpty && response[0].status == "true") {
          final doc = orderDetails.firstWhere(
            (d) => d.documentId == documentId,
          );
          doc.isView = "1";
          orderDetails.refresh();
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Error marking file as downloaded: $e');
      Get.snackbar("Error", "Failed to mark file as downloaded");
      return false;
    }
  }

  // Future<void> _downloadImage(String url) async {
  //   try {
  //     // Check and request permission
  //     if (Platform.isAndroid) {
  //       if (await Permission.storage.isDenied) {
  //         await Permission.storage.request();
  //       }
  //       if (await Permission.manageExternalStorage.isDenied) {
  //         await Permission.manageExternalStorage.request();
  //       }
  //     }

  //     // Check again if permission is granted
  //     if (!(await Permission.storage.isGranted) &&
  //         !(await Permission.manageExternalStorage.isGranted)) {
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(
  //         SnackBar(
  //           content: Text('Storage permission is required to download files.'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }

  //     // Get the Downloads directory
  //     final directory = Directory('/storage/emulated/0/Download');
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //     final timestamp = DateTime.now().millisecondsSinceEpoch;
  //     final filePath = '${directory.path}/downloaded_image_$timestamp.jpg';
  //     // Define file path
  //     // final filePath = '${directory.path}/downloaded_image.jpg';

  //     // Create a Dio instance
  //     final dio = Dio();

  //     // Start downloading
  //     await dio.download(
  //       url,
  //       filePath,
  //       onReceiveProgress: (received, total) {
  //         if (total != -1) {
  //           print('${(received / total * 100).toStringAsFixed(0)}%');
  //         }
  //       },
  //     );

  //     // Notify user
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(
  //       SnackBar(
  //         content: Text('Download complete: $filePath'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(
  //       SnackBar(
  //         content: Text('Error downloading image: $e'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  Future<void> _downloadImage(String url) async {
    try {
      // Check and request permission
      if (Platform.isAndroid) {
        if (await Permission.storage.isDenied) {
          await Permission.storage.request();
        }
        if (await Permission.manageExternalStorage.isDenied) {
          await Permission.manageExternalStorage.request();
        }
      }

      // Check again if permission is granted
      if (!(await Permission.storage.isGranted) &&
          !(await Permission.manageExternalStorage.isGranted)) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Storage permission is required to download files.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Get the Downloads directory
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Extract file extension from URL
      String fileExtension = 'jpg'; // Default extension
      String fileName = url.split('/').last.toLowerCase();
      if (fileName.contains('.')) {
        fileExtension = fileName.split('.').last;
      }

      // List of supported extensions
      const supportedExtensions = [
        'pdf',
        'doc',
        'jpg',
        'png',
        'txt',
        'xls',
        'xlsx',
        'docx',
      ];

      // Validate extension, fallback to jpg if not supported
      if (!supportedExtensions.contains(fileExtension)) {
        fileExtension = 'jpg';
      }

      // Generate unique filename with timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath =
          '${directory.path}/downloaded_file_$timestamp.$fileExtension';

      // Create a Dio instance
      final dio = Dio();

      // Start downloading
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );

      // Determine file type for user feedback
      String fileType;
      switch (fileExtension) {
        case 'pdf':
          fileType = 'PDF';
          break;
        case 'doc':
        case 'docx':
          fileType = 'Document';
          break;
        case 'jpg':
        case 'png':
          fileType = 'Image';
          break;
        case 'txt':
          fileType = 'Text';
          break;
        case 'xls':
        case 'xlsx':
          fileType = 'Spreadsheet';
          break;
        default:
          fileType = 'File';
      }

      // Notify user
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('$fileType downloaded successfully: $filePath'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Error downloading file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> downloadDocument(String fileName) async {
    String fileUrl = "${filePath.value}$fileName";
    log("FileURL : $fileUrl");
    await _downloadImage(fileUrl);
  }
}
