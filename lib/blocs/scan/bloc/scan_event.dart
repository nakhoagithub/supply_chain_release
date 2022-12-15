part of 'scan_bloc.dart';

abstract class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object> get props => [];
}

class ScanInitialEvent extends ScanEvent {}

class ScanSuccessEvent extends ScanEvent {
  final String? barcode;
  const ScanSuccessEvent({required this.barcode});
}

class ScanDataResult extends ScanEvent {
  final List<dynamic> ? data;
  const ScanDataResult({required this.data});
}
