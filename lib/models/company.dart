// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  String? name;
  String? address;
  String? email;
  String? addressCompany;
  String? description;
  String? linkImage;

  Company({
    this.name,
    this.address,
    this.email,
    this.addressCompany,
    this.description,
    this.linkImage,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        address: json["address"],
        email: json["email"],
        addressCompany: json["addressCompany"],
        description: json["description"],
        linkImage: json["linkImage"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "email": email,
        "addressCompany": addressCompany,
        "description": description,
        "linkImage": linkImage,
      };
}
