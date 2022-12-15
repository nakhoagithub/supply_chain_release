import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:supply_chain/models/validate.dart';
import 'package:supply_chain/repository/login_repository.dart';

import '../../../enum.dart';
import '../login.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(const LoginState(primaryKeyStatus: PrivateKeyStatus.init)) {
    on<LoginInitPKFromGeneratePage>((event, emit) => _onLoginInit(event, emit));
    on<LoginPrivateKeyChange>(_onLoginPrivateKeyChange);
    on<LoginSubmited>(_onLoginSubmited);
  }

  void _onLoginInit(
      LoginInitPKFromGeneratePage event, Emitter<LoginState> emit) {
    emit(state.copyWith(privateKeyFromGeneratePage: event.privateKey));
  }

  void _onLoginPrivateKeyChange(
      LoginPrivateKeyChange event, Emitter<LoginState> emit) {
    final privateKey = event.privateKey;
    if (Validate.privateKeyValid(privateKey)) {
      emit(state.copyWith(
          privateKey: privateKey, primaryKeyStatus: PrivateKeyStatus.valid, loginStatus: LoginStatus.init));
    } else {
      emit(state.copyWith(
          privateKey: privateKey,
          primaryKeyStatus: PrivateKeyStatus.invalid,
          loginStatus: LoginStatus.init));
    }
  }

  Future<void> _onLoginSubmited(
      LoginSubmited event, Emitter<LoginState> emit) async {
    String? privateKey = event.privateKey;

    if (state.primaryKeyStatus == PrivateKeyStatus.valid) {
      if (privateKey != null) {
        if (await LoginRepository().login(privateKey)) {
          

          emit(state.copyWith(loginStatus: LoginStatus.success));
        } else {
          emit(state.copyWith(loginStatus: LoginStatus.fail));
        }
      }
    } else {
      emit(state.copyWith(loginStatus: LoginStatus.fail));
    }
  }
}
