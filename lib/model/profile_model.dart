import 'dart:convert';

import 'package:isar/isar.dart';

part 'profile_model.g.dart';

List<ProfileModel> profileModelFromJson(String str) => List<ProfileModel>.from(
    json.decode(str).map((x) => ProfileModel.fromJson(x)));

String profileModelToJson(List<ProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@collection
class ProfileModel {
  Id? id;
  String? name;
  String? username;
  String? email;
  AddressModel? address;
  String? phone;
  String? website;
  Company? company;

  ProfileModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  ProfileModel copyWith({
    Id? id,
    String? name,
    String? username,
    String? email,
    AddressModel? address,
    String? phone,
    String? website,
    Company? company,
  }) =>
      ProfileModel(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        website: website ?? this.website,
        company: company ?? this.company,
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
        phone: json["phone"],
        website: json["website"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address?.toJson(),
        "phone": phone,
        "website": website,
        "company": company?.toJson(),
      };
}

@embedded
class AddressModel {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  AddressModel({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  AddressModel copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    Geo? geo,
  }) =>
      AddressModel(
        street: street ?? this.street,
        suite: suite ?? this.suite,
        city: city ?? this.city,
        zipcode: zipcode ?? this.zipcode,
        geo: geo ?? this.geo,
      );

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: json["geo"] == null ? null : Geo.fromJson(json["geo"]),
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "geo": geo?.toJson(),
      };

  @override
  String toString() {
    return "$suite, $street, $city, $zipcode";
  }
}

@embedded
class Geo {
  String? lat;
  String? lng;

  Geo({
    this.lat,
    this.lng,
  });

  Geo copyWith({
    String? lat,
    String? lng,
  }) =>
      Geo(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

@embedded
class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  Company copyWith({
    String? name,
    String? catchPhrase,
    String? bs,
  }) =>
      Company(
        name: name ?? this.name,
        catchPhrase: catchPhrase ?? this.catchPhrase,
        bs: bs ?? this.bs,
      );

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "catchPhrase": catchPhrase,
        "bs": bs,
      };
}
