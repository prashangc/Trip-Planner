import 'package:app/screen/common/register/bloc/register_state.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:flutter/material.dart';

abstract class RegisterEvent {}

class RegisterBtnTapped extends RegisterEvent {
  BuildContext context;
  RegisterState model;
  StateHandlerBloc btnStateBloc;
  RegisterBtnTapped(
      {required this.model, required this.context, required this.btnStateBloc});
}
