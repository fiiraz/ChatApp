// To parse this JSON data, do
//
//     final thirdPartySource = thirdPartySourceFromJson(jsonString);

import 'dart:convert';

List<ThirdPartySource> thirdPartiesSourcesFromJson(List<dynamic> str) {
  return new List<ThirdPartySource>.from(str.map((x) => ThirdPartySource.fromJson(x)));
}

ThirdPartySource thirdPartySourceFromJson(String str) {
  final jsonData = json.decode(str);
  return ThirdPartySource.fromJson(jsonData);
}

String thirdPartySourceToJson(ThirdPartySource data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class ThirdPartySource {
  int id;
  String name;
  String title;
  String logoUrl;
  bool isActive;
  String customerServiceNumber;
  String customerServiceEmail;
  String contactFormUrl;
  String helpDeskUrl;
  String createdAt;
  String updatedAt;
  String url;

  ThirdPartySource({
    this.id,
    this.name,
    this.title,
    this.logoUrl,
    this.isActive,
    this.customerServiceNumber,
    this.customerServiceEmail,
    this.contactFormUrl,
    this.helpDeskUrl,
    this.createdAt,
    this.updatedAt,
    this.url,
  });

  factory ThirdPartySource.fromJson(Map<String, dynamic> json) => new ThirdPartySource(
    id: json["id"],
    name: json["name"],
    title: json["title"],
    logoUrl: json["logo_url"],
    isActive: json["is_active"],
    customerServiceNumber: json["customer_service_number"],
    customerServiceEmail: json["customer_service_email"],
    contactFormUrl: json["contact_form_url"],
    helpDeskUrl: json["help_desk_url"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "logo_url": logoUrl,
    "is_active": isActive,
    "customer_service_number": customerServiceNumber,
    "customer_service_email": customerServiceEmail,
    "contact_form_url": contactFormUrl,
    "help_desk_url": helpDeskUrl,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "url": url,
  };
}
