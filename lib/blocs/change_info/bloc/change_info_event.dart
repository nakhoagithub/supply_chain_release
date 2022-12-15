import 'package:equatable/equatable.dart';

abstract class ChangeInfoEvent extends Equatable {
  const ChangeInfoEvent();
  @override
  List<Object?> get props => [];
}

class ChangeInfoInit extends ChangeInfoEvent {
  const ChangeInfoInit();
}

class ChangeInfoCompanyNameChange extends ChangeInfoEvent {
  final String name;
  const ChangeInfoCompanyNameChange({required this.name});

  @override
  List<Object> get props => [name];
}

class ChangeInfoCompanyEmailChange extends ChangeInfoEvent {
  final String email;
  const ChangeInfoCompanyEmailChange({required this.email});

  @override
  List<Object> get props => [email];
}

class ChangeInfoCompanyAddressChange extends ChangeInfoEvent {
  final String address;
  const ChangeInfoCompanyAddressChange({required this.address});

  @override
  List<Object> get props => [address];
}

class ChangeInfoCompanyDescriptionChange extends ChangeInfoEvent {
  final String description;
  const ChangeInfoCompanyDescriptionChange({required this.description});

  @override
  List<Object> get props => [description];
}

class ChangeInfoCompanyLinkImageChange extends ChangeInfoEvent {
  final String link;
  const ChangeInfoCompanyLinkImageChange({required this.link});

  @override
  List<Object> get props => [link];
}

class ChangeInfoSubmited extends ChangeInfoEvent {
  const ChangeInfoSubmited();
}
