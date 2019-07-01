import 'application_model.dart';
import 'dart:convert';

List<BusinessType> businessTypesFromJson(List<dynamic> str) {
  return new List<BusinessType>.from(str.map((x) => BusinessType.fromJson(x)));
}

BusinessType businessTypeFromJson(String str) {
  final jsonData = json.decode(str);
  return BusinessType.fromJson(jsonData);
}

String businessTypeToJson(BusinessType data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class BusinessType extends ApplicationModel {
  int id;
  String name;
  String description;
  String createdAt;
  String updatedAt;
  String url;

  BusinessType({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.url,
  });

  factory BusinessType.fromJson(Map<String, dynamic> json) => new BusinessType(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "url": url,
  };
}
