part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class IncrementCounter extends CounterEvent {
  final int count;

  IncrementCounter(this.count);

  @override
  String toString() {
    return "IncrementCounter{count: $count}";
  }
}

class DecrementCounter extends CounterEvent {
    final int count;

  DecrementCounter(this.count);

  @override
  String toString() {
    return "DecrementCounter{count: $count}";
  }
}

class ResetCounter extends CounterEvent {
  @override
  String toString() {
    return "ResetCounter{}";
  }
}
