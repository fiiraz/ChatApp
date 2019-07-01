// To parse this JSON data, do
//
//     final reviews = reviewsFromJson(jsonString);

import 'dart:convert';

import 'package:simplefire/models/reviewer.dart';

List<Reviews> reviewsListFromJson(List<dynamic> str) {
  return new List<Reviews>.from(str.map((x) => Reviews.fromJson(x)));
}

Reviews reviewsFromJson(String str) {
  final jsonData = json.decode(str);
  return Reviews.fromJson(jsonData);
}

String reviewsToJson(Reviews data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Reviews {
  int id;
  int companyId;
  int thirdPartySourceId;
  int companyThirdPartyId;
  int reviewerId;
  String remoteId;
  dynamic replyId;
  String rate;
  String comment;
  bool isPublished;
  bool isAnonymous;
  String remoteCreatedAt;
  String remoteUpdatedAt;
  String createdAt;
  String updatedAt;
  Reviewer reviewer;
  String url;

  Reviews({
    this.id,
    this.companyId,
    this.thirdPartySourceId,
    this.companyThirdPartyId,
    this.reviewerId,
    this.remoteId,
    this.replyId,
    this.rate,
    this.comment,
    this.isPublished,
    this.isAnonymous,
    this.remoteCreatedAt,
    this.remoteUpdatedAt,
    this.createdAt,
    this.updatedAt,
    this.reviewer,
    this.url,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) => new Reviews(
    id: json["id"] == null ? null : json["id"],
    companyId: json["company_id"] == null ? null : json["company_id"],
    thirdPartySourceId: json["third_party_source_id"] == null ? null : json["third_party_source_id"],
    companyThirdPartyId: json["company_third_party_id"] == null ? null : json["company_third_party_id"],
    reviewerId: json["reviewer_id"] == null ? null : json["reviewer_id"],
    remoteId: json["remote_id"] == null ? null : json["remote_id"],
    replyId: json["reply_id"],
    rate: json["rate"] == null ? null : json["rate"],
    comment: json["comment"] == null ? null : json["comment"],
    isPublished: json["is_published"] == null ? null : json["is_published"],
    isAnonymous: json["is_anonymous"] == null ? null : json["is_anonymous"],
    remoteCreatedAt: json["remote_created_at"] == null ? null : json["remote_created_at"],
    remoteUpdatedAt: json["remote_updated_at"] == null ? null : json["remote_updated_at"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    reviewer: json["reviewer"] == null ? null : Reviewer.fromJson(json["reviewer"]),
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "company_id": companyId == null ? null : companyId,
    "third_party_source_id": thirdPartySourceId == null ? null : thirdPartySourceId,
    "company_third_party_id": companyThirdPartyId == null ? null : companyThirdPartyId,
    "reviewer_id": reviewerId == null ? null : reviewerId,
    "remote_id": remoteId == null ? null : remoteId,
    "reply_id": replyId,
    "rate": rate == null ? null : rate,
    "comment": comment == null ? null : comment,
    "is_published": isPublished == null ? null : isPublished,
    "is_anonymous": isAnonymous == null ? null : isAnonymous,
    "remote_created_at": remoteCreatedAt == null ? null : remoteCreatedAt,
    "remote_updated_at": remoteUpdatedAt == null ? null : remoteUpdatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "reviewer": reviewer == null ? null : reviewer.toJson(),
    "url": url == null ? null : url,
  };
}
