import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supply_chain/blocs/auth/blocs/auth_event.dart';
import 'package:supply_chain/blocs/auth/blocs/auth_state.dart';

import '../../../enum.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(const AuthState(
            authStatus: AuthenticationStatus.unAuthentication)) {
    on<Authentication>((event, emit) => _onAuthentication(event, emit));
  }

  void _onAuthentication(Authentication event, Emitter<AuthState> emit) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? privateKey = sharedPreferences.getString("private_key");
    
    if (privateKey != null && privateKey.isNotEmpty) {
      emit(state.copyWith(
          authStatus: AuthenticationStatus.authentication,
          privateKey: privateKey));
    } else {
      emit(state.copyWith(authStatus: AuthenticationStatus.unAuthentication));
    }
  }
}
