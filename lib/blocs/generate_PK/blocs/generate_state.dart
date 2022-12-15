import 'package:equatable/equatable.dart';

import '../../../enum.dart';

class GeneratePKState extends Equatable {
  final GenerateStatus generateStatus;
  final NameStatus nameStatus;
  final EmailStatus emailStatus;
  final AddressStatus addressStatus;
  final bool privateKeyStatusVisible;
  final String? name;
  final String? email;
  final String? address;
  final String? privateKey;

  const GeneratePKState(
      {required this.generateStatus,
      required this.nameStatus,
      required this.emailStatus,
      required this.addressStatus,
      required this.privateKeyStatusVisible,
      this.name,
      this.email,
      this.address,
      this.privateKey});

  @override
  List<Object?> get props => [
        generateStatus,
        nameStatus,
        emailStatus,
        addressStatus,
        privateKeyStatusVisible,
        name,
        email,
        address,
        privateKey
      ];

  GeneratePKState copyWith(
      {GenerateStatus? generateStatus,
      NameStatus? nameStatus,
      EmailStatus? emailStatus,
      AddressStatus? addressStatus,
      bool? privateKeyStatusVisible,
      String? name,
      String? email,
      String? address,
      String? privateKey}) {
    return GeneratePKState(
        generateStatus: generateStatus ?? this.generateStatus,
        nameStatus: nameStatus ?? this.nameStatus,
        emailStatus: emailStatus ?? this.emailStatus,
        addressStatus: addressStatus ?? this.addressStatus,
        privateKeyStatusVisible:
            privateKeyStatusVisible ?? this.privateKeyStatusVisible,
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        privateKey: privateKey ?? this.privateKey);
  }
}
