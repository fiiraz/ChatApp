import 'dart:convert';
import 'package:simplefire/helpers/global_event.dart';
import 'package:simplefire/helpers/globals.dart';

class ResponseErrorHandler {
  final JsonDecoder _decoder = new JsonDecoder();
  int statusCode;
  String body;
  String errorMessage = "";

  ResponseErrorHandler(statusCode, body) {
    this.statusCode = statusCode;
    this.body = body;
    try {
      this.errorMessage = _decoder.convert(body)["errors"][0];
    } catch (e) {}
    errorSwitch();
  }

  @override
  void errorSwitch() {
    if (statusCode > 400 && statusCode < 500) {
      if (errorMessage == "") {
        errorMessage = "You are not authorised to access this source";
      }
      globalEventController
          .add(new GlobalEvent("error", "network", message: errorMessage));
    } else if (statusCode >= 500) {
      globalEventController.add(new GlobalEvent("error", "network",
          message: "Server connection was failed"));
    }
  }
}

class UnknownException {
  static void unknownExceptionHandling(var e) {}
}
