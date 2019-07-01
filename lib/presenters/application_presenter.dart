import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplefire/api/resources.dart';
import 'package:simplefire/helpers/database_helper.dart';
import 'package:simplefire/helpers/global_event.dart';
import 'package:simplefire/helpers/globals.dart';
import 'package:simplefire/models/company.dart';
import 'package:simplefire/models/current_staff.dart';
import 'package:simplefire/screens/application_screen.dart';
import 'package:simplefire/screens/layouts/dialog.dart';
import 'package:simplefire/screens/layouts/snack_bar.dart';
import 'package:simplefire/screens/layouts/theme.dart';

class ApplicationPresenter {
  var screen;
  ApiResources api = new ApiResources();
  ApplicationScreen applicationScreen;
  StreamSubscription globalEventSubscription;

  int footerBarIndex = 0;

  ApplicationPresenter(screen) : super() {
    this.screen = screen;
    this.applicationScreen = ApplicationScreen(screen);
    globalEventSubscription = globalEventController.stream
        .listen((globalEvent) => _processGlobalStream(globalEvent));
    checkCurrentStaff();
  }

  checkCurrentStaff() {
    isLoggedIn().then((isLogged) {
      if (!isLogged) {
        Navigator.pushNamedAndRemoveUntil(screen.context, "/login", (Route<dynamic> route) => false);
      }
    });
  }

  Future<dynamic> getPrefence(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.get(key.toString());
    return result;
  }

  Future<dynamic> setPrefence(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.setString(key.toString(), value.toString());
    return result;
  }

  Future<bool> isLoggedIn() async {
    var result = await getPrefence("isLoggedIn");
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }

  Future<CurrentStaff> getCurrentStaff() async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      var value = await databaseHelper.find("CurrentStaff");
      return currentStaffFromJson(value);
    } catch (e) {
      CurrentStaff.logout();
      return new CurrentStaff();
    }
  }


  Future<Company> getCurrentCompany() async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      var value = await databaseHelper.find("CurrentCompany");
      return companyFromJson(value);
    } catch (e) {
      await CurrentStaff.logout();
      return new Company();
    }
  }

  showIndicator() {
    applicationScreen.refreshState(true);
  }

  hideIndicator() {
    applicationScreen.refreshState(false);
  }

  showSnackBar(text, {duration: 4, buttonPressed, theme, color, textColor}) {
    if (color == null && textColor == null) {
      var type = AppTheme.notificationTypes(theme);
      color = type[0];
      textColor = type[1];
    }

    if (buttonPressed == null) {
      buttonPressed = dismissSnackBar;
    }
    if (applicationScreen.scaffoldKey.currentState != null) {
      applicationScreen.scaffoldKey.currentState.showSnackBar(
          BottomSnackBar.getBar(
              text, Duration(seconds: duration), color, textColor,
              buttonPressed: buttonPressed));
    }
  }

  dismissSnackBar() {
    applicationScreen.scaffoldKey.currentState
        .removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
  }

  popupNotification(type, text, {delayTime}) {
    if (delayTime == null) {
      globalEventController.add(new GlobalEvent(type, "view", message: text));
    } else {
      Future.delayed(Duration(seconds: delayTime), () {
        globalEventController.add(new GlobalEvent(type, "view", message: text));
      });
    }
  }

  showDialogBox(controller, text, buttonText, {value}) {
    showDialog(
      context: screen.context,
      builder: (BuildContext context) {
        return showDialogBuilder(controller, context, text, buttonText,
            value: value);
      },
    );
  }

  void dispose() {
    globalEventSubscription.cancel();
  }

  _processGlobalStream(globalEvent) {
    if (screen.mounted) {
      if (globalEvent.scope == "error") {
        showSnackBar(globalEvent.message, theme: "error");
      } else if (globalEvent.scope == "notice") {
        showSnackBar(globalEvent.message, theme: "info");
      } else {
        showSnackBar(globalEvent.message);
      }
      print("GlobalStream: {key: " +
          globalEvent.scope +
          "} {value: " +
          globalEvent.action +
          "} {message: " +
          globalEvent.message +
          "}");
    }
  }
}
