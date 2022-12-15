import 'package:equatable/equatable.dart';

import '../../../enum.dart';

class UserPageState extends Equatable {
  final String? name;
  final String? email;
  final String? balance;
  final String? address;
  final String? addressCompany;
  final String? linkImage;

  final UserPageStatus? userPageStatus;
  final UserJoinBlockchainStatus? userJoinBlockchainStatus;
  final bool? userInBlockchain;
  final String? messageUserBlockchainStatus;

  const UserPageState({
    this.name,
    this.email,
    this.balance,
    this.address,
    this.addressCompany,
    this.linkImage,
    this.userPageStatus,
    this.userJoinBlockchainStatus,
    this.userInBlockchain,
    this.messageUserBlockchainStatus,
  });

  UserPageState copyWith({
    String? name,
    String? email,
    String? balance,
    String? address,
    String? addressCompany,
    String? linkImage,
    UserPageStatus? userPageStatus,
    UserJoinBlockchainStatus? userJoinBlockchainStatus,
    bool? userInBlockchain,
    String? messageUserBlockchainStatus,
  }) {
    return UserPageState(
      name: name ?? this.name,
      email: email ?? this.email,
      balance: balance ?? this.balance,
      address: address ?? this.address,
      addressCompany: addressCompany ?? this.addressCompany,
      linkImage: linkImage ?? this.linkImage,
      userPageStatus: userPageStatus ?? this.userPageStatus,
      userJoinBlockchainStatus:
          userJoinBlockchainStatus ?? this.userJoinBlockchainStatus,
      messageUserBlockchainStatus:
          messageUserBlockchainStatus ?? this.messageUserBlockchainStatus,
      userInBlockchain: userInBlockchain ?? this.userInBlockchain,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        balance,
        address,
        addressCompany,
        linkImage,
        userPageStatus,
        userJoinBlockchainStatus,
        userInBlockchain,
        messageUserBlockchainStatus,
      ];
}
