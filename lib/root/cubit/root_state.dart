part of 'root_cubit.dart';

enum RootTab { home, favorites, cart, profile }

class RootState extends Equatable {
  const RootState({this.tab = RootTab.home});

  final RootTab tab;

  @override
  List<Object> get props => [tab];
}
