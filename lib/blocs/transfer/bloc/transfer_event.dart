import 'package:equatable/equatable.dart';

abstract class TransferEvent extends Equatable {
  const TransferEvent();
  @override
  List<Object?> get props => [];
}

class TransferInitEvent extends TransferEvent {}

class TransferGetProductEvent extends TransferEvent {
  final String? keyProduct;
  const TransferGetProductEvent({required this.keyProduct});
  @override
  List<Object?> get props => [keyProduct];
}

class TransferProductInitEvent extends TransferEvent {
  final String keyProduct;
  const TransferProductInitEvent({required this.keyProduct});
  @override
  List<Object?> get props => [keyProduct];
}

class TransferChangePriceEvent extends TransferEvent {
  final String? price;
  const TransferChangePriceEvent({required this.price});

  @override
  List<Object?> get props => [price];
}

class TransferChangeCurrencyEvent extends TransferEvent {
  final String? currency;
  const TransferChangeCurrencyEvent({required this.currency});

  @override
  List<Object?> get props => [currency];
}

class TransferChangeCountingUnitEvent extends TransferEvent {
  final String? countingUnit;
  const TransferChangeCountingUnitEvent({required this.countingUnit});

  @override
  List<Object?> get props => [countingUnit];
}

class TransferChangeCountEvent extends TransferEvent {
  final String? count;
  const TransferChangeCountEvent({required this.count});

  @override
  List<Object?> get props => [count];
}

class TransferChangeDescriptionEvent extends TransferEvent {
  final String? description;
  const TransferChangeDescriptionEvent({required this.description});

  @override
  List<Object?> get props => [description];
}

class TransferChangeAddressBuyerEvent extends TransferEvent {
  final String? address;
  const TransferChangeAddressBuyerEvent({required this.address});

  @override
  List<Object?> get props => [address];
}

class TransferSubmitedEvent extends TransferEvent {}

class TransferCancelEvent extends TransferEvent {
  final String idTransfer;
  const TransferCancelEvent({required this.idTransfer});

  @override
  List<Object?> get props => [idTransfer];
}

class TransferConfirmEvent extends TransferEvent {
  final String idTransfer;
  const TransferConfirmEvent({required this.idTransfer});

  @override
  List<Object?> get props => [idTransfer];
}
