import 'package:equatable/equatable.dart';

abstract class BarcodeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BarcodeInitialEvent extends BarcodeEvent {}

class BarcodeScanSuccessEvent extends BarcodeEvent {
  final String? barcode;
  BarcodeScanSuccessEvent({
    required this.barcode,
  });
}
