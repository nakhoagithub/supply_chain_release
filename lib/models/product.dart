import 'dart:convert';

import 'ingredient.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

/// `type` là kiểu sản phẩm (Không thể thay đổi)
///
/// Có các kiểu product như
///
/// `create`
/// `transfer`
///
class Product {
  Product({
    required this.name,
    this.description,
    required this.code,
    this.linkImage,
    this.id,
    required this.type,
    this.idHistory,
    this.ingredients,
  });

  String name;
  String? description;
  String code;
  String? linkImage;
  String? id;
  String type;
  String? idHistory;
  List<Ingredient>? ingredients;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        code: json["code"],
        linkImage: json["linkImage"],
        type: json['type'],
        idHistory: json['idHistory'],
        ingredients: json["ingredients"] == null
            ? null
            : List<Ingredient>.from(
                json["ingredients"].map((x) => Ingredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "code": code,
        "linkImage": linkImage,
        "type": type,
        "idHistory": idHistory,
        "ingredients": ingredients == null
            ? null
            : List<dynamic>.from(ingredients!.map((x) => x.toJson())),
      };
}
