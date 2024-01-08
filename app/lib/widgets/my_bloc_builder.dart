import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/bloc/getApi/main_get_event.dart';
import 'package:app/bloc/getApi/main_get_state.dart';
import 'package:app/widgets/my_circle_loading.dart';
import 'package:app/widgets/my_empty_card.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget myBlocBuilder({
  required String endpoint,
  required MainGetBloc mainGetBloc,
  required String emptyMsg,
  required String subtitle,
  required Widget Function(dynamic resp) card,
  required BuildContext context,
}) {
  return BlocProvider(
    create: (context) => mainGetBloc,
    child: BlocBuilder<MainGetBloc, MainGetState>(
      builder: (blocContext, state) {
        if (state is MainGetLoadingState || state is MainRefreshState) {
          BlocProvider.of<MainGetBloc>(blocContext).add(
            MainGetLoadingEvent(
              endpoint: endpoint,
              context: context,
              emptyMsg: emptyMsg,
            ),
          );
          return SizedBox(
              width: maxWidth(context),
              height: 100,
              child: const CircleLoading());
        } else if (state is MainGetSuccessState) {
          return card(state.resp);
        } else if (state is MainGetEmptyState) {
          return myEmptyCard(
              context: context, emptyMsg: emptyMsg, subTitle: subtitle);
        } else if (state is MainGetRequestTimeoutState) {
          return const Text('timeout');
        } else if (state is MainGetNoInternetState) {
          return const Text('no internet');
        } else if (state is MainGetErrorState) {
          return Text('server error ${state.statusCode}');
        } else {
          return const Text('something went wrong');
        }
      },
    ),
  );
}
