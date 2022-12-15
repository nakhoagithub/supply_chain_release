import 'package:equatable/equatable.dart';

import '../../../enum.dart';

class LoginState extends Equatable {
  final LoginStatus? loginStatus;
  final PrivateKeyStatus primaryKeyStatus;
  final String? privateKey;
  final String? privateKeyFromGeneratePage;
  const LoginState(
      {this.loginStatus, required this.primaryKeyStatus, this.privateKey, this.privateKeyFromGeneratePage});

  LoginState copyWith(
      {LoginStatus? loginStatus,
      PrivateKeyStatus? primaryKeyStatus,
      String? privateKey,
      String? privateKeyFromGeneratePage}) {
    return LoginState(
        loginStatus: loginStatus ?? this.loginStatus,
        primaryKeyStatus: primaryKeyStatus ?? this.primaryKeyStatus,
        privateKey: privateKey ?? this.privateKey,
        privateKeyFromGeneratePage: privateKeyFromGeneratePage ?? this.privateKeyFromGeneratePage);
  }

  @override
  List<Object?> get props => [loginStatus, primaryKeyStatus, privateKey, privateKeyFromGeneratePage];
}
