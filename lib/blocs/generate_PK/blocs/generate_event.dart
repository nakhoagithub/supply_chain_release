import 'package:equatable/equatable.dart';

abstract class GeneratePKEvent extends Equatable {
  const GeneratePKEvent();

  @override
  List<Object?> get props => [];
}

class GenerateCompanyNameChange extends GeneratePKEvent {
  final String name;
  const GenerateCompanyNameChange({required this.name});

  @override
  List<Object> get props => [name];
}

class GenerateCompanyEmailChange extends GeneratePKEvent {
  final String email;
  const GenerateCompanyEmailChange({required this.email});

  @override
  List<Object> get props => [email];
}

class GenerateCompanyAddressChange extends GeneratePKEvent {
  final String address;
  const GenerateCompanyAddressChange({required this.address});

  @override
  List<Object> get props => [address];
}

class GeneratePKSubmited extends GeneratePKEvent {
  const GeneratePKSubmited();
}

class GeneratePageSuccess extends GeneratePKEvent {
  const GeneratePageSuccess();
}

class GenerateVisiblePrivateKey extends GeneratePKEvent {
  final bool visibility;
  const GenerateVisiblePrivateKey({required this.visibility});

  @override
  List<Object> get props => [visibility];
}

class GenerateCopyPrivateKey extends GeneratePKEvent {
  const GenerateCopyPrivateKey();
}
