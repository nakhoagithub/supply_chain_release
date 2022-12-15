import 'package:shared_preferences/shared_preferences.dart';
import 'package:supply_chain/repository/private_key_repository.dart';

class LoginRepository {
  Future<bool> login(String privateKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("privateKey", privateKey);
    return PrivateKeyRepository().checkPrivateKey(privateKey);
  }

  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("privateKey");
    return true;
  }
}
