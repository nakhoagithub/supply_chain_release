import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:barcode_image/barcode_image.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supply_chain/models/history.dart';
import 'package:supply_chain/repository/application_repository.dart';
import 'package:supply_chain/repository/company_repository.dart';

class HistoryRepository {
  const HistoryRepository();
  Future<List<History>> getListHistory() async {
    List<History> histories = [];
    CompanyRepository companyRepository = await CompanyRepository.initialize();
    DatabaseReference database =
        FirebaseDatabase.instance.ref("transfer_history");
    DataSnapshot data =
        await database.child(companyRepository.address).limitToLast(100).get();
    if (data.value != null) {
      final listHistory =
          jsonDecode(jsonEncode(data.value)) as Map<String, dynamic>;
      for (var element in listHistory.keys) {
        String key = element;
        History history = History.fromJson(listHistory[key]);
        histories.add(history);
      }
    }
    histories.sort(
      (a, b) => b.idHistory.compareTo(a.idHistory),
    );
    return histories;
  }

  /// cần cấp quyền thư mục khi sử dụng hàm
  Future<Directory?> getDirectory() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
      if (directory != null) {
        int indexAndroid = directory.path.indexOf("Android");
        String path = directory.path.substring(0, indexAndroid);
        directory = Directory("${path}SupplyChain");
      }
    }
    return directory;
  }

  Future<int> _createBarcode(String data) async {
    int result = 0;
    try {
      Directory? directory = await getDirectory();
      if (directory != null) {
        // nếu thư mục không tồn tại thì create
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        // tạo ảnh
        final image = Image(300, 120);
        // sửa màu color ảnh
        fill(image, getColor(255, 255, 255));
        // tạo barcode
        drawBarcode(image, Barcode.code128(), data,
            font: arial_24, textPadding: 2);

        // lưu barcode thành png
        File file = await File(
                "${directory.path}/Images/${data}_SupplyChain_Barcode.png")
            .create(recursive: true);
        await file
            .writeAsBytes(encodePng(image))
            .whenComplete(() => result = 1)
            .catchError((e) {
          result = 3;
        });
      }
    } catch (e) {
      log("history_repository.dart ERROR - line 78: $e");
      result = 0;
    }
    return result;
  }

  /// `code 0`: Không có file
  ///
  /// `code 1`: Thành công
  ///
  /// `code 2`: không có quyền truy cập thư mục
  ///
  /// `code 3`: Lỗi ghi file
  Future<int> createBarcodePNG(String data) async {
    int result = 0;

    // lấy trạng thái quyền truy cập thư mục
    var storageStatus = await Permission.storage.status;
    var managerStorageStatus = await Permission.manageExternalStorage.status;
    if (storageStatus.isDenied || managerStorageStatus.isDenied) {
      ApplicationRepository applicationRepository =
          const ApplicationRepository();
      // bool permissionStorage =
      //     await applicationRepository.requestPermission(Permission.storage);
      // bool permissionManageExternalStorage = await applicationRepository
      //     .requestPermission(Permission.manageExternalStorage);

      bool success = await applicationRepository.requestPermissions(
          [Permission.storage, Permission.manageExternalStorage]);

      if (success) {
        result = await _createBarcode(data);
      } else {
        result = 2;
      }
    } else {
      result = await _createBarcode(data);
    }
    return result;
  }
}
