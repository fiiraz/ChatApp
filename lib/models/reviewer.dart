// To parse this JSON data, do
//
//     final reviewer = reviewerFromJson(jsonString);

import 'dart:convert';

List<Reviewer> reviewersFromJson(List<dynamic> str) {
  return new List<Reviewer>.from(str.map((x) => Reviewer.fromJson(x)));
}

Reviewer reviewerFromJson(String str) {
  final jsonData = json.decode(str);
  return Reviewer.fromJson(jsonData);
}

String reviewerToJson(Reviewer data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Reviewer {
  int id;
  String title;
  dynamic name;
  dynamic email;
  String phone;
  dynamic metadata;
  dynamic companyStaffId;
  String lastPhotoUrl;
  String createdAt;
  String updatedAt;
  String url;

  Reviewer({
    this.id,
    this.title,
    this.name,
    this.email,
    this.phone,
    this.metadata,
    this.companyStaffId,
    this.lastPhotoUrl,
    this.createdAt,
    this.updatedAt,
    this.url,
  });

  factory Reviewer.fromJson(Map<String, dynamic> json) => new Reviewer(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    metadata: json["metadata"],
    companyStaffId: json["company_staff_id"],
    lastPhotoUrl: json["last_photo_url"] == null ? null : json["last_photo_url"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "name": name,
    "email": email,
    "phone": phone == null ? null : phone,
    "metadata": metadata,
    "company_staff_id": companyStaffId,
    "last_photo_url": lastPhotoUrl == null ? null : lastPhotoUrl,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "url": url == null ? null : url,
  };
}
