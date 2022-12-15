import 'package:equatable/equatable.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object?> get props => [];
}

class CompanyInitEvent extends CompanyEvent {}

class ProductCompanyEvent extends CompanyEvent {
  final String address;
  const ProductCompanyEvent({required this.address});
}

class BuyProductOfCompany extends CompanyEvent {
  final String idProduct;
  const BuyProductOfCompany({required this.idProduct});
}
