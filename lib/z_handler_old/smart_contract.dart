// // ignore_for_file: depend_on_referenced_packages

// import 'dart:io';
// import 'dart:math';

// import 'package:supply_chain/constrain.dart';
// import 'package:web3dart/web3dart.dart';
// import 'package:web3dart/crypto.dart';

// abstract class SmartContractImp {
//   void smartContractFail(String error);
//   void smartContractResponse(String response);
// }

// class SmartContract {
//   DeployedContract contract;
//   Web3Client client;
//   SmartContractImp? view;
//   String? privateKey;

//   SmartContract(
//       {required this.contract,
//       this.view,
//       required this.privateKey,
//       required this.client});

//   // Future<void> setup() async {
//   //   // String abi =
//   //   //     await rootBundle.loadString('contracts/build/contracts/abi.json');
//   //   // contract = DeployedContract(ContractAbi.fromJson(abi, "SupplyChain"),
//   //   //     EthereumAddress.fromHex(contractAddress));
//   //   client = Web3Client(
//   //     rpcURLTestnet,
//   //     Client(),
//   //     socketConnector: () {
//   //       return IOWebSocketChannel.connect(wsURLTestnet).cast<String>();
//   //     },
//   //   );
//   // }

//   Future<String> getBalance(String address) async {
//     EtherAmount amount =
//         await client.getBalance(EthereumAddress.fromHex(address));
//     double convert = amount.getValueInUnit(EtherUnit.szabo);
//     return convert.toString();
//   }

//   static String getAddressFromHex(String privateKey) {
//     return EthPrivateKey.fromHex(privateKey).address.hex;
//   }

//   Future<bool> getUserInBlockchain() async {
//     if (privateKey != null) {
//       List? response = await getUserByAddress(getAddressFromHex(privateKey!));
//       if (response != null) {
//         if (response[0][0].toString() !=
//             '0x0000000000000000000000000000000000000000') {
//           return true;
//         }
//       }
//     }
//     return false;
//   }

//   Future<String> callFunction(String functionName, List<dynamic> params) async {
//     if (privateKey != null) {
//       EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey!);
//       DeployedContract deployedContract = contract;
//       final ethFuntion = deployedContract.function(functionName);
//       var result = "";
//       try {
//         result = await client
//             .sendTransaction(
//                 credentials,
//                 Transaction.callContract(
//                     contract: deployedContract,
//                     function: ethFuntion,
//                     parameters: params),
//                 chainId: chainId)
//             .then((value) => value)
//             .catchError((err) {
//           view!.smartContractFail(err.toString());
//         });
//       } catch (_) {}
//       return result;
//     } else {
//       return "";
//     }
//   }

//   Future<List<dynamic>> ask(String functionName, List<dynamic> params) async {
//     DeployedContract deployedContract = contract;
//     final ethFunction = deployedContract.function(functionName);
//     final result = client.call(
//         contract: deployedContract, function: ethFunction, params: params);
//     return result;
//   }

//   // Future<void> createWallet() async {
//   //   var rng = Random.secure();
//   //   EthPrivateKey random = EthPrivateKey.createRandom(rng);
//   //   Wallet wallet = Wallet.createNew(random, "passwordpasswordpassword", rng);

//   //   Wallet wallet1 =
//   //       Wallet.fromJson(wallet.toJson(), "passwordpasswordpassword");

//   //   Credentials unlocked = wallet1.privateKey;

//   //   print(wallet1.privateKey.address.hex);

//   //   print(wallet.toJson());
//   // }

//   static String revealPrivateKey() {
//     var rng = Random.secure();
//     EthPrivateKey priKey = EthPrivateKey.createRandom(rng);
//     String s = bytesToHex(priKey.privateKey);
//     if (s.length != 64) {
//       print(s.length);
//       s = revealPrivateKey();
//     }
//     print(EthPrivateKey.fromHex(s).address);
//     return s;
//   }

//   Future<String> createUser(String name, String email, int role) async {
//     final response =
//         await callFunction('createUser', [name, email, BigInt.from(role)]);
//     view!.smartContractResponse(response);
//     return response;
//   }

//   Future<String> changeInfo(String name, String email, int role) async {
//     final response =
//         await callFunction('changeInfo', [name, email, BigInt.from(role)]);
//     view!.smartContractResponse(response);
//     return response;
//   }

//   Future<List<dynamic>?> getUserByAddress(String address) async {
//     List<dynamic>? response;
//     try {
//       response =
//           await ask('getUserByAddress', [EthereumAddress.fromHex(address)]);
//     } on SocketException {
//       // not connect
//     }
//     return response;
//   }

//   Future<List> getAllUser() async {
//     List<dynamic> response = await ask('getAllUser', []);
//     print(response);
//     return response;
//   }

//   Future<String> createProduct(
//       String id,
//       String productName,
//       int price,
//       String currency,
//       String description,
//       int count,
//       String countingUnit) async {
//     final response = await callFunction('createProduct', [
//       id,
//       productName,
//       BigInt.from(price),
//       currency,
//       description,
//       BigInt.from(count),
//       countingUnit
//     ]);
//     return response;
//   }

//   Future<String> buyProduct(String id, String newProductId) async {
//     final response = await callFunction('buyProduct', [id, newProductId]);
//     return response;
//   }

//   Future<List> getSingleProductById(String id) async {
//     List<dynamic> result = await ask('getSingleProductById', [id]);
//     print(result);
//     return result;
//   }

//   Future<List> getAllProduct() async {
//     List<dynamic> result = await ask('getAllProduct', []);
//     print(result);
//     return result;
//   }

//   Future<List> getUserProducts() async {
//     List<dynamic> result = await ask('getUserProducts', []);
//     print(result);
//     return result;
//   }

//   Future<List> getProductHistory(String id) async {
//     List<dynamic> result = await ask('getProductHistory', [id]);
//     print(result);
//     return result;
//   }
// }
