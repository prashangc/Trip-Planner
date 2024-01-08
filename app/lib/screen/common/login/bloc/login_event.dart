import 'package:app/screen/common/login/bloc/login_state.dart';
import 'package:app/services/state/state_handler_bloc.dart';

abstract class LoginEvent {}

class LoginBtnTapped extends LoginEvent {
  dynamic context;
  LoginState model;
  StateHandlerBloc btnStateBloc;
  LoginBtnTapped(
      {required this.model, required this.context, required this.btnStateBloc});
}
