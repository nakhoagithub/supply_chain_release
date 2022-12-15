import 'package:equatable/equatable.dart';

import '../../../enum.dart';



class ReceivePKState extends Equatable {
  final ReceivePKStatus receivePKStatus;
  final bool privateKeyVisibilityStatus;
  final String? privateKey;
  const ReceivePKState({required this.receivePKStatus, required this.privateKeyVisibilityStatus, this.privateKey});

  ReceivePKState copyWith({
      ReceivePKStatus? receivePKStatus, bool? privateKeyVisibilityStatus, String? privateKey}){
    return ReceivePKState(
        receivePKStatus: receivePKStatus ?? this.receivePKStatus,
        privateKeyVisibilityStatus: privateKeyVisibilityStatus ?? this.privateKeyVisibilityStatus,
        privateKey: privateKey ?? this.privateKey);
  }

  @override
  List<Object?> get props => [receivePKStatus, privateKeyVisibilityStatus, privateKey];
}
