import 'package:web3dart/credentials.dart';

class UserBlockchain {
  final EthereumAddress address;
  final BigInt createAt;
  final BigInt updateAt;

  const UserBlockchain({
    required this.address,
    required this.createAt,
    required this.updateAt,
  });
}
