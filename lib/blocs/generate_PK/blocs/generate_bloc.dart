import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/models/validate.dart';
import 'package:supply_chain/repository/private_key_repository.dart';

import '../../../enum.dart';
import '../generate_private_key.dart';

class GeneratePKBloc extends Bloc<GeneratePKEvent, GeneratePKState> {
  GeneratePKBloc()
      : super(const GeneratePKState(
            generateStatus: GenerateStatus.init,
            nameStatus: NameStatus.initialize,
            emailStatus: EmailStatus.init,
            addressStatus: AddressStatus.init,
            privateKeyStatusVisible: false)) {
    on<GenerateCompanyNameChange>(
        (event, emit) => _onCompanyNameChange(event, emit));
    on<GenerateCompanyEmailChange>(
        (event, emit) => _onCompanyEmailChange(event, emit));
    on<GenerateCompanyAddressChange>(
        (event, emit) => _onCompanyAddressChange(event, emit));
    on<GeneratePKSubmited>((event, emit) => _onGenerateSubmited(event, emit));
    on<GeneratePageSuccess>(
        (event, emit) => _onGeneratePageSuccess(event, emit));
    on<GenerateVisiblePrivateKey>(
        (event, emit) => _onGenerateSuccessVisiblePrivateKey(event, emit));
    on<GenerateCopyPrivateKey>(
        (event, emit) => _onGenerateCopyPrivateKey(event, emit));
  }

  void _onCompanyNameChange(
      GenerateCompanyNameChange event, Emitter<GeneratePKState> emit) {
    final companyName = event.name;
    if (Validate.textValid(companyName)) {
      emit(state.copyWith(
          nameStatus: NameStatus.valid,
          generateStatus: GenerateStatus.init,
          name: companyName));
    } else {
      emit(state.copyWith(
          nameStatus: NameStatus.invalid,
          generateStatus: GenerateStatus.failure,
          name: companyName));
    }
  }

  void _onCompanyEmailChange(
      GenerateCompanyEmailChange event, Emitter<GeneratePKState> emit) {
    final email = event.email;
    if (Validate.emailValid(email)) {
      emit(state.copyWith(
          emailStatus: EmailStatus.emailValid,
          generateStatus: GenerateStatus.init,
          email: email));
    } else {
      emit(state.copyWith(
          emailStatus: EmailStatus.emailInvalid,
          generateStatus: GenerateStatus.failure,
          email: email));
    }
  }

  void _onCompanyAddressChange(
      GenerateCompanyAddressChange event, Emitter<GeneratePKState> emit) {
    final address = event.address;
    if (Validate.addressCompanyValid(address)) {
      emit(state.copyWith(
          addressStatus: AddressStatus.valid,
          generateStatus: GenerateStatus.init,
          address: address));
    } else {
      emit(state.copyWith(
          addressStatus: AddressStatus.invalid,
          generateStatus: GenerateStatus.failure,
          address: ""));
    }
  }

  void _onGenerateSubmited(
      GeneratePKSubmited event, Emitter<GeneratePKState> emit) async {
    if (state.nameStatus == NameStatus.valid &&
        state.emailStatus == EmailStatus.emailValid &&
        state.addressStatus == AddressStatus.valid) {
      emit(state.copyWith(generateStatus: GenerateStatus.loading));
      String name = state.name ?? "";
      String email = state.email ?? "";
      String addressCompany = state.address ?? "";
      String privateKey = PrivateKeyRepository().generatePrivateKey();
      if (await PrivateKeyRepository()
          .updateInfoCompany(privateKey, name, email, addressCompany)) {
        emit(state.copyWith(
            generateStatus: GenerateStatus.success, privateKey: privateKey));
      } else {
        emit(state.copyWith(
            generateStatus: GenerateStatus.failure, privateKey: ""));
      }
    } else {
      emit(state.copyWith(
          generateStatus: GenerateStatus.failure, privateKey: ""));
    }
  }

  void _onGeneratePageSuccess(
      GeneratePageSuccess event, Emitter<GeneratePKState> emit) async {
    String? privateKey =
        await PrivateKeyRepository().getPKCreateSharedPreference();
    emit(
        state.copyWith(privateKeyStatusVisible: false, privateKey: privateKey));
  }

  void _onGenerateSuccessVisiblePrivateKey(
      GenerateVisiblePrivateKey event, Emitter<GeneratePKState> emit) {
    emit(state.copyWith(privateKeyStatusVisible: event.visibility));
  }

  void _onGenerateCopyPrivateKey(
      GenerateCopyPrivateKey event, Emitter<GeneratePKState> emit) async {
    String? privateKey =
        await PrivateKeyRepository().getPKCreateSharedPreference();
    Clipboard.setData(ClipboardData(text: privateKey));
  }
}
