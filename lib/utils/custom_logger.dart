import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static var logger = Logger();

  static appLogD({required tag, required message}) {
    if (kDebugMode) {
      kIsWeb ? debugPrint("$tag: $message") : logger.d("$tag: $message");
    }
  }

  static appLogI({required tag, required message}) {
    if (kDebugMode) {
      kIsWeb ? debugPrint("$tag: $message") : logger.i("$tag: $message");
    }
  }

  static appLogE({required tag, required message}) {
    if (kDebugMode) {
      kIsWeb ? debugPrint("$tag: $message") : logger.e("$tag: $message");
    }
  }

}