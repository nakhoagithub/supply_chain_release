import 'package:equatable/equatable.dart';

import '../../../enum.dart';

class ChangeInfoState extends Equatable {
  final ChangeInfoStatus? changeInfoStatus;
  final NameStatus? nameStatus;
  final EmailStatus? emailStatus;
  final AddressStatus? addressStatus;
  final DescriptionStatus? descriptionStatus;
  final LinkImageStatus? linkImageStatus;
  final String? name;
  final String? email;
  final String? address;
  final String? description;
  final String? linkImage;
  final bool haveChange;

  const ChangeInfoState({
    this.changeInfoStatus,
    this.nameStatus,
    this.emailStatus,
    this.addressStatus,
    this.descriptionStatus,
    this.linkImageStatus,
    this.name,
    this.email,
    this.address,
    this.description,
    this.linkImage,
    required this.haveChange,
  });

  ChangeInfoState copyWith({
    ChangeInfoStatus? changeInfoStatus,
    NameStatus? nameStatus,
    EmailStatus? emailStatus,
    AddressStatus? addressStatus,
    DescriptionStatus? descriptionStatus,
    LinkImageStatus? linkImageStatus,
    String? name,
    String? email,
    String? address,
    String? description,
    String? linkImage,
    bool? haveChange,
  }) {
    return ChangeInfoState(
      changeInfoStatus: changeInfoStatus ?? this.changeInfoStatus,
      nameStatus: nameStatus ?? this.nameStatus,
      emailStatus: emailStatus ?? this.emailStatus,
      addressStatus: addressStatus ?? this.addressStatus,
      descriptionStatus: descriptionStatus ?? this.descriptionStatus,
      linkImageStatus: linkImageStatus ?? this.linkImageStatus,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      description: description ?? this.description,
      linkImage: linkImage ?? this.linkImage,
      haveChange: haveChange ?? this.haveChange,
    );
  }

  @override
  List<Object?> get props => [
        changeInfoStatus,
        nameStatus,
        emailStatus,
        addressStatus,
        descriptionStatus,
        linkImageStatus,
        name,
        email,
        address,
        description,
        linkImage,
        haveChange,
      ];
}
