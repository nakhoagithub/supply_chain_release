import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/crypto.dart';

class PrivateKeyRepository {
  Future<bool> updateInfoCompany(String privateKey, String name, String email,
      String addressCompany) async {
    // save private key
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("privateKeyCreate", privateKey);
    // save address to firebase
    String address = EthPrivateKey.fromHex(privateKey).address.toString();
    DatabaseReference database = FirebaseDatabase.instance.ref();
    database.child("companies").child(address).update({
      "address": address,
      "name": name,
      "email": email,
      "addressCompany": addressCompany,
      "description": "",
      "linkImage": ""
    });
    return true;
  }

  String generatePrivateKey() {
    int lent = 0;
    String s = "";
    while (lent != 64) {
      var rng = Random.secure();
      EthPrivateKey priKey = EthPrivateKey.createRandom(rng);
      s = bytesToHex(priKey.privateKey);
      lent = s.length;
    }
    return s;
  }

  Future<String?> getPKCreateSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("privateKeyCreate");
  }

  bool checkPrivateKey(String privateKey) {
    try {
      String address = EthPrivateKey.fromHex(privateKey).address.toString();
      if (address.startsWith("0x")) {
        return true;
      }
      return false;
    } on FormatException catch (_) {
      return false;
    }
  }

  Future<String> getAddress() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? privateKey = sharedPreferences.getString("privateKey");
    if (privateKey != null) {
      return EthPrivateKey.fromHex(privateKey).address.hex;
    } else {
      return "0x0000000000000000000000000000000000000000";
    }
  }

  Future<String?> getPrivateKey() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("privateKey");
  }
}
