import 'dart:convert';

Address addressFromJson(String str) {
  final jsonData = json.decode(str);
  return Address.fromJson(jsonData);
}

String addressToJson(Address data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Address {
  int id;
  String title;
  String fullAddress;
  String streetName;
  String subNumber;
  String town;
  String city;
  String state;
  String zipCode;
  double latitude;
  double longitude;
  String googlePlaceId;
  String createdAt;
  String updatedAt;
  String url;

  Address({
    this.id,
    this.title,
    this.fullAddress,
    this.streetName,
    this.subNumber,
    this.town,
    this.city,
    this.state,
    this.zipCode,
    this.latitude,
    this.longitude,
    this.googlePlaceId,
    this.createdAt,
    this.updatedAt,
    this.url,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      new Address(
        id: json["id"],
        title: json["title"],
        fullAddress: json["full_address"],
        streetName: json["street_name"],
        subNumber: json["sub_number"],
        town: json["town"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        googlePlaceId: json["google_place_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "title": title,
        "full_address": fullAddress,
        "street_name": streetName,
        "sub_number": subNumber,
        "town": town,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "latitude": latitude,
        "longitude": longitude,
        "google_place_id": googlePlaceId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "url": url,
      };
}