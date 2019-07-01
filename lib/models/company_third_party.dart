// To parse this JSON data, do
//
//     final companyThirdParty = companyThirdPartyFromJson(jsonString);

import 'dart:convert';

import 'package:simplefire/models/review.dart';
import 'package:simplefire/models/third_party_source.dart';

List<CompanyThirdParty> companyThirdPartiesFromJson(List<dynamic> str) {
  return new List<CompanyThirdParty>.from(str.map((x) => CompanyThirdParty.fromJson(x)));
}

CompanyThirdParty companyThirdPartyFromJson(String str) {
  final jsonData = json.decode(str);
  return CompanyThirdParty.fromJson(jsonData);
}

String companyThirdPartyToJson(CompanyThirdParty data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class CompanyThirdParty {
  int id;
  int thirdPartySourceId;
  String overallRate;
  int companyId;
  dynamic accessId;
  dynamic accessToken;
  bool isValid;
  dynamic remoteId;
  bool active;
  String createdAt;
  String updatedAt;
  ThirdPartySource thirdPartySource;
  List<Review> reviews;
  String url;

  CompanyThirdParty({
    this.id,
    this.thirdPartySourceId,
    this.overallRate,
    this.companyId,
    this.accessId,
    this.accessToken,
    this.isValid,
    this.remoteId,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.thirdPartySource,
    this.reviews,
    this.url,
  });

  factory CompanyThirdParty.fromJson(Map<String, dynamic> json) => new CompanyThirdParty(
    id: json["id"] == null ? null : json["id"],
    thirdPartySourceId: json["third_party_source_id"] == null ? null : json["third_party_source_id"],
    overallRate: json["overall_rate"] == null ? null : json["overall_rate"],
    companyId: json["company_id"] == null ? null : json["company_id"],
    accessId: json["access_id"],
    accessToken: json["access_token"],
    isValid: json["is_valid"] == null ? null : json["is_valid"],
    remoteId: json["remote_id"],
    active: json["active"] == null ? null : json["active"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    thirdPartySource: json["third_party_source"] == null ? null : ThirdPartySource.fromJson(json["third_party_source"]),
    reviews: json["reviews"] == null ? null : new List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "third_party_source_id": thirdPartySourceId == null ? null : thirdPartySourceId,
    "overall_rate": overallRate == null ? null : overallRate,
    "company_id": companyId == null ? null : companyId,
    "access_id": accessId,
    "access_token": accessToken,
    "is_valid": isValid == null ? null : isValid,
    "remote_id": remoteId,
    "active": active == null ? null : active,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "third_party_source": thirdPartySource == null ? null : thirdPartySource.toJson(),
    "reviews": reviews == null ? null : new List<dynamic>.from(reviews.map((x) => x.toJson())),
    "url": url == null ? null : url,
  };
}
