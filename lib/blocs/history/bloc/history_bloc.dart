import 'dart:io';

import 'package:barcode_image/barcode_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart';
import 'package:supply_chain/models/history.dart';
import 'package:supply_chain/repository/history_repository.dart';

import '../../../enum.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc()
      : super(const HistoryState(
          historyStatus: HistoryStatus.initialize,
        )) {
    on<HistoryInitEvent>((event, emit) => _onInit(event, emit));
    on<HistoryCreateBarcodeEvent>(
        (event, emit) => _createImageBarcode(event, emit));
  }

  void _onInit(HistoryInitEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(historyStatus: HistoryStatus.loading));
    HistoryRepository historyRepository = const HistoryRepository();
    List<History> histories = await historyRepository.getListHistory();
    histories.reversed;
    if (histories.isNotEmpty) {
      emit(
        state.copyWith(
            historyStatus: HistoryStatus.success, histories: histories),
      );
    } else {
      emit(
        state.copyWith(historyStatus: HistoryStatus.success, histories: null),
      );
    }
  }

  void _createImageBarcode(
      HistoryCreateBarcodeEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(statusFile: -1));
    HistoryRepository historyRepository = const HistoryRepository();
    int result = await historyRepository.createBarcodePNG(event.data);
    emit(state.copyWith(statusFile: result));
  }
}
