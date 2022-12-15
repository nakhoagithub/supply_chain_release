import 'package:equatable/equatable.dart';

import '../../../enum.dart';
import '../../../models/company.dart';
import '../../../models/product.dart';

class CompanyState extends Equatable {
  final CompanyStatus? companyStatus;
  final Stream<List<Company>>? streamData;
  final List<Product>? productOfCompanyWithAddress;
  const CompanyState(
      {this.companyStatus,
      required this.streamData,
      this.productOfCompanyWithAddress});

  CompanyState copyWith(
      {CompanyStatus? companyStatus,
      List? companies,
      Stream<List<Company>>? streamData,
      List<Product>? productOfCompanyWithAddress}) {
    return CompanyState(
      companyStatus: companyStatus ?? this.companyStatus,
      streamData: streamData ?? this.streamData,
      productOfCompanyWithAddress:
          productOfCompanyWithAddress ?? this.productOfCompanyWithAddress,
    );
  }

  @override
  List<Object?> get props => [
        companyStatus,
        streamData,
        productOfCompanyWithAddress,
      ];
}
