import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/qr/bloc/barcode_event.dart';
import 'package:supply_chain/blocs/qr/bloc/barcode_state.dart';
import 'package:supply_chain/repository/barcode_repository.dart';

import '../../../enum.dart';

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState> {
  BarcodeBloc()
      : super(const BarcodeState(barcodeStatus: BarcodeStatus.initialize)) {
    on<BarcodeInitialEvent>((event, emit) => _onInit(event, emit));
    on<BarcodeScanSuccessEvent>((event, emit) => _onScanSuccess(event, emit));
  }

  void _onInit(BarcodeInitialEvent event, Emitter<BarcodeState> emit) async {
    emit(state.copyWith(barcodeStatus: BarcodeStatus.initialize));
    BarcodeRepository barcodeRepository = const BarcodeRepository();
    int permission = await barcodeRepository.permissionCamera();
    switch (permission) {
      case 1:
        emit(state.copyWith(
          barcodeStatus: BarcodeStatus.success,
        ));
        break;
      case 2:
        emit(state.copyWith(
          barcodeStatus: BarcodeStatus.permissionFailure,
        ));
        break;
    }
  }

  void _onScanSuccess(
      BarcodeScanSuccessEvent event, Emitter<BarcodeState> emit) async {
    emit(state.copyWith(barcodeScanStatus: 0));
    String? barcode = event.barcode;
    BarcodeRepository barcodeRepository = const BarcodeRepository();
    if (barcode != null) {
      int result = await barcodeRepository.scanBarCodeSuccess(barcode);
      emit(state.copyWith(barcodeScanStatus: result));
    }
  }
}
