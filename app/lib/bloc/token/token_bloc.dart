import 'package:app/bloc/token/token_event.dart';
import 'package:app/bloc/token/token_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  TokenBloc() : super(TokenState()) {
    on<StoreTokenEvent>((event, emit) {
      BlocProvider.of<TokenBloc>(event.context).state.token =
          event.loginResp.token;
    });
  }
}
