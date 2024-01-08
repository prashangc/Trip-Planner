import 'dart:convert';

import 'package:app/bloc/token/token_bloc.dart';
import 'package:app/bloc/token/token_event.dart';
import 'package:app/bloc/token/token_state.dart';
import 'package:app/screen/app/base/base.dart';
import 'package:app/screen/common/login/bloc/login_event.dart';
import 'package:app/screen/common/login/bloc/login_state.dart';
import 'package:app/screen/dashboard/main/base.dart';
import 'package:app/services/api/api.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_navigations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginBtnTapped>(loginBtnTapped);
  }

  loginBtnTapped(LoginBtnTapped event, Emitter<LoginState> emit) async {
    api.postData(
      context: event.context,
      model: event.model,
      endpoint: getDotEnvValue('LOGIN'),
      bloc: event.btnStateBloc,
      func: (res) async {
        TokenState tokenState =
            TokenState.fromJson(json.decode(res.toString()));
        BlocProvider.of<TokenBloc>(event.context).add(
            StoreTokenEvent(loginResp: tokenState, context: event.context));
        await getProfileInfo(event.context, tokenState);
        if (tokenState.role == 2) {
          go(context: event.context, screen: const BasePage());
        } else if (tokenState.role == 3) {
          go(context: event.context, screen: const BasePageDashboard());
        }
      },
    );
  }

  getProfileInfo(context, TokenState tokenState) {
    BlocProvider.of<TokenBloc>(context).state.profile = tokenState.profile;
  }

  StateHandlerBloc checkBoxBloc = StateHandlerBloc();
  StateHandlerBloc buttonBloc = StateHandlerBloc();
}

LoginBloc loginBloc = LoginBloc();
