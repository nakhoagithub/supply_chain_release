import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/receive_pk/bloc/receive_pk_event.dart';
import 'package:supply_chain/blocs/receive_pk/bloc/receive_pk_state.dart';

import '../../../enum.dart';
import '../../../repository/private_key_repository.dart';

class ReceivePKBloc extends Bloc<ReceivePKEvent, ReceivePKState> {
  ReceivePKBloc()
      : super(const ReceivePKState(
            receivePKStatus: ReceivePKStatus.inititalize,
            privateKeyVisibilityStatus: false)) {
    on<ReceivePKInit>((event, emit) => _onInit(event, emit));
    on<ReceivePKVisiblePrivateKey>(
        (event, emit) => _onVisiblePrivateKey(event, emit));
    on<ReceivePKCopy>((event, emit) => _onCopyPrivateKey(event, emit));
  }

  void _onInit(ReceivePKInit event, Emitter<ReceivePKState> emit) async {
    PrivateKeyRepository repository = PrivateKeyRepository();
    String? privateKey = await repository.getPrivateKey();
    if (privateKey != null) {
      emit(state.copyWith(
          receivePKStatus: ReceivePKStatus.success,
          privateKeyVisibilityStatus: false,
          privateKey: privateKey));
    } else {
      emit(state.copyWith(
          receivePKStatus: ReceivePKStatus.failure,
          privateKeyVisibilityStatus: false,
          privateKey: privateKey));
    }
  }

  void _onVisiblePrivateKey(
      ReceivePKVisiblePrivateKey event, Emitter<ReceivePKState> emit) {
    emit(state.copyWith(privateKeyVisibilityStatus: event.visibility));
  }

  void _onCopyPrivateKey(
      ReceivePKCopy event, Emitter<ReceivePKState> emit) async {
    String? privateKey = await PrivateKeyRepository().getPrivateKey();
    log("Copy PK: $privateKey");
    Clipboard.setData(ClipboardData(text: privateKey));
  }
}
