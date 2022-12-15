import 'dart:io';
import 'package:web3dart/web3dart.dart';

class Web3ClientGetIt {
  Web3Client client;
  Web3ClientGetIt({required this.client});
  Web3Client get getWeb3Client => client;
}

class Contract {
  DeployedContract contract;
  Contract({required this.contract});
  DeployedContract get getContract => contract;
}

/* SharedPreferences:
  - currentUser:              [bool]    Người dùng đã đăng nhập.
  - responseLogin:            [string]  Dữ liệu response từ web3auth.
*/

abstract class ConnectInternetImp {
  void connected(bool connected);
}

class ConnectInternet {
  ConnectInternetImp view;
  ConnectInternet({required this.view});

  Future<void> networkConnect() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        view.connected(true);
      }
    } on SocketException catch (_) {
      view.connected(false);
    }
  }
}

// class MyConnectivity {
//   MyConnectivity._();

//   static final _instance = MyConnectivity._();
//   static MyConnectivity get instance => _instance;
//   final _connectivity = Connectivity();
//   final _controller = StreamController.broadcast();
//   Stream get myStream => _controller.stream;

//   void initialise() async {
//     ConnectivityResult result = await _connectivity.checkConnectivity();
//     _checkStatus(result);
//     _connectivity.onConnectivityChanged.listen((result) {
//       _checkStatus(result);
//     });
//   }

//   void _checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//     _controller.sink.add({result: isOnline});
//   }

//   void disposeStream() => _controller.close();
// }

//check valid mail

bool checkEmail(String email) {
  return !RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
