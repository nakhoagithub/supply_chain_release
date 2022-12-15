// import 'package:flutter/material.dart';
// import 'package:supply_chain/config_application.dart';
// import 'package:supply_chain/handler/smart_contract.dart';
// import 'package:supply_chain/handler/web3_login.dart';
// import 'package:supply_chain/views/widgets/app_bar.dart';
// import 'package:supply_chain/views/widgets/drawer_main.dart';

// class Home extends StatefulWidget {
//   final String? response;
//   const Home({Key? key, this.response}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> implements SmartContractImp {
//   SmartContract? smartContract;
//   bool init = true;

//   //connect internet
//   bool internet = false;
//   ConnectInternet? connectInternet;

//   //check user in blockchain
//   bool userInBlockchain = false;
//   bool currentUser = getIt<SharedPreferencesApp>()
//           .getSharedPreferences
//           .getBool('currentUser') ??
//       false;

//   @override
//   void initState() {
//     super.initState();
//     smartContract = SmartContract(
//         contract: getIt<Contract>().getContract,
//         client: getIt<Web3ClientGetIt>().getWeb3Client,
//         view: this,
//         privateKey:
//             '6a0301f5cfa6cf8b6a9c5f26ab511f8ce9310387dc7c167a5c804940777914a9');
//     //getIt<SharedPreferencesApp>()
//     //     .getSharedPreferences
//     //     .getString('privateKey')
//     initApp();
//   }

//   void initApp() async {
//     bool user = await smartContract!.getUserInBlockchain();
//     setState(() {
//       init = false;
//       userInBlockchain = user;
//     });
//   }

//   final GlobalKey<ScaffoldState> _key = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _key,
//       drawer: DrawerMain(),
//       appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(50),
//           child: AppBarSuplyChain(
//             onPressed: () {
//               _key.currentState!.openDrawer();
//             },
//           )),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             !currentUser
//                 ? Container()
//                 : userInBlockchain
//                     ? Container()
//                     : Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Bạn chưa tham gia vào chuỗi cung ứng!",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pushNamed(context, '/create_company');
//                               },
//                               child: const Text(
//                                 "Tham gia",
//                                 style:
//                                     TextStyle(fontSize: 16, color: Colors.blue),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//             TextButton(
//                 onPressed: () {
//                   print(SmartContract.revealPrivateKey());
//                 },
//                 child: Text("revealPrivateKey")),
//             TextButton(
//                 onPressed: () {
//                   print(SmartContract.getAddressFromHex(
//                       '22c70731e041c7c8edf7a3487289b14c842270f24a8922ae6e9f16b3181adfc2')); //58fe67313374f0a5bfc7e3540b594c90348601bf4b32bcb63211bf59ef334a44
//                 },
//                 child: Text("address")),
//             TextButton(
//                 onPressed: () {
//                   smartContract!.createUser("khoa", "email", 1);
//                 },
//                 child: Text("create user")),
//             TextButton(
//                 onPressed: () {
//                   smartContract!.getAllUser();
//                 },
//                 child: Text("get all user")),
//             TextButton(
//                 onPressed: () {
//                   smartContract!.getUserByAddress(
//                       '0x532abaeb703da8228e302a2f33da3c6383885163'); // 0x1792E4F5E6653775bA7e2d578c536795853a3d59 có rồi -- 0xAc09Ab0e1Bd2DaF956239ACE2954821e574d1AdC chua co
//                 },
//                 child: Text("get user address")),
//             TextButton(
//                 onPressed: () {
//                   smartContract!.getAllProduct();
//                 },
//                 child: Text("get all product")),
//             TextButton(
//                 onPressed: () {
//                   smartContract!.createProduct('3', "productName3", 1,
//                       "currency", "description", 1, "countingUnit");
//                 },
//                 child: Text("create product")),
//             TextButton(
//                 onPressed: () {
//                   smartContract!.getUserProducts();
//                 },
//                 child: Text("get user product")),
//             TextButton(
//                 onPressed: () {
//                   smartContract!.getProductHistory("1");
//                 },
//                 child: Text("get product history")),
//             TextButton(
//                 onPressed: () {
//                   smartContract!.getSingleProductById("2");
//                 },
//                 child: Text("get single product")),
//             TextButton(
//                 onPressed: () {
//                   smartContract!
//                       .getBalance('0x532abaeb703da8228e302a2f33da3c6383885163');
//                 },
//                 child: Text("get balance")),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void smartContractFail(String error) {
//     print("main err: $error");
//   }

//   @override
//   void smartContractResponse(String response) {
//     print("main response: $response");
//   }

//   @override
//   void loginSuccess(String response) {
//     Navigator.of(context).pushReplacementNamed('/');
//   }

//   @override
//   void unKnownException() {}

//   @override
//   void userCancel() {}

//   @override
//   void connected(bool connected) {
//     setState(() {
//       internet = connected;
//     });
//   }
// }
