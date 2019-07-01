import 'application_model.dart';
import 'dart:convert';

List<CompanyStaff> companyStaffsFromJson(List<dynamic> str) {
  return new List<CompanyStaff>.from(str.map((x) => CompanyStaff.fromJson(x)));
}

CompanyStaff companyStaffFromJson(String str) {
  final jsonData = json.decode(str);
  return CompanyStaff.fromJson(jsonData);
}

String companyStaffToJson(CompanyStaff data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class CompanyStaff extends ApplicationModel {
  int id;
  String email;
  int companyId;
  int staffPositionId;
  String firstName;
  String lastName;
  String middleName;
  String nickname;
  bool isBanned;
  bool isOwner;
  String createdAt;
  String updatedAt;
  String url;
  String password;
  String passwordConfirmation;

  CompanyStaff({
    this.id,
    this.email,
    this.companyId,
    this.staffPositionId,
    this.firstName,
    this.lastName,
    this.middleName,
    this.nickname,
    this.isBanned,
    this.isOwner,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.password,
    this.passwordConfirmation,
  });

  factory CompanyStaff.fromJson(Map<String, dynamic> json) => new CompanyStaff(
    id: json["id"],
    email: json["email"],
    companyId: json["company_id"],
    staffPositionId: json["staff_position_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    middleName: json["middle_name"],
    nickname: json["nickname"],
    isBanned: json["is_banned"],
    isOwner: json["is_owner"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    url: json["url"],
    password: json["password"],
    passwordConfirmation: json["password_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "company_id": companyId,
    "staff_position_id": staffPositionId,
    "first_name": firstName,
    "last_name": lastName,
    "middle_name": middleName,
    "nickname": nickname,
    "is_banned": isBanned,
    "is_owner": isOwner,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "url": url,
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}