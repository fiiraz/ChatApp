import 'package:flutter/material.dart';

class BottomSnackBar {
  static getBar(text, duration, color, textColor, {buttonPressed}){
    return SnackBar(
      content: Text(text),
      backgroundColor: color,
      duration: duration,
      action: SnackBarAction(
        label: 'Ok',
        textColor: textColor,
        onPressed: () {
          buttonPressed();
        },
      ),
    );
  }
}


