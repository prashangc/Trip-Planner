import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:flutter/material.dart';

Widget notificationCard() {
  return CircleAvatar(
    radius: 24.0,
    backgroundColor: kWhite,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(
          Icons.notifications,
        ),
        Positioned(
          right: -5,
          top: -3,
          child: CircleAvatar(
            radius: 8.0,
            backgroundColor: kRed,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: FittedBox(
                child: Text(
                  '12',
                  style: kStyle12.copyWith(fontSize: 12.0, color: kWhite),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
