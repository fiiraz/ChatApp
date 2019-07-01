import 'package:simplefire/helpers/database_helper.dart';

import 'application_model.dart';
import 'address.dart';
import 'company_staff.dart';
import 'dart:convert';

Company companyFromJson(String str) {
  final jsonData = json.decode(str);
  return Company.fromJson(jsonData);
}

String companyToJson(Company data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Company extends ApplicationModel {
  int id;
  int businessTypeId;
  String overallRate;
  String name;
  String phone;
  String phoneExt;
  String faxNumber;
  String email;
  int addressId;
  String createdAt;
  String updatedAt;
  String url;
  Address address;
  List<CompanyStaff> companyStaffs;

  Company({
    this.id,
    this.businessTypeId,
    this.overallRate,
    this.name,
    this.phone,
    this.phoneExt,
    this.faxNumber,
    this.email,
    this.addressId,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.address,
    this.companyStaffs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => new Company(
    id: json["id"],
    businessTypeId: json["business_type_id"],
    overallRate: json["overall_rate"],
    name: json["name"],
    phone: json["phone"],
    phoneExt: json["phone_ext"],
    faxNumber: json["fax_number"],
    email: json["email"],
    addressId: json["address_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    url: json["url"],
    address: Address.fromJson(json["address"]),
    companyStaffs: new List<CompanyStaff>.from(json["company_staffs"].map((x) => CompanyStaff.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_type_id": businessTypeId,
    "overall_rate": overallRate,
    "name": name,
    "phone": phone,
    "phone_ext": phoneExt,
    "fax_number": faxNumber,
    "email": email,
    "address_id": addressId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "url": url,
    "address": address.toJson(),
    "company_staffs": new List<dynamic>.from(companyStaffs.map((x) => x.toJson())),
  };

  CompanyStaff buildCompanyStaff() {
    if (this.companyStaffs == null) {
      this.companyStaffs = List<CompanyStaff>();
    }
    CompanyStaff newStaff =  CompanyStaff();
    this.companyStaffs.add(newStaff);
    return newStaff;
  }

  Address buildAddress() {
    if (this.address == null) {
      this.address = Address();
    }
    return this.address;
  }

  Map<String, dynamic> toJsonCreate() => {
    "id": id,
    "business_type_id": businessTypeId,
    "overall_rate": overallRate,
    "name": name,
    "phone": phone,
    "phone_ext": phoneExt,
    "fax_number": faxNumber,
    "email": email,
    "address_id": addressId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "url": url,
    "address_attributes": address.toJson(),
    "company_staffs_attributes": new List<dynamic>.from(companyStaffs.map((x) => x.toJson())),
  };

  void saveCurrentCompany() async {
    var db = new DatabaseHelper();
    await db.save("CurrentCompany", companyToJson(this));
  }
}
