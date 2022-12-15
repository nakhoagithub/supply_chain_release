// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:supply_chain/application.dart';
// import 'package:supply_chain/constrain.dart';
// import 'package:supply_chain/handler/web3authflutter.dart';

// abstract class Web3Imp {
//   void loginSuccess(String response);
//   void userCancel();
//   void unKnownException();
// }

// class Web3Login {
//   Web3Imp? implement;
//   SharedPreferences? sharedPreferences;
//   Web3Login({this.implement, this.sharedPreferences});

//   Future<void> initWeb3AuthFlutter() async {
//     await Web3AuthFlutter.init(
//         clientId: web3authID,
//         network: Network.testnet,
//         redirectUri: redirectIDWeb3Auth,
//         whiteLabelData:
//             WhiteLabelData(dark: true, name: "Web3Auth Flutter App"));
//   }

//   bool currentUser() {
//     return sharedPreferences!.getBool('currentUser') ?? false;
//   }

//   Future<void> login() async {
//     try {
//       final Web3AuthResponse response = await Web3AuthFlutter.login(
//           provider: Provider.google, mfaLevel: MFALevel.OPTIONAL);
//       implement!.loginSuccess(response.toString());
//       SharedPreferencesApp.setAuthWeb3(sharedPreferences!, response);
//     } on UserCancelledException {
//       implement!.userCancel();
//     } on UnKnownException {
//       implement!.unKnownException();
//     }
//   }

//   void logout(context) {
//     Web3AuthFlutter.logout();
//     SharedPreferencesApp.removeAuthWeb3(sharedPreferences!);
//     Navigator.of(context).pushReplacementNamed('/');
//   }
// }
