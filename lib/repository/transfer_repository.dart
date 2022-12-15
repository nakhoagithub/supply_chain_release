import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supply_chain/models/product.dart';
import 'package:supply_chain/repository/blockchain_repository.dart';
import 'package:web3dart/web3dart.dart';

import '../models/transfer.dart';

class TransferRepository {
  final String address;
  const TransferRepository({required this.address});

  static Future<TransferRepository> initialize() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String privateKey = sharedPreferences.getString("privateKey") ?? "";
    String address = EthPrivateKey.fromHex(privateKey).address.hex;
    return TransferRepository(address: address);
  }

  /// `1: Thành công`
  /// `2: Lỗi`
  Future<int> transfer({
    required String addressBuyer,
    // required String price,
    // required String currency,
    // required String count,
    // required String countingUnit,
    String? description,
    String? keyProduct,
  }) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    int result = 2;
    if (address == addressBuyer) {
      return result;
    }

    final dbref = database.child("transfers").child(address).push();

    String key = dbref.key ?? "";

    await database.child("transfers").child(address).child(key).update({
      "addressOwner": address,
      "addressBuyer": addressBuyer,
      // "price": price,
      // "currency": currency,
      // "count": count,
      // "countingUnit": countingUnit,
      "description": description ?? "",
      "keyProduct": keyProduct ?? "", // idProduct
      "idHistory": ServerValue.timestamp,
      "idTransfer": key,
      "type": "sell",
    }).catchError((_) {
      result = 2;
    }).whenComplete(() => result = 1);
    return result;
  }

  /// stream transfer
  Stream<List<Transfer>> streamTransfer() {
    DatabaseReference database = FirebaseDatabase.instance.ref();

    List<Transfer> transfers = [];
    StreamController<List<Transfer>> streamController =
        StreamController<List<Transfer>>();

    database
        .child("transfers")
        .child(address)
        .onChildAdded
        .listen((event) async {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
      Transfer transfer = Transfer.fromJson(data);
      DatabaseReference database = FirebaseDatabase.instance.ref();
      final product = await database
          .child("products")
          .child(transfer.addressOwner)
          .child(transfer.keyProduct)
          .get();
      transfer.product = Product.fromJson(
          jsonDecode(jsonEncode(product.value)) as Map<String, dynamic>);
      transfers.add(transfer);
      streamController.sink.add(transfers);
    });

    database
        .child("transfers")
        .child(address)
        .onChildChanged
        .listen((event) async {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
      Transfer transfer = Transfer.fromJson(data);
      DatabaseReference database = FirebaseDatabase.instance.ref();
      final product = await database
          .child("products")
          .child(transfer.addressOwner)
          .child(transfer.keyProduct)
          .get();
      transfer.product = Product.fromJson(
          jsonDecode(jsonEncode(product.value)) as Map<String, dynamic>);
      transfers[transfers.indexWhere(
          (element) => element.idTransfer == transfer.idTransfer)] = transfer;
      streamController.sink.add(transfers);
    });

    database.child("transfers").child(address).onChildRemoved.listen((event) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
      Transfer transfer = Transfer.fromJson(data);
      transfers.removeAt(transfers
          .indexWhere((element) => element.idTransfer == transfer.idTransfer));
      streamController.sink.add(transfers);
    });

    return streamController.stream;
  }

  /// nhận dữ liệu sản phẩm từ firebase
  Future<Product> getProduct(String keyProduct) async {
    Product product;
    DatabaseReference database = FirebaseDatabase.instance.ref();
    final data =
        await database.child("products").child(address).child(keyProduct).get();
    product = Product.fromJson(
        jsonDecode(jsonEncode(data.value)) as Map<String, dynamic>);
    return product;
  }

  /// xóa transfer
  Future<void> cancelTransfer(String idTransfer) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    database.child("transfers").child(address).child(idTransfer).remove();
  }

  /// tạo thông tin sản phẩm cho người dùng mua hàng xem được thông tin sản phẩm
  /// thông tin này chỉ đọc và không chỉnh sửa
  Future<void> _createProductViewForUser(
      Transfer transfer, String idProductView) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    final productData = await database
        .child("products")
        .child(address)
        .child(transfer.keyProduct)
        .get();
    Product product = Product.fromJson(
        jsonDecode(jsonEncode(productData.value)) as Map<String, dynamic>);
    product.id = productData.key.toString();
    // loại bỏ nguyên liệu sản phẩm -> nguyên liệu sản phẩm được truy xuất từ blockchain
    product.ingredients = null;
    await database
        .child("product_view")
        .child(idProductView)
        .update(product.toJson());
  }

  /// tạo sản phẩm cho người mua nhưng cần phải xác nhận bằng cách quét QR code từ gói hàng chuyển đến
  Future<void> _createProductBuyer(Transfer transfer) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    final productData = await database
        .child("products")
        .child(address)
        .child(transfer.keyProduct)
        .get();
    Product product = Product.fromJson(
        jsonDecode(jsonEncode(productData.value)) as Map<String, dynamic>);
    product.id = productData.key.toString();
    product.type = "transfer";
    // tạo ra idHistory để lưu lại sản phẩm trước là gì
    // idHistory dùng để truy xuất sản phẩm
    product.idHistory = transfer.idHistory;
    await database
        .child("products")
        .child(transfer.addressBuyer)
        .child("${product.id}")
        .update(product.toJson());
  }

  /// tạo lịch sử giao dịch cho người tạo giao dịch xem tức người bán
  Future<void> _createHistoryTransfer(Transfer transfer, String txValue) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    Map<String, Object?> dataOwner = transfer.toJson();
    dataOwner['tx'] = txValue;
    await database
        .child("transfer_history")
        .child(transfer.addressOwner)
        .child(transfer.idHistory)
        .update(dataOwner);

    Map<String, Object?> dataBuyer = transfer.toJson();
    dataBuyer['tx'] = txValue;
    dataBuyer['type'] = "buy";
    await database
        .child("transfer_history")
        .child(transfer.addressBuyer)
        .child(transfer.idHistory)
        .update(dataBuyer);
  }

  /// `1: thành công`
  ///
  /// `2: không có người dùng trên blockchain`
  ///
  /// `3: Không đủ số dư`
  ///
  /// `4: Lỗi người nhận chưa tham gia Blockchain`
  ///
  /// `5: Lỗi trùng lặp id của giao dịch`
  ///
  /// `400: Lỗi`
  Future<int> confirmTransfer(String idTransfer) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();

    final data = await database
        .child("transfers")
        .child(address)
        .child(idTransfer)
        .get();
    Transfer transfer = Transfer.fromJson(
        jsonDecode(jsonEncode(data.value)) as Map<String, dynamic>);
    // kiểm tra có tham gia hệ thống chưa
    BlockChainRepository blockChainRepository =
        await BlockChainRepository.initialize();

    final dataProduct = await database
        .child("products")
        .child(address)
        .child(transfer.keyProduct)
        .get();

    String? dict;
    if (dataProduct.value != null) {
      final dataIngredient =
          jsonDecode(jsonEncode(dataProduct.value))['ingredients'];
      dict = dataIngredient.toString();
    }

    int result = 400;
    if (await blockChainRepository.getUserInBlockchain()) {
      // gửi giao dịch trên blockchain
      await blockChainRepository
          .transferProduct(
        idTransfer,
        transfer.idHistory,
        // product key này được lưu ở blockchain và được view cho người dùng
        "VIEW_${transfer.keyProduct}",
        "transfer",
        dict ?? "NULL",
        transfer.description,
        transfer.addressBuyer,
      )
          .then((value) async {
        log("TX response transferProduct: $value");
        if (value.contains("\"execution reverted\"")) {
          result = 3;
        }
        if (value.contains("Transaction ID already exists!")) {
          result = 5;
        }
        if (value.contains("Buyer has not been initialized!")) {
          result = 4;
        }
        // thành công
        if (value.startsWith("0x")) {
          result = 1;
          // tạo lịch sử
          await _createHistoryTransfer(transfer, value);
          // tạo sản phẩm view - không chỉnh sửa
          await _createProductViewForUser(
              transfer, "VIEW_${transfer.keyProduct}");
          // tạo sản phẩm cho người nhận - cần xác nhận
          await _createProductBuyer(transfer);
          // xóa sản phẩm
          await cancelTransfer(transfer.idTransfer);
        }
      });
    } else {
      result = 2;
    }
    return result;
  }
}
