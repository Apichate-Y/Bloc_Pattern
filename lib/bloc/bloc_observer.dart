import 'package:bloc/bloc.dart';

class FlowBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  // @override
  // void onChange(Cubit cubit, Change change) {
  //   print(change);
  //   super.onChange(cubit, change);
  // }

  @override
  void onError(Cubit cubit, Object error, StackTrace stacktrace) {
    print(error);
    super.onError(cubit, error, stacktrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}
