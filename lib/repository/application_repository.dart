import 'package:permission_handler/permission_handler.dart';

class ApplicationRepository {
  const ApplicationRepository();

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  /// xin quyền Android
  Future<bool> requestPermissions(List<Permission> permissions) async {
    List<bool> d = List.generate(permissions.length, (index) => false);
    for (int i = 0; i < permissions.length; i++) {
      if (await permissions[i].isGranted) {
        d[i] = true;
      } else {
        var result = await permissions[i].request();
        if (result == PermissionStatus.granted) {
          d[i] = true;
        }
      }
    }

    for (var e in d) {
      if (!e) {
        return false;
      }
    }
    return true;
  }
}
