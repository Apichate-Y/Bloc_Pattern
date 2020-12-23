part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

abstract class SaveCounterObserver {
  void onSuccess(String message);

  void onError(String message);
}

class IncrementCounter extends CounterEvent {
  final int count;

  IncrementCounter(this.count);

  @override
  String toString() => "IncrementCounter{count: $count}";
}

class DecrementCounter extends CounterEvent {
  final int count;

  DecrementCounter(this.count);

  @override
  String toString() => "DecrementCounter{count: $count}";
}

class ResetCounter extends CounterEvent {
  @override
  String toString() => "ResetCounter{}";
}

class LoadCounter extends CounterEvent {
  @override
  String toString() => "LoadCounter{}";
}

class SaveCounter extends CounterEvent {
  final SaveCounterObserver saveCounterObserver;

  SaveCounter(this.saveCounterObserver);

  @override
  String toString() => "SaveCounter{counterObserver: $saveCounterObserver}";
}
