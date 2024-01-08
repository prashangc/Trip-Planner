import 'package:app/screen/common/login/bloc/login_bloc.dart';
import 'package:app/screen/common/login/bloc/login_event.dart';
import 'package:app/screen/common/login/bloc/login_state.dart';
import 'package:app/screen/common/login/cards/remember_me_card.dart';
import 'package:app/screen/common/register/register.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_navigations.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_button.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:app/widgets/my_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget formCard(context, LoginState model, formKeys) {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: kWhite.withOpacity(0.4),
      borderRadius: const BorderRadius.all(
        Radius.circular(24.0),
      ),
    ),
    child: Column(
      children: [
        myTextFormField(
          form: formKeys[0],
          context: context,
          labelText: 'enter name',
          errorMessage: 'errorMessage',
          title: 'Login',
          isEmail: true,
          onValueChanged: (v) {
            model.email = v;
          },
        ),
        myTextFormField(
          context: context,
          labelText: 'enter password',
          errorMessage: 'errorMessage',
          title: 'Password',
          onValueChanged: (v) {
            model.password = v;
          },
          visibilityIconBloc: StateHandlerBloc(),
          form: formKeys[1],
        ),
        rememberMeCard(context),
        sizedBox12(),
        myButton(
          context: context,
          width: maxWidth(context),
          height: 50.0,
          text: 'Login',
          bloc: loginBloc.buttonBloc,
          myTap: () {
            model.platform = kIsWeb ? 'web' : 'mobile';
            BlocProvider.of<LoginBloc>(context).add(
              LoginBtnTapped(
                model: model,
                context: context,
                btnStateBloc: loginBloc.buttonBloc,
              ),
            );
          },
          validateKeys: formKeys,
        ),
        sizedBox12(),
        GestureDetector(
          onTap: () {
            go(context: context, screen: const RegisterScreen());
          },
          child: SizedBox(
            width: maxWidth(context),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Don\'t have an account?',
                style: kStyle12,
                children: <TextSpan>[
                  TextSpan(
                    text: ' Sign Up',
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
