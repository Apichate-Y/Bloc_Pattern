import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/semantics.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'counter_event.dart';

part 'counter_state.dart';

const PREF_COUNT = "count";

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitialCounterState());

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementCounter) {
      yield* mapIncrementCounterToState(event);
    } else if (event is DecrementCounter) {
      yield* mapDecrementCounterToState(event);
    } else if (event is ResetCounter) {
      yield* mapResetCounterToState();
    } else if (event is SaveCounter) {
      yield* mapSaveCounterToState(event);
    } else if (event is LoadCounter) {
      yield* mapLoadCounterToState();
    }
  }

  Stream<CounterState> mapSaveCounterToState(SaveCounter event) async* {
    try {
      var count = (state as LoadedCounterState).count;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt(PREF_COUNT, count);
      yield SaveCounterState(count);
      event.saveCounterObserver.onSuccess("Save Successfully");
    } catch (e) {
      event.saveCounterObserver.onError(e.toString());
      yield ErrorCounterState(e.toString());
    }
  }

  Stream<CounterState> mapIncrementCounterToState(
      IncrementCounter event) async* {
    try {
      var count = (state as LoadedCounterState).count;
      yield LoadedCounterState(count + event.count);
    } catch (e) {
      yield ErrorCounterState(e.toString());
    }
  }

  Stream<CounterState> mapDecrementCounterToState(
      DecrementCounter event) async* {
    try {
      var count = (state as LoadedCounterState).count;
      yield LoadedCounterState(count - event.count);
    } catch (e) {
      yield ErrorCounterState(e.toString());
    }
  }

  Stream<CounterState> mapResetCounterToState() async* {
    try {
      yield LoadedCounterState(0);
    } catch (e) {
      yield ErrorCounterState(e.toString());
    }
  }

  Stream<CounterState> mapLoadCounterToState() async* {
    try {
      yield LoadingCounterState();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final count = preferences.getInt(PREF_COUNT) ?? 0;
      await Future.delayed(Duration(seconds: 2));
      yield LoadedCounterState(count);
    } catch (e) {
      yield ErrorCounterState(e.toString());
    }
  }
}
