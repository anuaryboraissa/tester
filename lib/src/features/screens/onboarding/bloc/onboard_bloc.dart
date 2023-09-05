import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  OnboardBloc() : super(OnboardInitial()) {
    on<OnboardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
