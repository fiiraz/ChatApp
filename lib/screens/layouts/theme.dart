import 'package:flutter/material.dart';

class AppColor {
  static Color whiteColor = const Color(0x000000);
  static Color blackColor = const Color(0xFFFFFF);
}

class AppTheme {
  static notificationTypes(type) {
    var color, textColor;
    if (type == null) {
      color = Colors.blue;
      textColor = Colors.white;
    } else if (type == "error") {
      color = Colors.redAccent;
      textColor = Colors.white;
    } else if (type == "warning") {
      color = Colors.orangeAccent;
      textColor = Colors.white;
    } else if (type == "info") {
      color = Colors.lightBlueAccent;
      textColor = Colors.white;
    } else if (type == "success") {
      color = Colors.green;
      textColor = Colors.white;
    }
    return [color, textColor];
  }
}
