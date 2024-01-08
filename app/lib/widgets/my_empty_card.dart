import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget myEmptyCard({
  required BuildContext context,
  required String emptyMsg,
  required String subTitle,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      sizedBox32(),
      Expanded(
        child: Image.asset(
          'assets/error/error.png',
        ),
      ),
      sizedBox2(),
      SizedBox(
        width: maxWidth(context) / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.refresh_outlined,
              color: kPrimary,
              size: 30.0,
            ),
            sizedBox12(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  emptyMsg,
                  style: kStyle14B.copyWith(
                    color: kPrimary,
                  ),
                ),
              ],
            ),
            sizedBox2(),
            Text(
              subTitle,
              overflow: TextOverflow.ellipsis,
              style: kStyle12.copyWith(color: kRed),
            ),
          ],
        ),
      ),
    ],
  );
}
