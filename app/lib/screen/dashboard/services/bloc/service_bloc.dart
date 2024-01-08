import 'package:app/bloc/getApi/main_get_event.dart';
import 'package:app/screen/dashboard/services/bloc/service_event.dart';
import 'package:app/screen/dashboard/services/bloc/service_state.dart';
import 'package:app/services/api/api.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceState()) {
    on<AddServiceBtnTapEvent>((event, emit) async {
      await api.postData(
        context: event.context,
        model: event.model,
        endpoint: getDotEnvValue('ADD_SERVICE'),
        bloc: btnBloc,
        func: (resp) {},
      );
    });
    on<EditServiceBtnTapEvent>((event, emit) async {
      await api.postData(
        context: event.context,
        model: event.model,
        endpoint: getDotEnvValue('EDIT_SERVICE'),
        bloc: editBtnBloc,
        func: (resp) {
          Navigator.pop(event.context);
          event.refreshBloc.add(MainGetRefreshEvent());
        },
      );
    });
    on<DeleteServiceBtnTapEvent>((event, emit) async {
      await api.deleteData(
        context: event.context,
        model: event.model,
        endpoint: getDotEnvValue('DELETE_SERVICE'),
        bloc: deleteBtnBloc,
        func: (resp) {
          Navigator.pop(event.context);
          event.refreshBloc.add(MainGetRefreshEvent());
        },
      );
    });
  }

  final formKeys = List.generate(4, (index) => GlobalKey<FormState>());
  StateHandlerBloc btnBloc = StateHandlerBloc();
  StateHandlerBloc editBtnBloc = StateHandlerBloc();
  StateHandlerBloc deleteBtnBloc = StateHandlerBloc();
}

ServiceBloc serviceBloc = ServiceBloc();
