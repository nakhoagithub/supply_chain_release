import 'package:equatable/equatable.dart';
import 'package:supply_chain/models/transfer.dart';

import '../../../enum.dart';

class TransferState extends Equatable {
  final Stream<List<Transfer>>? stream;
  final String? keyProduct;
  final String? productCode;
  final String? productName;
  final String? description;
  final String? linkImage;
  final AddressEtherStatus addressBuyerStatus;
  final String? addressBuyer;
  final String? addressOwner;
  final TransferStatus transferStatus;
  // final String? price;
  // final PriceStatus priceStatus;
  // final String? currency;
  // final String? count;
  // final CountStatus countStatus;
  // final String? countingUnit;
  // final CountingUnitStatus countingUnitStatus;
  final String? descriptionTransfer;
  final int? confirmTransferStatus;
  const TransferState({
    required this.stream,
    this.keyProduct,
    this.productCode,
    this.productName,
    this.description,
    this.linkImage,
    required this.addressBuyerStatus,
    this.addressBuyer,
    this.addressOwner,
    required this.transferStatus,
    // this.price,
    // required this.priceStatus,
    // this.currency,
    // required this.countStatus,
    // this.count,
    // required this.countingUnitStatus,
    // this.countingUnit,
    this.descriptionTransfer,
    this.confirmTransferStatus,
  });

  TransferState copyWith({
    Stream<List<Transfer>>? stream,
    String? keyProduct,
    String? productCode,
    String? productName,
    String? description,
    String? linkImage,
    AddressEtherStatus? addressBuyerStatus,
    String? addressBuyer,
    String? addressOwner,
    TransferStatus? transferStatus,
    // String? price,
    // PriceStatus? priceStatus,
    // String? currency,
    // CountStatus? countStatus,
    // String? count,
    // CountingUnitStatus? countingUnitStatus,
    // String? countingUnit,
    String? descriptionTransfer,
    int? confirmTransferStatus,
  }) {
    return TransferState(
      stream: stream ?? this.stream,
      keyProduct: keyProduct ?? this.keyProduct,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      linkImage: linkImage ?? this.linkImage,
      addressBuyerStatus: addressBuyerStatus ?? this.addressBuyerStatus,
      addressBuyer: addressBuyer ?? this.addressBuyer,
      addressOwner: addressOwner ?? this.addressOwner,
      transferStatus: transferStatus ?? this.transferStatus,
      // price: price ?? this.price,
      // priceStatus: priceStatus ?? this.priceStatus,
      // currency: currency ?? this.currency,
      // countStatus: countStatus ?? this.countStatus,
      // count: count ?? this.count,
      // countingUnitStatus: countingUnitStatus ?? this.countingUnitStatus,
      // countingUnit: countingUnit ?? this.countingUnit,
      descriptionTransfer: descriptionTransfer ?? this.descriptionTransfer,
      confirmTransferStatus:
          confirmTransferStatus ?? this.confirmTransferStatus,
    );
  }

  @override
  List<Object?> get props => [
        stream,
        keyProduct,
        productCode,
        productName,
        description,
        linkImage,
        addressBuyerStatus,
        addressBuyer,
        addressOwner,
        transferStatus,
        // price,
        // priceStatus,
        // currency,
        // countStatus,
        // count,
        // countingUnitStatus,
        // countingUnit,
        descriptionTransfer,
        confirmTransferStatus,
      ];
}
