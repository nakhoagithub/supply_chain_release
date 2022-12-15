import 'package:equatable/equatable.dart';

import '../../../enum.dart';


class AppState extends Equatable {
  final AppStatus appStatus;
  final String? privateKey;
  const AppState({required this.appStatus, this.privateKey});

  AppState copyWith({AppStatus? appStatus, String? privateKey}) {
    return AppState(
        appStatus: appStatus ?? this.appStatus,
        privateKey: privateKey ?? this.privateKey);
  }

  @override
  List<Object?> get props => [appStatus];
}
