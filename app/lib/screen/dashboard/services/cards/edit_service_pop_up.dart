import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/dashboard/room/model/hotel_model.dart';
import 'package:app/screen/dashboard/services/bloc/service_bloc.dart';
import 'package:app/screen/dashboard/services/bloc/service_event.dart';
import 'package:app/screen/dashboard/services/bloc/service_state.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_button.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

editServiceAlertDialog(
    BuildContext context, Service service, MainGetBloc listOfServiceBloc) {
  ServiceBloc serviceBloc = BlocProvider.of<ServiceBloc>(context);
  ServiceState model = serviceBloc.state;

  model.serviceId = service.sId;
  model.serviceName = service.serviceName;
  model.price = service.price!.numberDecimal;

  AlertDialog alert = AlertDialog(
    title: Text(
      'Edit Service Details',
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
            labelText: service.serviceName.toString(),
            errorMessage: 'Enter service name',
            form: GlobalKey(),
            onValueChanged: (v) {
              model.serviceName = v;
            }),
        myTextFormField(
            context: context,
            prefixIcon: Icons.monetization_on_outlined,
            labelText: 'Rs. ${service.price!.numberDecimal}',
            errorMessage: 'Enter service price',
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
        text: 'Edit Service',
        bloc: serviceBloc.editBtnBloc,
        myTap: () {
          serviceBloc.add(EditServiceBtnTapEvent(
              model: model, context: context, refreshBloc: listOfServiceBloc));
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
