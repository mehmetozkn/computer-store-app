import 'package:computer_store_app/core/extension/string_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastMessage {
  static ToastMessage? _instance;
  static ToastMessage get instance {
    _instance ??= ToastMessage._init();
    return _instance!;
  }

  ToastMessage._init();

  buildMessage(String text) {
    Fluttertoast.showToast(
      msg: text.locale,
      timeInSecForIosWeb: 1,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 14,
    );
  }
}
