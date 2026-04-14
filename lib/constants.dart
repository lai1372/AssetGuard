import 'package:flutter/foundation.dart';

class Constants {
  // Gets the base URL for the API depending on the platform the app is running on.
  // For Android emulators, 'localhost' refers to the emulator itself, so it uses '10.0.2.2' instead.
  static String get apiBaseUrl {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8080';
    } else {
      return 'http://localhost:8080';
    }
  }

  // Database constants
  static const String db = 'assetguard.db';
  static const int dbVersion = 1;

  // Sync status constants
  static const String syncPending = 'pending';
  static const String syncSynced = 'synced';
  static const String syncFailed = 'failed';
}
