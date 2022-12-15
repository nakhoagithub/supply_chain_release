import 'package:equatable/equatable.dart';

abstract class UserPageEvent extends Equatable {
  const UserPageEvent();
  @override
  List<Object?> get props => [];
}

class UserPageInit extends UserPageEvent {
  const UserPageInit();
}

class UserPageCopyAddressEvent extends UserPageEvent {
  const UserPageCopyAddressEvent();
}

class UserPageJoinBlockchainEvent extends UserPageEvent {
  const UserPageJoinBlockchainEvent();
}

class UserPageLogoutEvent extends UserPageEvent {
  const UserPageLogoutEvent();
}
