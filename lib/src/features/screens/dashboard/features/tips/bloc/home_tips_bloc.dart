import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erisiti/src/constants/data/business.dart';
import 'package:meta/meta.dart';

part 'home_tips_state.dart';
part 'home_tips_event.dart';

class HomeTipsBloc extends Bloc<HomeTipsEvent, HomeTipsState> {
  HomeTipsBloc() : super(HomeBusinessInitial()) {
    on<HomeTipsEvent>(homeTipsEvent);
    on<SearchTipsEvent>(searchTipsEvent);
  }

  FutureOr<void> homeTipsEvent(
      HomeTipsEvent event, Emitter<HomeTipsState> emit) {}

  FutureOr<void> searchTipsEvent(
      SearchTipsEvent event, Emitter<HomeTipsState> emit) {
    List<Map> filteredItems = AvailableTips.tips
        .where((element) => element['name']
            .toString()
            .toLowerCase()
            .contains(event.query.toLowerCase()))
        .toList();
    emit(SearchTipsState(filteredItems));
  }
}
