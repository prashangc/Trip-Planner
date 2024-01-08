import 'package:app/screen/common/register/bloc/register_bloc.dart';
import 'package:app/screen/common/register/bloc/register_event.dart';
import 'package:app/screen/common/register/bloc/register_state.dart';
import 'package:app/screen/common/register/cards/agree_terms_card.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_button.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:app/widgets/my_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget formCard(context, RegisterState model, formKeys) {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: kWhite.withOpacity(0.4),
      borderRadius: const BorderRadius.all(
        Radius.circular(24.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myTextFormField(
          context: context,
          form: formKeys[0],
          labelText: 'enter email',
          errorMessage: 'errorMessage',
          title: 'Email',
          isEmail: true,
          onValueChanged: (v) {
            model.email = v;
          },
        ),
        myTextFormField(
          context: context,
          form: formKeys[1],
          labelText: 'enter name',
          errorMessage: 'errorMessage',
          title: 'Name',
          onValueChanged: (v) {
            model.name = v;
          },
        ),
        myTextFormField(
          context: context,
          form: formKeys[2],
          labelText: 'enter phone',
          errorMessage: 'errorMessage',
          title: 'Phone',
          onValueChanged: (v) {
            model.phone = v;
          },
        ),
        StreamBuilder<dynamic>(
            initialData: const ['', ''],
            stream: registerBloc.confirmPwValidationBloc.stateStream,
            builder: (c, s) {
              return myTextFormField(
                context: context,
                form: formKeys[3],
                labelText: 'enter password',
                errorMessage: 'errorMessage',
                title: 'Password',
                visibilityIconBloc: registerBloc.pwVisibilityBloc,
                onValueChanged: (v) {
                  registerBloc.confirmPwValidationBloc.storeData(
                    data: [
                      v,
                      s.data[1],
                    ],
                  );
                  model.password = v;
                },
                passwordList: [
                  s.data[0],
                  s.data[1],
                ],
              );
            }),
        StreamBuilder<dynamic>(
            initialData: const ['', ''],
            stream: registerBloc.confirmPwValidationBloc.stateStream,
            builder: (c, s) {
              return myTextFormField(
                context: context,
                labelText: 'confirm password',
                errorMessage: 'errorMessage',
                title: 'Confirm Password',
                onValueChanged: (v) async {
                  model.passwordConfirmation = v;
                  registerBloc.confirmPwValidationBloc.storeData(
                    data: [s.data[0], v],
                  );
                },
                visibilityIconBloc: registerBloc.confirmPwVisibilityBloc,
                passwordList: [
                  s.data[0],
                  s.data[1],
                ],
                form: formKeys[4],
              );
            }),
        agreeTermsCard(context),
        sizedBox12(),
        myButton(
          context: context,
          width: maxWidth(context),
          height: 50.0,
          text: 'Register',
          myTap: () {
            model.role = kIsWeb ? 3 : 2;
            BlocProvider.of<RegisterBloc>(context).add(
              RegisterBtnTapped(
                  model: model,
                  context: context,
                  btnStateBloc: registerBloc.buttonBloc),
            );
          },
          validateKeys: formKeys,
        ),
        sizedBox12(),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            width: maxWidth(context),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Already have an account?',
                style: kStyle12,
                children: <TextSpan>[
                  TextSpan(
                    text: ' Login',
                    style: kStyle14B,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
