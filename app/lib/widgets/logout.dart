import 'package:app/screen/common/login/login.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_navigations.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget logoutCard(context) {
  return GestureDetector(
    onTap: () {
      go(context: context, screen: const LoginScreen());
    },
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: const BoxDecoration(
            color: kRed, borderRadius: BorderRadius.all(Radius.circular(12.0))),
        margin: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            const Icon(
              Icons.logout_outlined,
              color: kWhite,
            ),
            sizedBox12(),
            Text(
              'Logout',
              style: kStyle12.copyWith(
                color: kWhite,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
