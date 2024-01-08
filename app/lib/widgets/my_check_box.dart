import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget myCheckBox(
    {required bool initialValue,
    String? title,
    required StateHandlerBloc bloc,
    required ValueChanged<bool> onValueChange}) {
  return StreamBuilder<dynamic>(
      initialData: initialValue,
      stream: bloc.stateStream,
      builder: (context, snapshot) {
        return Row(
          children: [
            Checkbox(
              value: snapshot.data,
              visualDensity: const VisualDensity(horizontal: -4),
              onChanged: (v) {
                onValueChange(v!);
                bloc.storeData(data: v);
              },
              checkColor: kWhite,
              activeColor: kPrimary,
            ),
            title == null ? Container() : sizedBox8(),
            title == null
                ? Container()
                : FittedBox(child: Text(title, style: kStyle12))
          ],
        );
      });
}
