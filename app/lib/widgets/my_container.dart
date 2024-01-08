import 'package:app/utils/my_colors.dart';
import 'package:flutter/material.dart';

Widget myContainer({required Widget widget}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: const BoxDecoration(
      color: kWhite,
      borderRadius: BorderRadius.all(
        Radius.circular(14.0),
      ),
    ),
    child: widget,
  );
}
