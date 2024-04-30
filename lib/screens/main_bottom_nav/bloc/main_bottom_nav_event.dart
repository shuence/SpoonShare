part of 'main_bottom_nav_bloc.dart';

abstract class MainBottomNav extends Equatable {
  @override
  List<Object?> get props => [];
}

class MainBottomNavInitialEvent extends MainBottomNav {
  MainBottomNavInitialEvent();
}

class ChangeTabEvent extends MainBottomNav {
  final int index;

  ChangeTabEvent({
    required this.index,
  });
}
