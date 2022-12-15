// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:supply_chain/config_application.dart';
// import 'package:supply_chain/constrain.dart';
// import 'package:supply_chain/handler/smart_contract.dart';
// import 'package:supply_chain/views/widgets/bottom_dialog.dart';

// class ProfileManager extends StatefulWidget {
//   const ProfileManager({Key? key}) : super(key: key);

//   @override
//   State<ProfileManager> createState() => _ProfileManagerState();
// }

// class _ProfileManagerState extends State<ProfileManager> {

//   String? address;
//   String? nameCompany;
//   String? typeCompany;
//   String? emailCompany;
//   String? createDate;
//   String? updateDate;

//   // smart contract
//   SmartContract? smartContract;
//   String balance = "0";

//   @override
//   void initState() {
//     super.initState();
//     smartContract = SmartContract(
//         contract: getIt<Contract>().getContract,
//         client: getIt<Web3ClientGetIt>().getWeb3Client,
//         privateKey: getIt<SharedPreferencesApp>()
//             .getSharedPreferences
//             .getString('privateKey'));

//     setState(() {
//       address = SmartContract.getAddressFromHex(privateKey!);
//     });
//     initAsync();
//   }

//   void initAsync() async {
//     String data = await smartContract!.getBalance(address!);
//     List<dynamic>? userBlockchain =
//         await smartContract!.getUserByAddress(address!);
//     setState(() {
//       balance = data;
//       if (userBlockchain != null) {
//         nameCompany = userBlockchain[0][1];
//         emailCompany = userBlockchain[0][2];
//         typeCompany = userBlockchain[0][3].toString();
//         createDate = userBlockchain[0][5].toString();
//         updateDate = userBlockchain[0][6].toString();
//       }
//     });
//   }

//   // tính ngày từ block time
//   String getDateFromTimestamp(String timestamp) {
//     DateTime date =
//         DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
//     return "Ngày ${date.day} Tháng ${date.month} Năm ${date.year}";
//   }

//   // tính kiểu nhà cung cấp từ role
//   String getTypeCompanyFromRole(String role) {
//     return roleCompany[int.parse(role) - 1].name;
//   }

