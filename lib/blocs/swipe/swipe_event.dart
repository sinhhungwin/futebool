part of 'swipe_bloc.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();
}

class LoadUsersEvent extends SwipeEvent {
  final List<User> users;

  const LoadUsersEvent({required this.users});

  @override
  List<Object> get props => [users];
}

class SwipeLeftEvent extends SwipeEvent {
  final User user;

  const SwipeLeftEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class SwipeRightEvent extends SwipeEvent {
  final User user;

  const SwipeRightEvent({required this.user});

  @override
  List<Object> get props => [user];
}
