import 'package:e_commerce/app.dart';
import 'package:e_commerce/store_bloc_observer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = const StoreBlocObserver();
  runApp(const MainApp());
}
