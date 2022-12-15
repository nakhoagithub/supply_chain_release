import 'dart:convert';

import 'package:supply_chain/models/product.dart';

Transfer transferFromJson(String str) => Transfer.fromJson(json.decode(str));

String transferToJson(Transfer data) => json.encode(data.toJson());

class Transfer {
  Transfer({
    required this.addressOwner,
    required this.addressBuyer,
    // required this.count,
    // required this.countingUnit,
    // required this.price,
    // required this.currency,
    required this.description,
    required this.keyProduct,
    required this.idTransfer,
    required this.idHistory,
    required this.type,
    this.product,
  });

  final String addressOwner;
  final String addressBuyer;
  // final String count;
  // final String countingUnit;
  // final String price;
  // final String currency;
  final String description;
  final String keyProduct;
  final String idTransfer;
  final String idHistory;
  final String type;
  Product? product;

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
        addressOwner: json["addressOwner"],
        addressBuyer: json["addressBuyer"],
        // count: json["count"],
        // countingUnit: json["countingUnit"],
        // price: json["price"],
        // currency: json['currency'],
        description: json["description"],
        keyProduct: json["keyProduct"],
        idTransfer: json["idTransfer"],
        idHistory: json["idHistory"].toString(),
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        "addressOwner": addressOwner,
        "addressBuyer": addressBuyer,
        // "count": count,
        // "countingUnit": countingUnit,
        // "price": price,
        // "currency": currency,
        "description": description,
        "keyProduct": keyProduct,
        "idTransfer": idTransfer,
        "idHistory": int.parse(idHistory),
        "type": type,
      };
}
