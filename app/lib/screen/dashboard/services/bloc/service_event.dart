import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/dashboard/services/bloc/service_state.dart';
import 'package:flutter/material.dart';

abstract class ServiceEvent {}

class AddServiceBtnTapEvent extends ServiceEvent {
  ServiceState model;
  BuildContext context;
  AddServiceBtnTapEvent({required this.model, required this.context});
}

class EditServiceBtnTapEvent extends ServiceEvent {
  ServiceState model;
  BuildContext context;
  MainGetBloc refreshBloc;
  EditServiceBtnTapEvent(
      {required this.model, required this.context, required this.refreshBloc});
}

class DeleteServiceBtnTapEvent extends ServiceEvent {
  ServiceState model;
  BuildContext context;
  MainGetBloc refreshBloc;
  DeleteServiceBtnTapEvent(
      {required this.model, required this.context, required this.refreshBloc});
}
