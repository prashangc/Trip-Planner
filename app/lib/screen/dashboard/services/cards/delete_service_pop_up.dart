import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/dashboard/room/model/hotel_model.dart';
import 'package:app/screen/dashboard/services/bloc/service_bloc.dart';
import 'package:app/screen/dashboard/services/bloc/service_event.dart';
import 'package:app/screen/dashboard/services/bloc/service_state.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_button.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

deleteServiceAlertDialog(
    BuildContext context, Service service, MainGetBloc listOfServiceBloc) {
  ServiceBloc serviceBloc = BlocProvider.of<ServiceBloc>(context);
  ServiceState model = serviceBloc.state;

  AlertDialog alert = AlertDialog(
    title: Text(
      'Delete Service',
      style: kStyle14B,
      textAlign: TextAlign.center,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        sizedBox16(),
        Text(
          'Are you sure, you want to remove this service?',
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
          bloc: serviceBloc.deleteBtnBloc,
          myTap: () {
            model.serviceId = service.sId;
            serviceBloc.add(DeleteServiceBtnTapEvent(
                model: model,
                context: context,
                refreshBloc: listOfServiceBloc));
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
