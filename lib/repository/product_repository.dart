import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';

import '../models/ingredient.dart';
import '../models/product.dart';

class ProductRepository {
  final String address;
  const ProductRepository({required this.address});

  static Future<ProductRepository> initialize() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String privateKey = sharedPreferences.getString("privateKey") ?? "";
    String address = EthPrivateKey.fromHex(privateKey).address.hex;
    return ProductRepository(address: address);
  }

  /// `1: Thành công`
  /// `2: Lỗi`
  Future<int> addProduct({
    required String code,
    required String name,
    String? description,
    String? linkImage,
    List<Ingredient>? ingredients,
  }) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    int result = 2;
    await database
        .child("products")
        .child(address)
        .push()
        .set({
          "name": name,
          "code": code,
          "description": description,
          "linkImage": linkImage,
          "type": "create",
          "ingredients": jsonDecode(jsonEncode(ingredients)),
        })
        .catchError((_) {
          result = 2;
        })
        .whenComplete(() => result = 1)
        .onError((error, stackTrace) {
          log("Add Product failure $error");
        });
    return result;
  }

  Stream<List<Product>> streamProduct() {
    DatabaseReference database = FirebaseDatabase.instance.ref();

    List<Product> products = [];
    StreamController<List<Product>> streamController =
        StreamController<List<Product>>();

    database.child("products").child(address).onChildAdded.listen((event) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
      Product product = Product.fromJson(data);
      product.id = event.snapshot.key;
      products.add(product);
      streamController.sink.add(products);
    });

    database.child("products").child(address).onChildChanged.listen((event) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
      Product product = Product.fromJson(data);
      product.id = event.snapshot.key;
      products[products.indexWhere((element) => element.id == product.id)] =
          product;
      streamController.sink.add(products);
    });

    database.child("products").child(address).onChildRemoved.listen((event) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
      Product product = Product.fromJson(data);
      product.id = event.snapshot.key;
      products
          .removeAt(products.indexWhere((element) => element.id == product.id));
      streamController.sink.add(products);
    });

    return streamController.stream;
  }

  /// nhận sản phẩm từ firebase
  Future<Product> getProduct(String keyProduct) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    DataSnapshot data =
        await database.child("products").child(address).child(keyProduct).get();
    final productJson = jsonDecode(jsonEncode(data.value));
    Product product = Product.fromJson(productJson as Map<String, dynamic>);
    return product;
  }

  /// nhận sản phẩm đã mua
  Future<List<Product>?> getProductIngredient() async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    List<Product> products = [];
    DataSnapshot data = await database.child("products").child(address).get();
    if (data.value != null) {
      final dt = jsonDecode(jsonEncode(data.value)) as Map<String, dynamic>;
      for (var e in dt.keys) {
        final product = dt[e];
        Product p = Product.fromJson(jsonDecode(jsonEncode(product)));
        p.id = e;
        if (p.type == 'buyed') {
          products.add(p);
        }
      }
    }

    return products;
  }

  /// `1: Thành công`
  /// `2: Lỗi`
  Future<int> updateProduct({
    required String key,
    required String code,
    required String name,
    String? description,
    String? linkImage,
  }) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();

    int result = 2;
    await database.child("products").child(address).child(key).update({
      "name": name,
      "code": code,
      "description": description,
      "linkImage": linkImage,
    }).catchError((_) {
      result = 2;
    }).whenComplete(() => result = 1);
    return result;
  }

  Future<bool> deleteProduct(String? key) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    bool success = false;
    if (key != null) {
      await database
          .child("products")
          .child(address)
          .child(key)
          .remove()
          .whenComplete(() {
        success = true;
      }).catchError((_) {
        success = false;
      });
    } else {
      success = false;
    }
    return success;
  }

  // Future<bool> productProcessing(String? id) async {
  //   DatabaseReference database = FirebaseDatabase.instance.ref();
  //   bool success = false;
  //   if (id != null) {
  //     DataSnapshot data =
  //         await database.child("products").child(address).child(id).get();
  //     if (data.value != null) {
  //       Product product = Product.fromJson(jsonDecode(jsonEncode(data.value)));
  //       product.name = "${product.name} (chế biến)";
  //       product.type = "processing";
  //       // tạo sản phẩm mới
  //       await database
  //           .child("products")
  //           .child(address)
  //           .push()
  //           .update(product.toJson())
  //           .whenComplete(() {
  //         success = true;
  //       }).catchError((_) {
  //         success = false;
  //       });
  //       // xóa sản phẩm cũ
  //       await database
  //           .child("products")
  //           .child(address)
  //           .child(id)
  //           .remove()
  //           .whenComplete(() {
  //         success = true;
  //       }).catchError((_) {
  //         success = false;
  //       });
  //     } else {
  //       success = false;
  //     }
  //   } else {
  //     success = false;
  //   }
  //   return success;
  // }
}
