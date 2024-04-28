import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_bottom_nav_event.dart';

part 'main_bottom_nav_state.dart';

class MainBottomNavBloc extends Bloc<MainBottomNav, MainBottomNavState> {
  MainBottomNavBloc() : super(MainBottomNavInitial(index: 0)) {
    on<MainBottomNavInitialEvent>((event, emit) {
      emit(MainBottomNavInitial(index: 0));
    });
    on<ChangeTabEvent>((event, emit) {
      emit(ChangedTabState(index: 0));
    });
  }
}
