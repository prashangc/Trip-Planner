import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/dashboard/room/bloc/room_state.dart';
import 'package:flutter/material.dart';

abstract class RoomEvent {}

class AddRoomBtnTapEvent extends RoomEvent {
  RoomState model;
  BuildContext context;
  AddRoomBtnTapEvent({required this.model, required this.context});
}

class EditRoomBtnTapEvent extends RoomEvent {
  RoomState model;
  BuildContext context;
  MainGetBloc refreshBloc;
  EditRoomBtnTapEvent(
      {required this.model, required this.context, required this.refreshBloc});
}

class DeleteRoomBtnTapEvent extends RoomEvent {
  RoomState model;
  BuildContext context;
  MainGetBloc refreshBloc;
  DeleteRoomBtnTapEvent(
      {required this.model, required this.context, required this.refreshBloc});
}
