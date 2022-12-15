import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supply_chain/models/user_blockchain.dart';
import 'package:supply_chain/repository/blockchain_repository.dart';
import 'package:web3dart/credentials.dart';

import '../models/company.dart';
import '../models/product.dart';

class CompanyRepository {
  final String address;
  const CompanyRepository({required this.address});

  static Future<CompanyRepository> initialize() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String privateKey = sharedPreferences.getString("privateKey") ?? "";
    String address = EthPrivateKey.fromHex(privateKey).address.hex;
    return CompanyRepository(address: address);
  }

  Stream<List<Company>> streamCompany() {
    DatabaseReference database = FirebaseDatabase.instance.ref();

    List<Company> companies = [];
    StreamController<List<Company>> streamController =
        StreamController<List<Company>>();

    database.child("companies").onChildAdded.listen((event) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
      Company company = Company.fromJson(data);
      company.address = event.snapshot.key;
      if (company.address != address) {
        companies.add(company);
      }
      streamController.sink.add(companies);
    });

    database.child("companies").onChildChanged.listen((event) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
      Company company = Company.fromJson(data);
      company.address = event.snapshot.key;
      if (companies.isNotEmpty && company.address != address) {
        companies[companies.indexWhere(
            (element) => element.address == company.address)] = company;
      }

      streamController.sink.add(companies);
    });

    // chưa làm chức năng xóa công ty
    database.child("companies").onChildRemoved.listen((event) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
      Company company = Company.fromJson(data);
      company.address = event.snapshot.key;
      if (companies.isNotEmpty) {
        companies.removeAt(companies
            .indexWhere((element) => element.address == company.address));
      }
      streamController.sink.add(companies);
    });

    return streamController.stream;

    // listen((event) {
    //   Map<String, dynamic> data =
    //       jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
    //   Company.fromJson(data);
    // });

    // database.child("companies").onChildChanged.listen((event) {
    //   print("change ${event.snapshot.value}");
    // });

    // database.child("companies").onChildRemoved.listen((event) {
    //   print(event.snapshot.value);
    // });

    // await database.child("companies").once().then((event) {
    //   for (var element in event.snapshot.children) {
    //     Map<String, dynamic> data =
    //         jsonDecode(jsonEncode(element.value)) as Map<String, dynamic>;
    //     companies.add(Company.fromJson(data));
    //   }
    // });
  }

  Future<Company?> getCompany() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? privateKey = sharedPreferences.getString("privateKey");
    DatabaseReference database = FirebaseDatabase.instance.ref();

    if (privateKey != null) {
      Company company = Company();
      String address = EthPrivateKey.fromHex(privateKey).address.hex;
      await database.child("companies").child(address).once().then((event) {
        dynamic json = jsonDecode(jsonEncode(event.snapshot.value));
        if (json != null) {
          company = Company.fromJson(json as Map<String, dynamic>);
        }
      });
      return company;
    }
    return null;
  }

  static Future<bool> updateInfoCompany(String name, String email,
      String addressCompany, String description, String? linkImage) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? privateKey = sharedPreferences.getString("privateKey");
    DatabaseReference database = FirebaseDatabase.instance.ref();

    bool success = false;

    if (privateKey != null) {
      String address = EthPrivateKey.fromHex(privateKey).address.hex;
      await database.child("companies").child(address).update({
        "address": address,
        "name": name,
        "email": email,
        "addressCompany": addressCompany,
        "description": description,
        "linkImage": linkImage,
      }).whenComplete(() {
        success = true;
      });
      return success;
    } else {
      return success;
    }
  }

  /// 1 thành công
  /// 2 đã có người dùng -> thành công
  /// 3 không đủ số dư
  /// 4 lỗi
  Future<int> joinBlockchain() async {
    BlockChainRepository blockChainRepository =
        await BlockChainRepository.initialize();

    if (blockChainRepository.privateKey != "") {
      String res = await blockChainRepository.createUser();
      if (res.isNotEmpty) {
        if (res.startsWith("0x")) {
          return 1;
        }
        if (res.contains("You are Already Registered!")) {
          return 2;
        }
        if (res.contains("gas required exceeds allowance") ||
            res.contains("\"execution reverted\"")) {
          return 3;
        }
      } else {
        return 4;
      }
    }
    return 4;
  }

  Future<List<Company>> getCompanyFromBlockchain() async {
    BlockChainRepository blockChainRepository =
        await BlockChainRepository.initialize();
    DatabaseReference database = FirebaseDatabase.instance.ref();

    dynamic users = await blockChainRepository.getAllUser();
    List<UserBlockchain> userBlockchains = [];
    users[0].forEach((value) {
      UserBlockchain userBlockchain = UserBlockchain(
          address: value[0], createAt: value[2], updateAt: value[3]);
      userBlockchains.add(userBlockchain);
    });

    List<Company> companies = [];
    for (var user in userBlockchains) {
      await database
          .child("companies")
          .child(user.address.toString())
          .once()
          .then((event) {
        dynamic json = jsonDecode(jsonEncode(event.snapshot.value));
        if (json != null) {
          Company company = Company.fromJson(json as Map<String, dynamic>);
          companies.add(company);
        } else {
          companies.add(Company(
              address: user.address.toString(),
              addressCompany: "",
              description: "",
              email: "",
              linkImage: "",
              name: ""));
        }
      });
    }

    return companies;
  }

  Future<List<Product>> getProductWithAddress(String address) async {
    List<Product> products = [];
    DatabaseReference database = FirebaseDatabase.instance.ref();
    final data = await database.child("products").child(address).get();
    final dataProduct = jsonDecode(jsonEncode(data.value));
    if (dataProduct != null) {
      for (var e in dataProduct.keys) {
        final p = dataProduct[e];
        Product product =
            Product.fromJson(jsonDecode(jsonEncode(p)) as Map<String, dynamic>);
        product.id = e;
        if (product.type == "create") {
          products.add(product);
        }
      }
    }

    return products;
  }

  // Future<int> requestBuyProduct() async {
  //   int result = 0;
  //   DatabaseReference database = FirebaseDatabase.instance.ref();
  //   database.child("requests").child("");
  //   return result;
  // }
}
