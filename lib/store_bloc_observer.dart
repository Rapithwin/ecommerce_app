import 'dart:developer';

import 'package:bloc/bloc.dart';

class StoreBlocObserver extends BlocObserver {
  const StoreBlocObserver();

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log("onEvent $event");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log("onError $error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log("onChange $change");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log("onTransition $transition");
  }
}
