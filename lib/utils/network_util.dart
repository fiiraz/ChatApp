import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplefire/helpers/error_handler.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();
  final JsonEncoder _encoder = new JsonEncoder();

  var headers = {"Content-Type": "application/json"};

  Future<dynamic> get(url, {with_auth: true, params}) {
    return SharedPreferences.getInstance().then((prefs) {
      if (with_auth) {
        headers = {
          "Content-Type": "application/json",
          "access-token": prefs.getString("accessToken"),
          "client": prefs.getString("client"),
          "uid": prefs.getString("uid"),
        };
      }
      return http
          .get(
        url + paramsToUrl(params),
        headers: headers,
      )
          .then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;
        ResponseErrorHandler(statusCode, res);
        if (statusCode == 401) {
          prefs.clear();
          return null;
        } else if (statusCode < 200 || statusCode > 400 || res == null) {
          return null;
        } else {
          return _decoder.convert(res);
        }
      }).catchError((onError) {
        ResponseErrorHandler(503, "");
        return null;
      });;
    });
  }

  Future<dynamic> post(url, body, {bool with_auth: true, params}) {
    return SharedPreferences.getInstance().then((prefs) {
      if (with_auth) {
        headers = {
          "Content-Type": "application/json",
          "access-token": prefs.getString("accessToken"),
          "client": prefs.getString("client"),
          "uid": prefs.getString("uid"),
        };
      }
      return http
          .post(url + paramsToUrl(params),
          body: _encoder.convert(body),
          headers: headers,
          encoding: Encoding.getByName("utf-8"))
          .then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;
        ResponseErrorHandler(statusCode, res);

        if (statusCode == 401) {
          prefs.clear();
          return null;
        } else if (statusCode < 200 || statusCode > 400 || res == null) {
          return null;
        } else {
          return _decoder.convert(res);
        }
      }).catchError((onError) {
        ResponseErrorHandler(503, "");
        return null;
      });;
    });
  }

  Future<bool> delete(url, {with_auth: true, params}) {
    return SharedPreferences.getInstance().then((prefs) {
      if (with_auth) {
        headers = {
          "Content-Type": "application/json",
          "access-token": prefs.getString("accessToken"),
          "client": prefs.getString("client"),
          "uid": prefs.getString("uid"),
        };
      }
      return http
          .delete(
        url + paramsToUrl(params),
        headers: headers,
      )
          .then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;
        ResponseErrorHandler(statusCode, res);
        if (statusCode == 401) {
          prefs.clear();
          return false;
        } else if (statusCode < 200 || statusCode > 400 || res == null) {
          return false;
        } else {
          return true;
        }
      }).catchError((onError) {
        ResponseErrorHandler(503, "");
        return false;
      });;
    });
  }


  Future<dynamic> postRaw(url, body, headers) {
    return http
        .post(url,
        body: body, headers: headers, encoding: Encoding.getByName("utf-8"))
        .then((http.Response response) {
      ResponseErrorHandler(response.statusCode, response.body);
      return response;
    }).catchError((onError) {
      ResponseErrorHandler(503, "");
      return new http.Response("", 503);
    });
  }

  Future<dynamic> getRaw(url, body, headers) {
    return http
        .post(url,
        body: body, headers: headers, encoding: Encoding.getByName("utf-8"))
        .then((http.Response response) {
      ResponseErrorHandler(response.statusCode, response.body);
      return response;
    }).catchError((onError) {
      ResponseErrorHandler(503, "");
      return new http.Response("", 503);
    });
  }

  static paramsToUrl(params) {
    if (params == null) {
      return "";
    } else {
      var lastStatement = "";
      params.forEach((key, value) {
        if (lastStatement.length == 0) {
          lastStatement = lastStatement + "?$key=$value";
        } else {
          lastStatement = "$lastStatement&$key=$value";
        }
      });
      return lastStatement;
    }
  }
}
