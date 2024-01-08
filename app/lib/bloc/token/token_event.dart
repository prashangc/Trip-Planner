import 'package:app/bloc/token/token_state.dart';
import 'package:flutter/material.dart';

abstract class TokenEvent {}

class StoreTokenEvent extends TokenEvent {
  TokenState loginResp;
  BuildContext context;
  StoreTokenEvent({required this.loginResp, required this.context});
}
