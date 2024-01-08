import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget myAppBar(
  String title,
  String title2,
  StateHandlerBloc lengthBloc,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    color: kPrimary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox16(),
            Text(
              title,
              style: kStyle18B.copyWith(
                color: kWhite,
                fontSize: 18.0,
              ),
            ),
            Text(
              title2,
              style: kStyle18B.copyWith(
                color: kWhite,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: kWhite.withOpacity(0.4),
              borderRadius: const BorderRadius.all(Radius.circular(16.0))),
          child: StreamBuilder<dynamic>(
              initialData: 0,
              stream: lengthBloc.stateStream,
              builder: (c, s) {
                return Text(
                  'Total : ${s.data}',
                  style: kStyle12.copyWith(color: kWhite),
                );
              }),
        )
      ],
    ),
  );
}
