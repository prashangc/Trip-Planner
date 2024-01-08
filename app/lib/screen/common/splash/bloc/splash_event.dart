import 'package:flutter/material.dart';

abstract class SplashEvent {}

class CloseSplashScreenEvent extends SplashEvent {
  BuildContext context;
  CloseSplashScreenEvent({required this.context});
}

class GetStartedButtonTapEvent extends SplashEvent {}

class ShowMainScreenEvent extends SplashEvent {
  BuildContext context;
  ShowMainScreenEvent({required this.context});
}

class ShowLoginScreenEvent extends SplashEvent {
  BuildContext context;
  ShowLoginScreenEvent({required this.context});
}
