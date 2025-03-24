import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static Future<void> show(String message, {ToastGravity gravity = ToastGravity.BOTTOM}) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.blue,
      fontSize: 16.sp,
    );
  }
}
