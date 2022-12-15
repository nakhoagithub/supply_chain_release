import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:supply_chain/models/company.dart';
import 'package:supply_chain/models/ingredient.dart';
import 'package:supply_chain/repository/blockchain_repository.dart';

import '../models/product.dart';

class ScanRepository {
  /// `return 0`: Lỗi
  /// `return 1`: Thành công
  Future<List<dynamic>?> getDataSupplyChain(String idHistory) async {
    BlockChainRepository blockChainRepository =
        await BlockChainRepository.initialize();
    final dataResult = await blockChainRepository.getTransferHistory(idHistory);
    return dataResult;
  }

  Future<List<Object?>?> getDataOfResult(List<dynamic>? data) async {
    Product? product;
    Company? company;
    List<Ingredient> ingredients = [];
    String? addressBuyer;
    String? addressCompany;
    DatabaseReference database = FirebaseDatabase.instance.ref();

    if (data != null) {
      final resultData = data[0][0];

      /// resultData[0]:  idTransfer
      ///           [1]:  idHistory
      ///           [2]:  idProduct
      ///           [3]:  addressowner
      ///           [4]:  addressbuyer
      ///           [5]:  name //transfer
      ///           [6]:  dictIngredient
      ///           [7]:  description
      ///           [8]:  isCreated
      ///           [9]:  transferDate // timestamp of block

      // get product
      final dataProduct =
          await database.child("product_view").child(resultData[2]).get();
      if (dataProduct.value != "null") {
        product = Product.fromJson(
            jsonDecode(jsonEncode(dataProduct.value)) as Map<String, dynamic>);
      }

      if (resultData[6] != "null") {
        String dataIngredient =
            resultData[6].replaceAll('[', '').replaceAll(']', '');
        List<dynamic> listData =
            dataIngredient.split('}, '); // đổi string thành list
        for (var i = 0; i < listData.length; i++) {
          String dataInList = listData[i];
          if (!dataInList.endsWith("}")) {
            dataInList += "}";
          }
          dataInList = dataInList.replaceAll("{", "").replaceAll("}", "");
          List<String> dataSp = dataInList.split(',');
          Map<String, dynamic> mapData = <String, dynamic>{};
          for (var element in dataSp) {
            mapData[element.trim().split(':')[0]] =
                element.trim().split(':')[1];
          }
          ingredients.add(Ingredient.fromJson(mapData));
        }
      }

      // get company
      if (resultData[3] != "null") {
        addressCompany = resultData[3].toString();
        final dataCompany =
            await database.child('companies').child(addressCompany).get();
        company = Company.fromJson(
            jsonDecode(jsonEncode(dataCompany.value)) as Map<String, dynamic>);
      }

      // get address buyer
      if (resultData[4] != "null") {
        addressBuyer = resultData[4].toString();
      }
    }

    return [
      product,
      company,
      ingredients,
      addressBuyer,
      addressCompany,
    ];
  }
}
