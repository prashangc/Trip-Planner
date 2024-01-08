import 'package:app/screen/common/login/cards/title_card.dart';
import 'package:app/screen/common/register/bloc/register_state.dart';
import 'package:app/screen/common/register/cards/form_card.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget mainForm(
  context,
  formKeys,
  RegisterState model,
) {
  double myWidth = maxWidth(context) > 600.0 ? 600.0 : maxWidth(context) * 0.9;
  return SizedBox(
    width: myWidth,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sizedBox12(),
        titleCard(context,
            title: kIsWeb ? 'REGISTER A HOTEL' : 'JOIN TO ADVENTURE'),
        formCard(
          context,
          model,
          formKeys,
        ),
      ],
    ),
  );
}
