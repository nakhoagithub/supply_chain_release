import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/models/company.dart';
import 'package:supply_chain/repository/company_repository.dart';

import '../../../../enum.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInitEvent>((event, emit) => _onInit(event, emit));
  }

  _onInit(HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(homeStatus: HomeStatus.loading));
    CompanyRepository companyRepository = await CompanyRepository.initialize();
    Company? company = await companyRepository.getCompany();
    String address = companyRepository.address;
    emit(state.copyWith(address: address));
    if (company != null) {
      emit(state.copyWith(
          name: company.name, linkImageCompany: company.linkImage));
    }
  }
}
