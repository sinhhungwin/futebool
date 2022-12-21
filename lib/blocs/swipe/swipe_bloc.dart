import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:futebol/models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading()) {
    on<SwipeEvent>((event, emit) {
      if (event is LoadUsersEvent) {}
      if (event is SwipeLeftEvent) {}
      if (event is SwipeRightEvent) {}
    });
  }
}
