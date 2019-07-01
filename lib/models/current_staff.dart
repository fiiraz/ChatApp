import 'application_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplefire/helpers/database_helper.dart';

CurrentStaff currentStaffFromJson(String str) {
  final jsonData = json.decode(str);
  return CurrentStaff.fromJson(jsonData);
}

String currentStaffToJson(CurrentStaff data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class CurrentStaff extends ApplicationModel {
  int id;
  String email;
  String provider;
  int companyId;
  int staffPositionId;
  String firstName;
  String lastName;
  bool isOwner;
  String uid;
  String middleName;
  bool isBanned;
  String password;
  String accessToken;
  String client;

  CurrentStaff({
    this.id,
    this.email,
    this.provider,
    this.companyId,
    this.staffPositionId,
    this.firstName,
    this.lastName,
    this.isOwner,
    this.uid,
    this.middleName,
    this.isBanned,
    this.password,
    this.accessToken,
    this.client,
  });

  factory CurrentStaff.fromJson(Map<String, dynamic> json) => new CurrentStaff(
        id: json["id"],
        email: json["email"],
        provider: json["provider"],
        companyId: json["company_id"],
        staffPositionId: json["staff_position_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isOwner: json["is_owner"],
        uid: json["uid"],
        middleName: json["middle_name"],
        isBanned: json["is_banned"],
        password: json["password"],
        accessToken: json["access_token"],
        client: json["client"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "provider": provider,
        "company_id": companyId,
        "staff_position_id": staffPositionId,
        "first_name": firstName,
        "last_name": lastName,
        "is_owner": isOwner,
        "uid": uid,
        "middle_name": middleName,
        "is_banned": isBanned,
        "password": password,
        "access_token": accessToken,
        "client": client,
      };

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', this.accessToken);
    await prefs.setString('client', this.client);
    await prefs.setString('uid', this.uid);
    await prefs.setBool('isLoggedIn', true);
    var db = new DatabaseHelper();
    await db.save("CurrentStaff", currentStaffToJson(this));
  }

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    var db = new DatabaseHelper();
    await db.deleteAll();
  }
}
