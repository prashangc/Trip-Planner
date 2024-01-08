import 'package:app/services/state/state_handler_bloc.dart';
import 'package:flutter/material.dart';

StateHandlerBloc roomTabBarBloc = StateHandlerBloc();
StateHandlerBloc serviceTabBarBloc = StateHandlerBloc();

class SideNavModel {
  final IconData icon;
  final String name;
  final String firstTabText;
  final String? secondTabText;
  final StateHandlerBloc? bloc;

  SideNavModel({
    required this.icon,
    required this.name,
    required this.firstTabText,
    this.bloc,
    this.secondTabText,
  });
}

List<SideNavModel> navList = [
  SideNavModel(
    icon: Icons.home,
    name: 'Home',
    firstTabText: 'User Analytics and Statistics',
  ),
  SideNavModel(
    icon: Icons.bed,
    name: 'Room',
    firstTabText: 'My Rooms',
    secondTabText: 'Add Room',
    bloc: roomTabBarBloc,
  ),
  SideNavModel(
    icon: Icons.room_service,
    name: 'Services',
    firstTabText: 'My Services',
    secondTabText: 'Add Services',
    bloc: serviceTabBarBloc,
  ),
  SideNavModel(
    icon: Icons.perm_identity,
    name: 'Profile',
    firstTabText: 'Profile Details',
  ),
];
