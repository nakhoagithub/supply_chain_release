import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supply_chain/models/history.dart';
import 'package:supply_chain/repository/application_repository.dart';
import 'package:supply_chain/repository/company_repository.dart';

class BarcodeRepository {
  const BarcodeRepository();

  /// `code 0`: none
  ///
  /// `code 1`: có quyền truy cập máy ảnh, bộ nhớ...
  ///
  /// `code 2`: Không có quyền
  Future<int> permissionCamera() async {
    int result = 0;

    var managerStorageStatus = await Permission.manageExternalStorage.status;
    var storageStatus = await Permission.storage.status;
    var cameraStatus = await Permission.camera.status;
    if (managerStorageStatus.isDenied ||
        storageStatus.isDenied ||
        cameraStatus.isDenied) {
      ApplicationRepository applicationRepository =
          const ApplicationRepository();

      if (Platform.isAndroid) {
        // bool permissionManageExternalStorage = await applicationRepository
        //     .requestPermission(Permission.manageExternalStorage);
        // bool permissionStorage =
        //     await applicationRepository.requestPermission(Permission.storage);
        // bool permissionCamera =
        //     await applicationRepository.requestPermission(Permission.camera);

        bool permission = await applicationRepository.requestPermissions([
          Permission.manageExternalStorage,
          Permission.storage,
          Permission.camera
        ]);

        if (permission) {
          result = 1;
        } else {
          result = 2;
        }
      }
    } else {
      result = 1;
    }

    return result;
  }

  /// `code 1`: Thành công
  ///
  /// `code 2`: Lỗi không thể lấy sản phẩm - không có dữ liệu về mã vạch
  ///
  Future<int> scanBarCodeSuccess(String barcode) async {
    // lấy địa chỉ của người dùng
    CompanyRepository companyRepository = await CompanyRepository.initialize();
    String address = companyRepository.address;
    int result = 0;
    DatabaseReference database = FirebaseDatabase.instance.ref();

    DataSnapshot transfer = await database
        .child("transfer_history")
        .child(address)
        .child(barcode)
        .get();
    if (transfer.value != null) {
      History history =
          History.fromJson(jsonDecode(jsonEncode(transfer.value)));
      String idProduct = history.keyProduct;

      await database.child("products").child(address).child(idProduct).update({
        'idHistory': history.idHistory,
        'type': 'buyed',
      }).whenComplete(() => result = 1);
    } else {
      result = 2;
    }
    return result;
  }
}
