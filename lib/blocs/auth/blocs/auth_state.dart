import 'package:equatable/equatable.dart';

import '../../../enum.dart';

class AuthState extends Equatable {
  final AuthenticationStatus authStatus;
  final String? privateKey;
  const AuthState({required this.authStatus, this.privateKey});

  AuthState copyWith({AuthenticationStatus? authStatus, String? privateKey}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      privateKey: privateKey ?? this.privateKey
    );
  }

  @override
  List<Object?> get props => [authStatus];
}

class AuthenticationState extends AuthState {
  const AuthenticationState()
      : super(authStatus: AuthenticationStatus.authentication);
}

class UnauthenticationState extends AuthState {
  const UnauthenticationState()
      : super(authStatus: AuthenticationStatus.unAuthentication);
}
