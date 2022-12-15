import 'package:flutter/material.dart';

class Constants {
  static const String nameBlockchain = "SupplyChain";

  static const String nameNetwork = "Polygon";
  static const String contractAddress =
      "0xdA5C5C1093f1CCc8A0d5b700e89433B34603704E";
  static const int chainID = 80001;
  static const String rpcURLTestnet = "https://matic-mumbai.chainstacklabs.com";
  static const String wsURLTestnet = "wss://matic-mumbai.chainstacklabs.com";
  static const String scanTestnet = 'https://mumbai.polygonscan.com/';

  static bgGradient1() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.cyan[400]!.withOpacity(1),
          Colors.cyan[200]!.withOpacity(1),
        ]);
  }

  static bgGradient2() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blue[400]!.withOpacity(1),
          Colors.blue[200]!.withOpacity(1),
        ]);
  }

  static bgGradient3() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.grey[200]!.withOpacity(1),
          Colors.grey[400]!.withOpacity(1),
        ]);
  }
}

// const private2 =
//     '21fea2f7802d06252bc5db1252bf37ee6a7bf14dcede1dcfdcaca5526fb88c81';

// const private1 =
//     '22c70731e041c7c8edf7a3487289b14c842270f24a8922ae6e9f16b3181adfc2';

// const private =
//     '58fe67313374f0a5bfc7e3540b594c90348601bf4b32bcb63211bf59ef334a44';
// //34f5ccbc2dfd75ccd281891c7a6b25c36589850dd2aa3bb92b58afab341d06c9




  // static const String nameNetwork = "Polygon";
  // static const String contractAddress =
  //     "0xdA5C5C1093f1CCc8A0d5b700e89433B34603704E";
  // static const int chainID = 80001;
  // static const String rpcURLTestnet =
  //     "https://matic-mumbai.chainstacklabs.com";
  // static const String wsURLTestnet =
  //     "wss://testnet-rpc.brisescan.com";
  // static const String scanTestnet = 'https://mumbai.polygonscan.com/';




  // static const String nameNetwork = "Bitgert";
  // static const String contractAddress =
  //     "";
  // static const int chainID = ;
  // static const String rpcURLTestnet =
  //     "https://testnet-rpc.brisescan.com";
  // static const String wsURLTestnet =
  //     "wss://testnet-rpc.brisescan.com";
  // static const String scanTestnet = '';




  // static const String nameNetwork = "Ropsten Ethereum";
  // static const String contractAddress =
  //   "0x5b53a5aF3645400515f62FEc3Fe2E42005Ff8D7f";
    // static const int chainID = ;
  //       static const String rpcURLTestnet =
  //     "https://ropsten.infura.io/v3/5ff24c657d074626bac5eef52faae1ab";
  // static const String wsURLTestnet =
  //     "wss://ropsten.infura.io/ws/v3/5ff24c657d074626bac5eef52faae1ab";
  // static const String scanTestnet = 'https://ropsten.etherscan.io/';




  // static const String nameNetwork = "Sepolia ETH";
  // static const int chainID = 11155111;
  // static const String contractAddress =
  //     "0xB5acA30aFA4282d97dd1b67A11c2559193a08B1B";
  // static const String rpcURLTestnet =
  //     "https://sepolia.infura.io/v3/5ff24c657d074626bac5eef52faae1ab";
  // static const String wsURLTestnet =
  //     "wss://sepolia.infura.io/ws/v3/5ff24c657d074626bac5eef52faae1ab";
  // static const String scanTestnet = 'https://sepolia.etherscan.io/';