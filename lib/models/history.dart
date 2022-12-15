import 'dart:convert';

import 'package:supply_chain/models/product.dart';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  History({
    required this.addressOwner,
    required this.addressBuyer,
    required this.description,
    required this.keyProduct,
    required this.idHistory,
    required this.idTransfer,
    required this.tx,
    required this.type,
    this.product,
  });

  final String addressOwner;
  final String addressBuyer;
  final String description;
  final String keyProduct;
  final String idHistory;
  final String idTransfer;
  final String tx;
  final String type;
  Product? product;

  factory History.fromJson(Map<String, dynamic> json) => History(
        addressOwner: json["addressOwner"],
        addressBuyer: json["addressBuyer"],
        description: json["description"],
        keyProduct: json["keyProduct"],
        idHistory: json["idHistory"].toString(),
        idTransfer: json["idTransfer"],
        tx: json["tx"],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        "addressOwner": addressOwner,
        "addressBuyer": addressBuyer,
        "keyProduct": keyProduct,
        "idTransfer": idTransfer,
        "idHistory": int.parse(idHistory),
        "tx": tx,
        "type": type,
      };
}
