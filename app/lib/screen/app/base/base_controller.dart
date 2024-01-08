import 'package:app/screen/app/booking/booking_page.dart';
import 'package:app/screen/app/fav/fav.dart';
import 'package:app/screen/app/home/home.dart';
import 'package:app/screen/app/profile/user_profile.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:flutter/material.dart';

class AppBaseController {
  List<Widget> screens = [
    const AppHomePage(),
    const AppBookingPage(),
    const AppFavouritesPage(),
    const AppProfilePage(),
  ];
  StateHandlerBloc baseBloc = StateHandlerBloc();
}

AppBaseController appBaseController = AppBaseController();
