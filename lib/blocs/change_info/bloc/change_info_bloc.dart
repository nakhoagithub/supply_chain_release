import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/change_info/change_info.dart';
import 'package:supply_chain/repository/company_repository.dart';

import '../../../enum.dart';
import '../../../models/company.dart';
import '../../../models/validate.dart';

class ChangeInfoBloc extends Bloc<ChangeInfoEvent, ChangeInfoState> {
  ChangeInfoBloc()
      : super(const ChangeInfoState(
          changeInfoStatus: ChangeInfoStatus.init,
          nameStatus: NameStatus.initialize,
          emailStatus: EmailStatus.init,
          addressStatus: AddressStatus.init,
          descriptionStatus: DescriptionStatus.init,
          linkImageStatus: LinkImageStatus.initialize,
          haveChange: false,
        )) {
    on<ChangeInfoInit>((event, emit) => _onInit(event, emit));
    on<ChangeInfoCompanyNameChange>(
        (event, emit) => _onChangeName(event, emit));
    on<ChangeInfoCompanyEmailChange>(
        (event, emit) => _onChangeEmail(event, emit));
    on<ChangeInfoCompanyAddressChange>(
        (event, emit) => _onChangeAddress(event, emit));
    on<ChangeInfoCompanyDescriptionChange>(
        (event, emit) => _onChangeDescription(event, emit));
    on<ChangeInfoCompanyLinkImageChange>(
        (event, emit) => _onChangeLinkImage(event, emit));
    on<ChangeInfoSubmited>((event, emit) => _onSubmited(event, emit));
  }

  void _onInit(ChangeInfoInit event, Emitter<ChangeInfoState> emit) async {
    CompanyRepository companyRepository = await CompanyRepository.initialize();
    Company? company = await companyRepository.getCompany();

    if (company != null) {
      bool nameValid = Validate.textValid(company.name);
      bool emailValid = Validate.emailValid(company.email);
      bool addressValid = Validate.addressCompanyValid(company.addressCompany);
      bool descriptionValid = Validate.descriptionValid(company.description);

      emit(state.copyWith(
          name: company.name,
          email: company.email,
          address: company.addressCompany,
          description: company.description,
          linkImage: company.linkImage,
          nameStatus: nameValid ? NameStatus.valid : NameStatus.invalid,
          emailStatus:
              emailValid ? EmailStatus.emailValid : EmailStatus.emailInvalid,
          addressStatus:
              addressValid ? AddressStatus.valid : AddressStatus.invalid,
          descriptionStatus: descriptionValid
              ? DescriptionStatus.valid
              : DescriptionStatus.invalid,
          linkImageStatus: LinkImageStatus.valid,
          changeInfoStatus: ChangeInfoStatus.initData));
    }
  }

  void _onChangeName(
      ChangeInfoCompanyNameChange event, Emitter<ChangeInfoState> emit) {
    final companyName = event.name;
    if (Validate.textValid(companyName)) {
      emit(state.copyWith(
          nameStatus: NameStatus.valid,
          changeInfoStatus: ChangeInfoStatus.init,
          name: companyName));
    } else {
      emit(state.copyWith(
          nameStatus: NameStatus.invalid,
          changeInfoStatus: ChangeInfoStatus.failure,
          name: companyName));
    }
  }

  void _onChangeEmail(
      ChangeInfoCompanyEmailChange event, Emitter<ChangeInfoState> emit) {
    final companyEmail = event.email;
    if (Validate.emailValid(companyEmail)) {
      emit(state.copyWith(
          emailStatus: EmailStatus.emailValid,
          changeInfoStatus: ChangeInfoStatus.init,
          email: companyEmail));
    } else {
      emit(state.copyWith(
          emailStatus: EmailStatus.emailInvalid,
          changeInfoStatus: ChangeInfoStatus.failure,
          email: companyEmail));
    }
  }

  void _onChangeAddress(
      ChangeInfoCompanyAddressChange event, Emitter<ChangeInfoState> emit) {
    final companyAdddress = event.address;
    if (Validate.addressCompanyValid(companyAdddress)) {
      emit(state.copyWith(
          addressStatus: AddressStatus.valid,
          changeInfoStatus: ChangeInfoStatus.init,
          address: companyAdddress));
    } else {
      emit(state.copyWith(
          addressStatus: AddressStatus.invalid,
          changeInfoStatus: ChangeInfoStatus.failure,
          address: companyAdddress));
    }
  }

  void _onChangeDescription(
      ChangeInfoCompanyDescriptionChange event, Emitter<ChangeInfoState> emit) {
    final companyDescription = event.description;
    if (Validate.descriptionValid(companyDescription)) {
      emit(state.copyWith(
          descriptionStatus: DescriptionStatus.valid,
          changeInfoStatus: ChangeInfoStatus.init,
          description: companyDescription));
    } else {
      emit(state.copyWith(
          descriptionStatus: DescriptionStatus.invalid,
          changeInfoStatus: ChangeInfoStatus.failure,
          description: companyDescription));
    }
  }

  void _onChangeLinkImage(
      ChangeInfoCompanyLinkImageChange event, Emitter<ChangeInfoState> emit) {
    final companyLinkImage = event.link;
    emit(state.copyWith(
        linkImageStatus: LinkImageStatus.valid,
        changeInfoStatus: ChangeInfoStatus.init,
        linkImage: companyLinkImage));
    // if (Validate.linkValid(companyLinkImage)) {
    //   emit(state.copyWith(
    //       linkImageStatus: LinkImageStatus.valid,
    //       changeInfoStatus: ChangeInfoStatus.init,
    //       linkImage: companyLinkImage));
    // } else {
    //   emit(state.copyWith(
    //       linkImageStatus: LinkImageStatus.valid,
    //       changeInfoStatus: ChangeInfoStatus.init,
    //       linkImage: companyLinkImage));
    // }
  }

  void _onSubmited(
      ChangeInfoSubmited event, Emitter<ChangeInfoState> emit) async {
    if (state.nameStatus == NameStatus.valid &&
        state.emailStatus == EmailStatus.emailValid &&
        state.addressStatus == AddressStatus.valid &&
        state.descriptionStatus == DescriptionStatus.valid) {
      emit(state.copyWith(changeInfoStatus: ChangeInfoStatus.loading));
      String? name = state.name;
      String? email = state.email;
      String? address = state.address;
      String? description = state.description;
      String? linkImage = state.linkImage;
      if (name != null &&
          email != null &&
          address != null &&
          description != null) {
        if (await CompanyRepository.updateInfoCompany(
            name, email, address, description, linkImage)) {
          emit(state.copyWith(
              changeInfoStatus: ChangeInfoStatus.success, haveChange: true));
        } else {
          emit(state.copyWith(changeInfoStatus: ChangeInfoStatus.failure));
        }
      }
    } else {
      emit(state.copyWith(changeInfoStatus: ChangeInfoStatus.failure));
    }
  }
}
