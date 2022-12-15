import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/company/bloc/company_event.dart';
import 'package:supply_chain/blocs/company/bloc/company_state.dart';

import '../../../enum.dart';
import '../../../models/company.dart';
import '../../../models/product.dart';
import '../../../repository/company_repository.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(const CompanyState(streamData: null)) {
    on<CompanyInitEvent>((event, emit) => _onInit(event, emit));
    on<ProductCompanyEvent>((event, emit) => _getProductCompany(event, emit));
    // on<BuyProductOfCompany>((event, emit) => _buyProduct(event, emit));
  }

  void _onInit(CompanyInitEvent event, Emitter<CompanyState> emit) async {
    emit(
        state.copyWith(streamData: null, companyStatus: CompanyStatus.loading));
    CompanyRepository companyRepository = await CompanyRepository.initialize();
    Stream<List<Company>> stream = companyRepository.streamCompany();
    emit(state.copyWith(
        streamData: stream, companyStatus: CompanyStatus.success));
  }

  void _getProductCompany(
      ProductCompanyEvent event, Emitter<CompanyState> emit) async {
    emit(state.copyWith(productOfCompanyWithAddress: null));
    CompanyRepository companyRepository = await CompanyRepository.initialize();
    List<Product> products =
        await companyRepository.getProductWithAddress(event.address);
    emit(state.copyWith(productOfCompanyWithAddress: products));
  }

  // void _buyProduct(BuyProductOfCompany event, Emitter<CompanyState> emit) async {
  //   String idProduct = event.idProduct;
  //   CompanyRepository companyRepository = await CompanyRepository.initialize();
  //   print(idProduct);
  // }
}
