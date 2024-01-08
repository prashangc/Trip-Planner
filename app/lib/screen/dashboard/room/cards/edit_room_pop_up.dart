import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/dashboard/room/bloc/room_bloc.dart';
import 'package:app/screen/dashboard/room/bloc/room_event.dart';
import 'package:app/screen/dashboard/room/bloc/room_state.dart';
import 'package:app/screen/dashboard/room/model/hotel_model.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_button.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

editRoomAlertDialog(
    BuildContext context, Room room, MainGetBloc listOfRoomBloc) {
  RoomBloc roomBloc = BlocProvider.of<RoomBloc>(context);
  RoomState model = roomBloc.state;

  model.roomNo = room.roomNumber;
  model.roomId = room.sId;
  model.price = room.price!.numberDecimal;

  AlertDialog alert = AlertDialog(
    title: Text(
      'Edit Room Details',
      style: kStyle14B,
      textAlign: TextAlign.center,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        sizedBox16(),
        myTextFormField(
            context: context,
            prefixIcon: Icons.numbers,
            labelText: room.roomNumber.toString(),
            errorMessage: 'Enter room no.',
            form: GlobalKey(),
            onValueChanged: (v) {
              model.roomNo = int.parse(v.toString());
            }),
        myTextFormField(
            context: context,
            prefixIcon: Icons.monetization_on_outlined,
            labelText: 'Rs. ${room.price!.numberDecimal}',
            errorMessage: 'Enter room price',
            form: GlobalKey(),
            onValueChanged: (v) {
              model.price = v;
            }),
      ],
    ),
    actions: [
      myButton(
        context: context,
        width: maxWidth(context) / 6,
        height: 50.0,
        text: 'Edit Rooms',
        bloc: roomBloc.editBtnBloc,
        myTap: () {
          roomBloc.add(EditRoomBtnTapEvent(
              model: model, context: context, refreshBloc: listOfRoomBloc));
        },
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
