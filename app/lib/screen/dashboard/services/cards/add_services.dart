import 'package:app/screen/dashboard/room/bloc/room_bloc.dart';
import 'package:app/screen/dashboard/room/cards/form.dart';
import 'package:app/screen/dashboard/services/bloc/service_bloc.dart';
import 'package:app/screen/dashboard/services/bloc/service_event.dart';
import 'package:app/screen/dashboard/services/bloc/service_state.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_button.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:app/widgets/my_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget addServices(context) {
  ServiceState model = BlocProvider.of<ServiceBloc>(context).state;
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      sizedBox12(),
      myFormCard(
        title: 'Services Details:',
        ui: Row(
          children: [
            Expanded(
              child: myTextFormField(
                context: context,
                prefixIcon: Icons.numbers,
                labelText: 'Service Name',
                errorMessage: 'Enter service name',
                form: serviceBloc.formKeys[0],
                onValueChanged: (v) {
                  model.serviceName = v;
                },
              ),
            ),
            sizedBox12(),
            Expanded(
              child: myTextFormField(
                  context: context,
                  prefixIcon: Icons.monetization_on_outlined,
                  labelText: 'Price',
                  errorMessage: 'Enter room price',
                  form: serviceBloc.formKeys[1],
                  onValueChanged: (v) {
                    model.price = v;
                  }),
            ),
          ],
        ),
      ),
      sizedBox16(),
      myFormCard(
          title: 'Services Gallery:',
          ui: DottedBorder(
            dashPattern: const [8, 10],
            strokeWidth: 1,
            color: kBlack,
            strokeCap: StrokeCap.round,
            borderType: BorderType.RRect,
            radius: const Radius.circular(5),
            child: Container(
              height: maxHeight(context) / 4,
              width: maxWidth(context),
              decoration: BoxDecoration(
                color: kWhite.withOpacity(0.4),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sizedBox16(),
                  const Icon(
                    Icons.file_upload,
                    size: 35,
                    color: kBlack,
                  ),
                  sizedBox12(),
                  Text(
                    'Image should not be more than 10 MB',
                    style: kStyle12,
                  ),
                  sizedBox12(),
                  Text(
                    'Browse',
                    style: kStyle12B,
                  ),
                  sizedBox16(),
                ],
              ),
            ),
          )),
      sizedBox16(),
      myButton(
        context: context,
        width: maxWidth(context) / 6,
        height: 50.0,
        text: 'Add Services',
        bloc: roomBloc.addBtnBloc,
        myTap: () {
          model.imagePath = '';
          BlocProvider.of<ServiceBloc>(context)
              .add(AddServiceBtnTapEvent(model: model, context: context));
        },
        validateKeys: serviceBloc.formKeys,
      ),
      sizedBox12(),
    ],
  );
}
