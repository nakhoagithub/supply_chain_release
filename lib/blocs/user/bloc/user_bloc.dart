import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/user/user.dart';
import 'package:supply_chain/repository/blockchain_repository.dart';
import 'package:supply_chain/repository/company_repository.dart';
import 'package:supply_chain/repository/login_repository.dart';
import 'package:supply_chain/repository/private_key_repository.dart';

import '../../../enum.dart';
import '../../../models/company.dart';

class UserPageBloc extends Bloc<UserPageEvent, UserPageState> {
  UserPageBloc()
      : super(const UserPageState(
            userPageStatus: UserPageStatus.initialize,
            userJoinBlockchainStatus: UserJoinBlockchainStatus.initialize)) {
    on<UserPageInit>((event, emit) => _onInit(event, emit));
    on<UserPageCopyAddressEvent>((event, emit) => _onCopyAddress(event, emit));
    on<UserPageJoinBlockchainEvent>(
        (event, emit) => _onJoinBlockchain(event, emit));
    on<UserPageLogoutEvent>((event, emit) => _onUserLogout(event, emit));
  }

  void _onInit(UserPageInit event, Emitter<UserPageState> emit) async {
    emit(state.copyWith(userPageStatus: UserPageStatus.loading));

    String address = await PrivateKeyRepository().getAddress();
    emit(state.copyWith(address: address));

    BlockChainRepository blockChainRepository =
        await BlockChainRepository.initialize();
    String balance = await blockChainRepository.getBalance(address);
    emit(state.copyWith(balance: balance));

    bool userInBlockchain = await blockChainRepository
        .getUserInBlockchain();
    emit(state.copyWith(userInBlockchain: userInBlockchain));

    CompanyRepository companyRepository = await CompanyRepository.initialize();
    Company? company = await companyRepository.getCompany();
    if (company != null) {
      emit(state.copyWith(
          name: company.name,
          email: company.email,
          addressCompany: company.addressCompany,
          linkImage: company.linkImage,
          userPageStatus: UserPageStatus.success));
    } else {
      emit(state.copyWith(
          name: "null",
          email: "null",
          addressCompany: "null",
          linkImage: "",
          userPageStatus: UserPageStatus.success));
    }
  }

  void _onCopyAddress(
      UserPageCopyAddressEvent event, Emitter<UserPageState> emit) {
    if (state.address != null) {
      Clipboard.setData(ClipboardData(text: state.address));
    }
  }

  void _onJoinBlockchain(
      UserPageJoinBlockchainEvent event, Emitter<UserPageState> emit) async {
    emit(state.copyWith(
      userJoinBlockchainStatus: UserJoinBlockchainStatus.loading,
    ));
    CompanyRepository companyRepository = await CompanyRepository.initialize();
    int joinStatus = await companyRepository.joinBlockchain();
    switch (joinStatus) {
      case 1:
      case 2:
        emit(state.copyWith(
          userJoinBlockchainStatus: UserJoinBlockchainStatus.susscess,
          userInBlockchain: true,
        ));
        break;
      case 3:
        emit(state.copyWith(
          userJoinBlockchainStatus: UserJoinBlockchainStatus.failure,
          messageUserBlockchainStatus: "Không đủ số dư",
          userInBlockchain: false,
        ));
        break;
      case 4:
        emit(state.copyWith(
          userJoinBlockchainStatus: UserJoinBlockchainStatus.failure,
          messageUserBlockchainStatus: "Không thành công",
          userInBlockchain: false,
        ));
        break;
    }
  }

  void _onUserLogout(
      UserPageLogoutEvent event, Emitter<UserPageState> emit) async {
    LoginRepository loginRepository = LoginRepository();
    bool logout = await loginRepository.logout();
    if (logout) {
      emit(state.copyWith(userPageStatus: UserPageStatus.logout));
    }
  }
}
