part of 'main_bottom_nav_bloc.dart';

abstract class MainBottomNavState {}

class MainBottomNavInitial extends MainBottomNavState {
  final int index;

  MainBottomNavInitial({required this.index});

  MainBottomNavInitial copyWith({
    int? index,
  }) {
    return MainBottomNavInitial(
      index: index ?? this.index,
    );
  }
}

class ChangedTabState extends MainBottomNavState {
  final int index;

  ChangedTabState({required this.index});
}
