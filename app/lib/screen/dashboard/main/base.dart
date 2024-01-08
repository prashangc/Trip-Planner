import 'package:app/bloc/token/token_bloc.dart';
import 'package:app/bloc/token/token_state.dart';
import 'package:app/screen/dashboard/main/base_controller.dart';
import 'package:app/screen/dashboard/main/cards/nav_bar.dart';
import 'package:app/screen/dashboard/main/cards/side_nav_bar.dart';
import 'package:app/screen/dashboard/main/model/side_nav_model.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasePageDashboard extends StatelessWidget {
  const BasePageDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileModel profile = BlocProvider.of<TokenBloc>(context).state.profile!;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: maxWidth(context),
        height: maxHeight(context),
        child: StreamBuilder<dynamic>(
            initialData: (profile.address == null ||
                    profile.latitude == null ||
                    profile.longitude == null ||
                    profile.gallery!.isEmpty)
                ? 3
                : 0,
            stream: baseController.baseState.stateStream,
            builder: (cxt, s) {
              return Row(
                children: [
                  Container(
                    width: maxWidth(context) / 5,
                    height: maxHeight(context),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    color: kBlack,
                    child: sideNavBarCard(s.data, context),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        color: backgroundColor,
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
                        width: maxWidth(context),
                        height: maxHeight(context),
                        child: Column(
                          children: [
                            navBarCard(context, navList[s.data]),
                            Expanded(
                              child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: baseController.screens.length,
                                  itemBuilder: (c, i) {
                                    return baseController.screens[s.data];
                                  }),
                            ),
                          ],
                        )),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
