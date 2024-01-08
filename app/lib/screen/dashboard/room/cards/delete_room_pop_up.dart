import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/dashboard/room/bloc/room_bloc.dart';
import 'package:app/screen/dashboard/room/bloc/room_event.dart';
import 'package:app/screen/dashboard/room/bloc/room_state.dart';
import 'package:app/screen/dashboard/room/model/hotel_model.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_button.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

deleteRoomAlertDialog(
    BuildContext context, Room room, MainGetBloc listOfRoomBloc) {
  RoomBloc roomBloc = BlocProvider.of<RoomBloc>(context);
  RoomState model = roomBloc.state;

  AlertDialog alert = AlertDialog(
    title: Text(
      'Delete Room',
      style: kStyle14B,
      textAlign: TextAlign.center,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        sizedBox16(),
        Text(
          'Are you sure, you want to remove this room?',
          style: kStyle12,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    actions: [
      Center(
        child: myButton(
          context: context,
          width: maxWidth(context) / 8,
          height: 50.0,
          text: 'Remove',
          color: kRed,
          bloc: roomBloc.deleteBtnBloc,
          myTap: () {
            model.roomId = room.sId;
            roomBloc.add(DeleteRoomBtnTapEvent(
                context: context, model: model, refreshBloc: listOfRoomBloc));
          },
        ),
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
