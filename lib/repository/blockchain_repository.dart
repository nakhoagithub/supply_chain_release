import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supply_chain/constrain.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

/// Cần khởi tạo bằng hàm [initialize] trước khi làm việc khác
class BlockChainRepository {
  final DeployedContract deployedContract;
  final Web3Client client;
  final String privateKey;
  const BlockChainRepository({
    required this.deployedContract,
    required this.client,
    required this.privateKey,
  });

  /// Khởi tạo trước khi làm mọi việc
  static Future<BlockChainRepository> initialize() async {
    String abi = await rootBundle.loadString('assets/blockchain/abi.json');
    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, Constants.nameBlockchain),
        EthereumAddress.fromHex(Constants.contractAddress));
    Web3Client client = Web3Client(
      Constants.rpcURLTestnet,
      Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(Constants.wsURLTestnet)
            .cast<String>();
      },
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? privateKey = sharedPreferences.getString("privateKey") ?? "";
    return BlockChainRepository(
        deployedContract: contract, client: client, privateKey: privateKey);
  }

  /// Trả về giá trị số dư của địa chỉ [address]
  Future<String> getBalance(String address) async {
    EtherAmount amount =
        await client.getBalance(EthereumAddress.fromHex(address));
    String convert = amount.getValueInUnit(EtherUnit.ether).toStringAsFixed(4);
    return convert;
  }

  /// Trả về [address] tương ứng với [privateKey]
  static String getAddressFromHex(String privateKey) {
    return EthPrivateKey.fromHex(privateKey).address.hex;
  }

  /// [callFunction] kết nối smartcontract
  Future<String> callFunction(String functionName, List<dynamic> params) async {
    if (privateKey.isNotEmpty) {
      EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
      final ethFuntion = deployedContract.function(functionName);
      String result = "";
      try {
        result = await client
            .sendTransaction(
                credentials,
                Transaction.callContract(
                    contract: deployedContract,
                    function: ethFuntion,
                    parameters: params),
                chainId: Constants.chainID)
            .then((value) => value)
            .catchError((err) {
          result = err.toString();
        });
      } catch (_) {}
      return result;
    } else {
      return "";
    }
  }

  /// Khác với [callFunction], [ask] sử dụng không cần truyền vào tham số
  /// [ask] sử dụng để nhận về một giá trị nào đó
  Future<List<dynamic>> ask(String functionName, List<dynamic> params) async {
    final ethFunction = deployedContract.function(functionName);
    final result = client.call(
        contract: deployedContract, function: ethFunction, params: params);
    return result;
  }

  /// Tạo người dùng trên Smart Contract
  Future<String> createUser() async {
    String response = await callFunction('createUser', []);
    log("TX response create User: $response");
    return response;
  }

  /// Thay đôi thông tin người dùng -> Không dùng nữa
  // Future<String> changeInfo(String name, String email, int role) async {
  //   final response =
  //       await callFunction('changeInfo', [name, email, BigInt.from(role)]);
  //   return response;
  // }

  /// Trả về người dùng theo địa chỉ [address], cần phải kết nối với smart contract thành công
  Future<List<dynamic>?> getUserByAddress(String address) async {
    List<dynamic>? response;
    try {
      response =
          await ask('getUserByAddress', [EthereumAddress.fromHex(address)]);
    } on SocketException {
      // not connect
    }
    return response;
  }

  /// Trả về người dùng có tồn tại hay không, được kiểm tra theo [privateKey]
  Future<bool> getUserInBlockchain() async {
    if (privateKey.isNotEmpty) {
      List? response = await getUserByAddress(getAddressFromHex(privateKey));
      if (response != null) {
        if (response[0][0].toString() !=
            '0x0000000000000000000000000000000000000000') {
          return true;
        }
      }
    }
    return false;
  }

  /// Trả về tất cả người dùng được tạo vào smart contract
  Future<List> getAllUser() async {
    List<dynamic> response = await ask('getAllUser', []);
    return response;
  }

  /// Trao đổi sản phẩm
  Future<String> transferProduct(
    String idTransfer,
    String idHistory,
    String idProduct,
    String name,
    String dictIngredient,
    String description,
    String addressBuyer,
  ) async {
    final response = await callFunction('transferProduct', [
      idTransfer,
      idHistory,
      idProduct,
      name,
      dictIngredient,
      description,
      EthereumAddress.fromHex(addressBuyer),
    ]);
    return response;
  }

  Future<List> getAllTransferOfUser(String addressOwner) async {
    EthereumAddress addressEther = EthereumAddress.fromHex(addressOwner);
    List<dynamic> response = await ask('getAllTransferOfUser', [addressEther]);
    log("Get all transfer of user: $response");
    return response;
  }

  Future<List> getTransferHistory(String idHistory) async {
    List<dynamic> result = await ask('getTransferHistory', [idHistory]);
    log("Get transfer history: $result");
    return result;
  }

  Future<List> getAllTransfer() async {
    List<dynamic> result = await ask('getAllTransfer', []);
    log("All transfer: $result");
    return result;
  }
}
