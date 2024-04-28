import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonshare/screens/main_bottom_nav/bloc/main_bottom_nav_bloc.dart';

class CommonBloc {
  /// Bloc
  static final bottomNavBloc = MainBottomNavBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<MainBottomNavBloc>(
      create: (context) => bottomNavBloc,
    ),
  ];

  /// Dispose
  static void dispose() {
    bottomNavBloc.close();
  }

  static void resetBlocs() {
    // bottomNavBloc.add(ResetAuthentication());
  }

  /// Singleton factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }

  CommonBloc._internal();
}
