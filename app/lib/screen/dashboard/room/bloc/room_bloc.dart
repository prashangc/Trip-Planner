import 'package:app/bloc/getApi/main_get_event.dart';
import 'package:app/screen/dashboard/room/bloc/room_event.dart';
import 'package:app/screen/dashboard/room/bloc/room_state.dart';
import 'package:app/services/api/api.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomState()) {
    on<AddRoomBtnTapEvent>((event, emit) async {
      await api.postData(
        context: event.context,
        model: event.model,
        endpoint: getDotEnvValue('ADD_ROOM'),
        bloc: addBtnBloc,
        func: (resp) {},
      );
    });
    on<EditRoomBtnTapEvent>((event, emit) async {
      await api.postData(
        context: event.context,
        model: event.model,
        endpoint: getDotEnvValue('EDIT_ROOM'),
        bloc: editBtnBloc,
        func: (resp) {
          Navigator.pop(event.context);
          event.refreshBloc.add(MainGetRefreshEvent());
        },
      );
    });
    on<DeleteRoomBtnTapEvent>((event, emit) async {
      await api.deleteData(
        context: event.context,
        model: event.model,
        endpoint: getDotEnvValue('DELETE_ROOM'),
        bloc: deleteBtnBloc,
        func: (resp) {
          Navigator.pop(event.context);
          event.refreshBloc.add(MainGetRefreshEvent());
        },
      );
    });
  }

  final formKeys = List.generate(4, (index) => GlobalKey<FormState>());
  StateHandlerBloc addBtnBloc = StateHandlerBloc();
  StateHandlerBloc editBtnBloc = StateHandlerBloc();
  StateHandlerBloc deleteBtnBloc = StateHandlerBloc();
}

RoomBloc roomBloc = RoomBloc();
