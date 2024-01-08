import 'package:app/utils/my_textstyles.dart';
import 'package:flutter/material.dart';

Widget myFormCard({required String title, required Widget ui}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 1,
        child: Text(title, style: kStyle14B),
      ),
      Expanded(
        flex: 2,
        child: ui,
      ),
    ],
  );
}
