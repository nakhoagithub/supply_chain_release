import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/models/company.dart';
import 'package:supply_chain/repository/scan_repository.dart';

import '../../../enum.dart';
import '../../../models/ingredient.dart';
import '../../../models/product.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc() : super(const ScanState(scanStatus: ScanStatus.initialize)) {
    on<ScanInitialEvent>((event, emit) => _init(event, emit));
    on<ScanSuccessEvent>((event, emit) => _scanSuccess(event, emit));
    on<ScanDataResult>((event, emit) => _scanData(event, emit));
  }

  void _init(ScanInitialEvent event, Emitter<ScanState> emit) {}

  void _scanSuccess(ScanSuccessEvent event, Emitter<ScanState> emit) async {
    emit(state.copyWith(
        statusResult: 0, scanStatus: ScanStatus.loading, dataResult: null));
    ScanRepository scanRepository = ScanRepository();
    if (event.barcode != null) {
      List<dynamic>? result =
          await scanRepository.getDataSupplyChain(event.barcode!);
      if (result![0].isEmpty) {
        /// `statusResult 400`: lỗi data rỗng
        emit(state.copyWith(statusResult: 400));
      } else {
        emit(state.copyWith(statusResult: 1, dataResult: result));
      }
    }
  }

  void _scanData(ScanDataResult event, Emitter<ScanState> emit) async {
    final data = event.data;
    ScanRepository scanRepository = ScanRepository();
    List<Object?>? objects = await scanRepository.getDataOfResult(data);
    if (objects != null) {
      if (objects[0] != null) {
        emit(state.copyWith(product: objects[0] as Product));
      }
      if (objects[1] != null) {
        emit(state.copyWith(company: objects[1] as Company));
      }
      if (objects[2] != null) {
        emit(state.copyWith(ingredients: objects[2] as List<Ingredient>));
      }
      if (objects[3] != null) {
        emit(state.copyWith(addresBuyer: objects[3] as String));
      }
      if (objects[4] != null) {
        emit(state.copyWith(addresOwner: objects[4] as String));
      }
    }
  }
}
