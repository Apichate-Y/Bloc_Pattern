import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';

part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is IncrementCounter) {
      yield state + event.count;
    } else if (event is DecrementCounter) {
      yield state - event.count;
    } else if (event is ResetCounter) {
      yield 0;
    } else {
      addError(Exception('unsupported event'));
    }
  }
}
