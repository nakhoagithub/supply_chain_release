
import 'package:equatable/equatable.dart';

abstract class ReceivePKEvent extends Equatable {
  const ReceivePKEvent();
  
  @override
  List<Object?> get props => [];
}

class ReceivePKVisiblePrivateKey extends ReceivePKEvent {
  final bool visibility;
  const ReceivePKVisiblePrivateKey({required this.visibility});

  @override
  List<Object> get props => [visibility];
}

class ReceivePKInit extends ReceivePKEvent {}

class ReceivePKCopy extends ReceivePKEvent{}
