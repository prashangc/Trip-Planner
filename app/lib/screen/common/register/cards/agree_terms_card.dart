import 'package:app/screen/common/login/bloc/login_bloc.dart';
import 'package:app/widgets/my_check_box.dart';
import 'package:flutter/material.dart';

Widget agreeTermsCard(context) {
  return myCheckBox(
    bloc: loginBloc.checkBoxBloc,
    initialValue: true,
    onValueChange: (v) {},
    title: 'Agree terms and condition',
  );
}
