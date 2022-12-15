import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class HistoryInitEvent extends HistoryEvent {}

class HistoryCreateBarcodeEvent extends HistoryEvent {
  final String data;
  const HistoryCreateBarcodeEvent({
    required this.data,
  });
}
