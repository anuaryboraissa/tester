import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'business_register_event.dart';
part 'business_register_state.dart';

class BusinessRegisterBloc
    extends Bloc<BusinessRegisterEvent, BusinessRegisterState> {
  BusinessRegisterBloc() : super(BusinessRegisterInitial()) {
    on<BusinessRegisterEvent>(businessRegister);
  }

  FutureOr<void> businessRegister(
      BusinessRegisterEvent event, Emitter<BusinessRegisterState> emit) {}
}
