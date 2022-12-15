import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppInitialEvent extends AppEvent {}

// class AppToLoginEvent extends AppEvent {}

// class AppToHomeEvent extends AppEvent {
//   final String privateKey;
//   AppToHomeEvent({required this.privateKey});

//   @override
//   List<Object> get props => [privateKey];
// }
