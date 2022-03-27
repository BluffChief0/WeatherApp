import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ab_event.dart';
part 'ab_state.dart';

class AbBloc extends Bloc<AbEvent, AbState> {
  AbBloc() : super(AbInitial()) {
    on<AbEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
