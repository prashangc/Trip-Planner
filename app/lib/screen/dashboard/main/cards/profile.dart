import 'package:app/bloc/token/token_bloc.dart';
import 'package:app/bloc/token/token_state.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget profileCard(context) {
  ProfileModel profile = BlocProvider.of<TokenBloc>(context).state.profile!;
  return GestureDetector(
    onTap: () {},
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Row(
        children: [
          Container(
            width: 35.0,
            height: 35.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  'assets/mobile/login_bg.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          sizedBox12(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name.toString(),
                style: kStyle12B.copyWith(
                  color: kWhite,
                ),
              ),
              sizedBox2(),
              Text(
                profile.email.toString(),
                style: kStyle12.copyWith(
                  color: kOrange,
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
