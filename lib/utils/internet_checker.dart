import 'dart:io';
import 'package:flutter/foundation.dart';

class InternetChecker {
  Future<int> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (kDebugMode) {
          print('connected');
        }
        return 200;
      } else {
        return 202;
      }
    } on SocketException catch (_) {
      if (kDebugMode) {
        print('not connected');
      }
      return 202;
    }
  }
}
