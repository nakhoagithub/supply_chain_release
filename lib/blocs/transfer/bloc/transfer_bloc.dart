import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/transfer/bloc/transfer_event.dart';
import 'package:supply_chain/blocs/transfer/bloc/transfer_state.dart';
import 'package:supply_chain/models/product.dart';
import 'package:supply_chain/repository/product_repository.dart';
import 'package:supply_chain/repository/transfer_repository.dart';

import '../../../enum.dart';
import '../../../models/transfer.dart';
import '../../../models/validate.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc()
      : super(const TransferState(
          stream: null,
          addressBuyerStatus: AddressEtherStatus.initilaize,
          // priceStatus: PriceStatus.initialize,
          transferStatus: TransferStatus.initialize,
          // countStatus: CountStatus.initialize,
          // countingUnitStatus: CountingUnitStatus.initialize,
        )) {
    on<TransferInitEvent>((event, emit) => _onInitTransfer(event, emit));
    on<TransferGetProductEvent>((event, emit) => _onGetProduct(event, emit));
    on<TransferProductInitEvent>(
        (event, emit) => _onInitTransferProduct(event, emit));
    on<TransferChangeAddressBuyerEvent>(
        (event, emit) => _onChangeAddressBuyer(event, emit));
    // on<TransferChangePriceEvent>((event, emit) => _onChangePrice(event, emit));
    // on<TransferChangeCurrencyEvent>(
    //     (event, emit) => _onChangeCurrency(event, emit));
    // on<TransferChangeCountEvent>((event, emit) => _onChangeCount(event, emit));
    // on<TransferChangeCountingUnitEvent>(
    //     (event, emit) => _onChangeCountingUnit(event, emit));
    on<TransferChangeDescriptionEvent>(
        (event, emit) => _onChangeDescription(event, emit));
    on<TransferSubmitedEvent>(
        (event, emit) => _onTransferSubmited(event, emit));
    on<TransferCancelEvent>((event, emit) => _onTransferCancel(event, emit));
    on<TransferConfirmEvent>((event, emit) => _onTransferConfirm(event, emit));
  }

  void _onInitTransfer(
      TransferInitEvent event, Emitter<TransferState> emit) async {
    TransferRepository transferRepository =
        await TransferRepository.initialize();
    Stream<List<Transfer>> stream = transferRepository.streamTransfer();
    emit(state.copyWith(
      stream: stream,
      addressOwner: transferRepository.address,
    ));
  }

  void _onGetProduct(
      TransferGetProductEvent event, Emitter<TransferState> emit) async {
    TransferRepository transferRepository =
        await TransferRepository.initialize();
    Product product =
        await transferRepository.getProduct(event.keyProduct ?? "");
    emit(state.copyWith(
      productName: product.name,
      linkImage: product.linkImage,
    ));
  }

  void _onInitTransferProduct(
      TransferProductInitEvent event, Emitter<TransferState> emit) async {
    String? keyProduct = event.keyProduct;
    ProductRepository productRepository = await ProductRepository.initialize();
    Product product = await productRepository.getProduct(keyProduct);
    emit(state.copyWith(
      keyProduct: keyProduct,
      productCode: product.code,
      productName: product.name,
      description: product.description,
      linkImage: product.linkImage,
    ));
  }

  void _onChangeAddressBuyer(
      TransferChangeAddressBuyerEvent event, Emitter<TransferState> emit) {
    final addressBuyer = event.address?.toLowerCase();
    if (Validate.addressEtherValid(addressBuyer)) {
      emit(state.copyWith(
        addressBuyerStatus: AddressEtherStatus.valid,
        transferStatus: TransferStatus.initialize,
        addressBuyer: addressBuyer,
      ));
    } else {
      emit(state.copyWith(
        addressBuyerStatus: AddressEtherStatus.invalid,
        transferStatus: TransferStatus.failure,
        addressBuyer: addressBuyer,
      ));
    }
  }

  // void _onChangePrice(
  //     TransferChangePriceEvent event, Emitter<TransferState> emit) {
  //   final price = event.price;
  //   if (Validate.numberValid(price)) {
  //     emit(state.copyWith(
  //       priceStatus: PriceStatus.valid,
  //       transferStatus: TransferStatus.initialize,
  //       price: price,
  //     ));
  //   } else {
  //     emit(state.copyWith(
  //       priceStatus: PriceStatus.invalid,
  //       transferStatus: TransferStatus.failure,
  //       price: price,
  //     ));
  //   }
  // }

  // void _onChangeCurrency(
  //     TransferChangeCurrencyEvent event, Emitter<TransferState> emit) {
  //   emit(state.copyWith(
  //     currency: event.currency,
  //     transferStatus: TransferStatus.initialize,
  //   ));
  // }

  // void _onChangeCount(
  //     TransferChangeCountEvent event, Emitter<TransferState> emit) {
  //   final count = event.count;
  //   if (Validate.numberValid(count)) {
  //     emit(state.copyWith(
  //       countStatus: CountStatus.valid,
  //       count: count,
  //       transferStatus: TransferStatus.initialize,
  //     ));
  //   } else {
  //     emit(state.copyWith(
  //       countStatus: CountStatus.invalid,
  //       count: count,
  //       transferStatus: TransferStatus.failure,
  //     ));
  //   }
  // }

  // void _onChangeCountingUnit(
  //     TransferChangeCountingUnitEvent event, Emitter<TransferState> emit) {
  //   final countingUnit = event.countingUnit;
  //   if (Validate.textValid(countingUnit)) {
  //     emit(state.copyWith(
  //       countingUnitStatus: CountingUnitStatus.valid,
  //       countingUnit: countingUnit,
  //       transferStatus: TransferStatus.initialize,
  //     ));
  //   } else {
  //     emit(state.copyWith(
  //       countingUnitStatus: CountingUnitStatus.invalid,
  //       countingUnit: countingUnit,
  //       transferStatus: TransferStatus.failure,
  //     ));
  //   }
  // }

  void _onChangeDescription(
      TransferChangeDescriptionEvent event, Emitter<TransferState> emit) {
    final description = event.description;
    if (Validate.descriptionValid(description)) {
      emit(state.copyWith(
        descriptionTransfer: description,
        transferStatus: TransferStatus.initialize,
      ));
    } else {
      emit(state.copyWith(
        descriptionTransfer: description,
        transferStatus: TransferStatus.failure,
      ));
    }
  }

  void _onTransferSubmited(
      TransferSubmitedEvent event, Emitter<TransferState> emit) async {
    String? addressBuyer = state.addressBuyer;
    // String? price = state.price;
    // String? currency = state.currency;
    // String? count = state.count;
    // String? countingUnit = state.countingUnit;
    String? descriptionTransfer = state.descriptionTransfer;
    String? keyProduct = state.keyProduct;

    if (addressBuyer == null) {
      emit(state.copyWith(addressBuyerStatus: AddressEtherStatus.invalid));
    }
    // if (price == null) {
    //   emit(state.copyWith(priceStatus: PriceStatus.invalid));
    // }
    // if (count == null) {
    //   emit(state.copyWith(countStatus: CountStatus.invalid));
    // }
    // if (countingUnit == null) {
    //   emit(state.copyWith(countingUnitStatus: CountingUnitStatus.invalid));
    // }
    if (keyProduct == null) {
      emit(state.copyWith(transferStatus: TransferStatus.failure));
    }

    if (addressBuyer != null &&
        // price != null &&
        // currency != null &&
        // count != null &&
        // countingUnit != null &&
        keyProduct != null) {
      TransferRepository transferRepository =
          await TransferRepository.initialize();
      int result = await transferRepository.transfer(
        addressBuyer: addressBuyer,
        // price: price,
        // currency: currency,
        // count: count,
        // countingUnit: countingUnit,
        description: descriptionTransfer,
        keyProduct: keyProduct,
      );
      switch (result) {
        case 1:
          emit(state.copyWith(transferStatus: TransferStatus.success));
          break;
        case 2:
          emit(state.copyWith(transferStatus: TransferStatus.failure));
          break;
        default:
      }
    } else {
      emit(state.copyWith(transferStatus: TransferStatus.failure));
    }
  }

  void _onTransferCancel(
      TransferCancelEvent event, Emitter<TransferState> emit) async {
    TransferRepository transferRepository =
        await TransferRepository.initialize();
    String idTransfer = event.idTransfer;
    transferRepository.cancelTransfer(idTransfer);
  }

  void _onTransferConfirm(
      TransferConfirmEvent event, Emitter<TransferState> emit) async {
    emit(state.copyWith(confirmTransferStatus: 0));
    TransferRepository transferRepository =
        await TransferRepository.initialize();
    String idTransfer = event.idTransfer;
    int result = await transferRepository.confirmTransfer(idTransfer);
    emit(state.copyWith(confirmTransferStatus: result));
    // switch (result) {
    //   case 1:
    //     emit(state.copyWith(confirmTransferStatus: 1));
    //     break;
    //   case 2:
    //     emit(state.copyWith(confirmTransferStatus: 2));
    //     break;
    //   case 3:
    //     emit(state.copyWith(confirmTransferStatus: 3));
    //     break;
    //   case 4:
    //     emit(state.copyWith(confirmTransferStatus: 4));
    //     break;
    //    case 5:
    //     emit(state.copyWith(confirmTransferStatus: 5));
    //     break;
    //   case 400:
    //     emit(state.copyWith(confirmTransferStatus: 400));
    //     break;
    // }
  }
}
