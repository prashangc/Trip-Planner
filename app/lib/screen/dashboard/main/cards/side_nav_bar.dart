import 'package:app/bloc/token/token_bloc.dart';
import 'package:app/bloc/token/token_state.dart';
import 'package:app/screen/dashboard/main/base_controller.dart';
import 'package:app/screen/dashboard/main/cards/profile.dart';
import 'package:app/screen/dashboard/main/model/side_nav_model.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/logout.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget sideNavBarCard(index, context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: maxWidth(context) / 8,
              height: 100.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/mobile/logo.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: navList.length,
                  itemBuilder: (c, i) {
                    return GestureDetector(
                      onTap: () {
                        ProfileModel profile =
                            BlocProvider.of<TokenBloc>(context).state.profile!;
                        if (profile.address == null ||
                            profile.latitude == null ||
                            profile.longitude == null ||
                            profile.gallery!.isEmpty) {
                          baseController.baseState.storeData(data: 3);
                        } else {
                          baseController.baseState.storeData(data: i);
                        }
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                              color: index == i ? kOrange : kTransparent,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            children: [
                              Icon(
                                navList[i].icon,
                                color: kWhite,
                              ),
                              sizedBox12(),
                              Text(
                                navList[i].name,
                                style: kStyle12.copyWith(
                                  color: kWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedBox32(),
          profileCard(context),
          const SizedBox(height: 20.0),
          logoutCard(context),
        ],
      ),
    ],
  );
}
