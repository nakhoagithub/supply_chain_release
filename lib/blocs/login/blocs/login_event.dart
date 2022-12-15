import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitPKFromGeneratePage extends LoginEvent {
  final String? privateKey;
  const LoginInitPKFromGeneratePage({required this.privateKey});
}

class LoginPrivateKeyChange extends LoginEvent {
  final String privateKey;
  const LoginPrivateKeyChange({required this.privateKey});

  @override
  List<Object> get props => [privateKey];
}

class LoginSubmited extends LoginEvent {
  final String? privateKey;
  const LoginSubmited({this.privateKey});
}
