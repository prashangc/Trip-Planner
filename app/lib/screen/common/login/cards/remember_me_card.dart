import 'package:app/screen/common/login/bloc/login_bloc.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_check_box.dart';
import 'package:flutter/material.dart';

Widget rememberMeCard(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      myCheckBox(
        bloc: loginBloc.checkBoxBloc,
        initialValue: true,
        onValueChange: (v) {},
        title: 'Remember me',
      ),
      GestureDetector(
        onTap: () {
          // go(context: context, screen: const ForgetPassword());
        },
        child: FittedBox(
          child: Text(
            'Forgot Password',
            style: kStyle12.copyWith(
              color: kRed,
            ),
          ),
        ),
      ),
    ],
  );
}
