import 'package:app/screen/common/login/login.dart';
import 'package:app/screen/common/splash/bloc/splash_event.dart';
import 'package:app/screen/common/splash/bloc/splash_state.dart';
import 'package:app/utils/my_navigations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<CloseSplashScreenEvent>(closeSplash);
    on<ShowMainScreenEvent>(showHomeScreen);
  }

  closeSplash(CloseSplashScreenEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(microseconds: 1), () {
      go(context: event.context, screen: const LoginScreen());
    });
  }

  showHomeScreen(ShowMainScreenEvent event, Emitter<SplashState> emit) {
    // go(context: event.context, screen: const MainUserScreen());
  }
}
