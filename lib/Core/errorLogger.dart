// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class ErrorLogger {
  static final ErrorLogger _instance = ErrorLogger._internal();

  factory ErrorLogger() {
    return _instance;
  }

  ErrorLogger._internal();

  /// Initialize Firebase Crashlytics
  // Future<void> init() async {
  //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  //   PlatformDispatcher.instance.onError = (error, stack) {
  //     FirebaseCrashlytics.instance.recordError(error, stack);
  //     return true; // Prevent the default handler from running
  //   };
  //   debugPrint("ErrorLogger initialized with Firebase Crashlytics.");
  // }

  /// Log an error to Firebase Crashlytics
  Future<void> logError({
    required String errorMessage, // Required error message
    String? errorLocation, // Optional location of the error
    String? userId, // Optional user identifier
    dynamic errorDetails, // Optional additional details
    StackTrace? stackTrace, // Optional stack trace
  }) async {
    // try {
    //   // Add custom keys for userId and receiverId
    //   if (userId != null) {
    //     await FirebaseCrashlytics.instance.setCustomKey('userId', userId);
    //   }

    //   // Add custom keys for additional error context
    //   if (errorLocation != null) {
    //     await FirebaseCrashlytics.instance
    //         .setCustomKey('errorLocation', errorLocation);
    //   }
    //   if (errorDetails != null) {
    //     await FirebaseCrashlytics.instance
    //         .setCustomKey('errorDetails', errorDetails.toString());
    //   }

    //   // Log a non-fatal error
    //   FirebaseCrashlytics.instance.log(
    //     "Error logged: $errorMessage at $errorLocation with details: ${errorDetails ?? 'None'}",
    //   );

    //   FirebaseCrashlytics.instance.recordError(
    //     Exception(errorMessage),
    //     stackTrace,
    //     reason: 'Error occurred at $errorLocation',
    //     fatal: false,
    //   );

    //   debugPrint("Error logged to Firebase Crashlytics.");
    // } catch (e) {
    //   debugPrint("Failed to log error to Firebase Crashlytics: $e");
    // }
  }

  Future<void> setUserId(String userId) async {
    try {
      // await FirebaseCrashlytics.instance.setUserIdentifier(userId);
      debugPrint("User ID set to Firebase Crashlytics: $userId");
    } catch (e) {
      debugPrint("Failed to set user ID: $e");
    }
  }
}
