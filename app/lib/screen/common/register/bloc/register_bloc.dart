import 'package:app/screen/common/register/bloc/register_event.dart';
import 'package:app/screen/common/register/bloc/register_state.dart';
import 'package:app/services/api/api.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<RegisterBtnTapped>(registerbtnTapped);
  }

  registerbtnTapped(
      RegisterBtnTapped event, Emitter<RegisterState> emit) async {
    api.postData(
      context: event.context,
      model: event.model,
      endpoint: getDotEnvValue('REGISTER'),
      bloc: event.btnStateBloc,
      func: (res) {
        Navigator.pop(event.context);
      },
    );
  }

  StateHandlerBloc buttonBloc = StateHandlerBloc();
  StateHandlerBloc pwVisibilityBloc = StateHandlerBloc();
  StateHandlerBloc confirmPwVisibilityBloc = StateHandlerBloc();
  StateHandlerBloc confirmPwValidationBloc = StateHandlerBloc();
  TextEditingController mapController = TextEditingController();
}

RegisterBloc registerBloc = RegisterBloc();
