import 'package:equatable/equatable.dart';

import '../../../enum.dart';

class BarcodeState extends Equatable {
  final BarcodeStatus barcodeStatus;
  final String? barcode;
  final int? barcodeScanStatus;
  const BarcodeState({
    required this.barcodeStatus,
    this.barcode,
    this.barcodeScanStatus,
  });

  BarcodeState copyWith({
    BarcodeStatus? barcodeStatus,
    String? barcode,
    int? barcodeScanStatus,
  }) {
    return BarcodeState(
      barcodeStatus: barcodeStatus ?? this.barcodeStatus,
      barcode: barcode ?? this.barcode,
      barcodeScanStatus: barcodeScanStatus ?? this.barcodeScanStatus,
    );
  }

  @override
  List<Object?> get props => [
        barcodeStatus,
        barcode,
        barcodeScanStatus,
      ];
}