//   @override
//   Widget build(BuildContext context) {
//     String linkImage = "";
//     if (profileImage != null) {
//       linkImage =
//           '${profileImage!.substring(0, profileImage!.indexOf('=') + 2)}256-c';
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Quản lý thông tin",
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 20, bottom: 10),
//             child: Center(
//               child: Container(
//                 width: 100.0,
//                 height: 100.0,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         fit: BoxFit.cover, image: NetworkImage(linkImage)),
//                     borderRadius: BorderRadius.circular(50)),
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.all(5),
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 border: Border.all(), borderRadius: BorderRadius.circular(10)),
//             child: Column(children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Text(
//                     "Số token sở hữu:",
//                     style: TextStyle(fontSize: 16, color: Colors.grey[800]),
//                   ),
//                   InkWell(
//                       onTap: () {
//                         ScaffoldMessenger.of(context)
//                             .showSnackBar(const SnackBar(
//                           duration: Duration(milliseconds: 2500),
//                           content: Text(
//                               "Lượng token này sẽ trả phí cho mỗi lần giao dịch trên Blockchain."),
//                         ));
//                       },
//                       child: const Icon(
//                         Icons.info_outline,
//                         size: 18,
//                       ))
//                 ],
//               ),
//               Text(
//                 "$balance Token",
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[700]),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(address ?? ""),
//                   InkWell(
//                       onTap: () {
//                         Clipboard.setData(ClipboardData(text: address));
//                         ScaffoldMessenger.of(context)
//                             .showSnackBar(const SnackBar(
//                           duration: Duration(milliseconds: 500),
//                           content: Text("Đã copy địa chỉ vào bộ nhớ tạm"),
//                         ));
//                       },
//                       child: const Padding(
//                         padding: EdgeInsets.all(5),
//                         child: Icon(
//                           Icons.copy,
//                           size: 16,
//                         ),
//                       )),
//                 ],
//               )
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.all(5),
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 border: Border.all(), borderRadius: BorderRadius.circular(10)),
//             child: Column(children: [
//               Row(
//                 children: [
//                   const Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Tên tài khoản:",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 7,
//                     child: Text(
//                       name ?? "",
//                       style: const TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(flex: 1, child: Container())
//                 ],
//               ),
//               Row(
//                 children: [
//                   const Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Email:",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 7,
//                     child: Text(
//                       email ?? "",
//                       style: const TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: InkWell(
//                         onTap: () {
//                           Clipboard.setData(ClipboardData(text: email));
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(const SnackBar(
//                             duration: Duration(milliseconds: 500),
//                             content: Text("Đã copy email vào bộ nhớ tạm"),
//                           ));
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.all(5),
//                           child: Icon(
//                             Icons.copy,
//                             size: 18,
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   const Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Tên công ty:",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 7,
//                     child: nameCompany != null
//                         ? Text(
//                             nameCompany ?? "",
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           )
//                         : const Text(
//                             "(Chưa có công ty)",
//                             style: TextStyle(
//                                 fontSize: 14, fontStyle: FontStyle.italic),
//                           ),
//                   ),
//                   Expanded(flex: 1, child: Container())
//                 ],
//               ),
//               Row(
//                 children: [
//                   const Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Email công ty:",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 7,
//                     child: emailCompany != null
//                         ? Text(
//                             emailCompany ?? "",
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           )
//                         : const Text(
//                             "(Chưa có email công ty)",
//                             style: TextStyle(
//                                 fontSize: 14, fontStyle: FontStyle.italic),
//                           ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: InkWell(
//                         onTap: () {
//                           Clipboard.setData(ClipboardData(text: email));
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(const SnackBar(
//                             duration: Duration(milliseconds: 500),
//                             content: Text("Đã copy email vào bộ nhớ tạm"),
//                           ));
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.all(5),
//                           child: Icon(
//                             Icons.copy,
//                             size: 18,
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   const Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Kiểu nhà cung cấp:",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 7,
//                     child: nameCompany != null
//                         ? Text(
//                             typeCompany != null
//                                 ? getTypeCompanyFromRole(typeCompany!)
//                                 : "",
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           )
//                         : const Text(
//                             "(Chưa có kiểu nhà cung cấp)",
//                             style: TextStyle(
//                                 fontSize: 14, fontStyle: FontStyle.italic),
//                           ),
//                   ),
//                   Expanded(flex: 1, child: Container())
//                 ],
//               ),
//               Row(
//                 children: [
//                   const Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Ngày tạo:",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 7,
//                     child: Text(
//                       createDate != null
//                           ? getDateFromTimestamp(createDate!)
//                           : "",
//                       style: const TextStyle(
//                           fontSize: 16, fontStyle: FontStyle.italic),
//                     ),
//                   ),
//                   Expanded(flex: 1, child: Container())
//                 ],
//               ),
//               Row(
//                 children: [
//                   const Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Ngày cập nhật:",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 7,
//                     child: Text(
//                       updateDate != null
//                           ? getDateFromTimestamp(updateDate!)
//                           : "",
//                       style: const TextStyle(
//                           fontSize: 16, fontStyle: FontStyle.italic),
//                     ),
//                   ),
//                   Expanded(flex: 1, child: Container())
//                 ],
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 20),
//             child: Center(
//               child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                       // if (states.contains(MaterialState.pressed)) {
//                       //   return Colors.indigo[900];
//                       // }
//                       return Colors.blue[800];
//                     }),
//                     textStyle: MaterialStateProperty.resolveWith((states) {
//                       if (states.contains(MaterialState.pressed)) {
//                         return const TextStyle(fontSize: 18);
//                       }
//                       return const TextStyle(fontSize: 16);
//                     }),
//                     padding: MaterialStateProperty.resolveWith((states) {
//                       return const EdgeInsets.all(10);
//                     }),
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/change_infor_company');
//                   },
//                   child: const Text(
//                     "Thay đổi thông tin",
//                   )),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
