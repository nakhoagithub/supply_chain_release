part of 'scan_bloc.dart';

class ScanState extends Equatable {
  final ScanStatus scanStatus;
  final String? barcode;
  final int? statusResult;
  final dynamic dataResult;
  final Product? product;
  final Company? company;
  final List<Ingredient>? ingredients;
  final String? addressBuyer;
  final String? addressOwner;
  const ScanState({
    required this.scanStatus,
    this.barcode,
    this.statusResult,
    this.dataResult,
    this.product,
    this.company,
    this.ingredients,
    this.addressBuyer,
    this.addressOwner,
  });

  ScanState copyWith({
    ScanStatus? scanStatus,
    String? barcode,
    int? statusResult,
    dynamic dataResult,
    Product? product,
    Company? company,
    List<Ingredient>? ingredients,
    String? addresBuyer,
    String? addresOwner,
  }) {
    return ScanState(
      scanStatus: scanStatus ?? this.scanStatus,
      barcode: barcode ?? this.barcode,
      statusResult: statusResult ?? this.statusResult,
      dataResult: dataResult ?? this.dataResult,
      product: product ?? this.product,
      company: company ?? this.company,
      ingredients: ingredients ?? this.ingredients,
      addressBuyer: addresBuyer ?? this.addressBuyer,
      addressOwner: addresOwner ?? this.addressOwner,
    );
  }

  @override
  List<Object?> get props => [
        scanStatus,
        barcode,
        statusResult,
        dataResult,
        product,
        company,
        ingredients,
        addressBuyer,
        addressOwner,
      ];
}
