import 'package:app/screen/dashboard/home/home_dashboard.dart';
import 'package:app/screen/dashboard/profile/profile_dashboard.dart';
import 'package:app/screen/dashboard/room/room.dart';
import 'package:app/screen/dashboard/services/services_dashboard.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:flutter/material.dart';

class BaseController {
  List<Widget> screens = [
    const HomePageDashboard(),
    const RoomDashboard(),
    const ServicesDashboard(),
    const ProfileDashboard(),
  ];
  StateHandlerBloc baseState = StateHandlerBloc();
}

BaseController baseController = BaseController();
