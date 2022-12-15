import 'package:equatable/equatable.dart';

import '../../../../enum.dart';

class HomeState extends Equatable {
  final String? name;
  final String? address;
  final String? linkImageCompany;
  final HomeStatus? homeStatus;
  const HomeState({
    this.homeStatus,
    this.name,
    this.address,
    this.linkImageCompany,
  });

  HomeState copyWith({
    String? name,
    String? address,
    HomeStatus? homeStatus,
    String? linkImageCompany,
  }) {
    return HomeState(
      name: name ?? this.name,
      address: address ?? this.address,
      homeStatus: homeStatus ?? this.homeStatus,
      linkImageCompany: linkImageCompany ?? this.linkImageCompany,
    );
  }

  @override
  List<Object?> get props => [
        name,
        address,
        homeStatus,
        linkImageCompany,
      ];
}
