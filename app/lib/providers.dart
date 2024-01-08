import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/bloc/token/token_bloc.dart';
import 'package:app/screen/common/login/bloc/login_bloc.dart';
import 'package:app/screen/common/register/bloc/register_bloc.dart';
import 'package:app/screen/common/splash/bloc/splash_bloc.dart';
import 'package:app/screen/dashboard/room/bloc/room_bloc.dart';
import 'package:app/screen/dashboard/services/bloc/service_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProviders {
  static get providers => [
        BlocProvider(
          create: (context) => SplashBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => TokenBloc(),
        ),
        BlocProvider(
          create: (context) => RoomBloc(),
        ),
        BlocProvider(
          create: (context) => ServiceBloc(),
        ),
        BlocProvider(
          create: (context) => MainGetBloc(),
        ),
      ];
}
