import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_container.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget checkoutCard({
  required String title,
  required int total,
  required IconData icon,
  required Color color,
}) {
  return Expanded(
    child: myContainer(
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  total.toString(),
                  style: kStyle14B.copyWith(fontSize: 22.0),
                ),
                sizedBox8(),
                Text(
                  title,
                  style: kStyle12.copyWith(color: kGrey),
                ),
              ],
            ),
          ),
          sizedBox12(),
          CircleAvatar(
            backgroundColor: color.withOpacity(0.4),
            radius: 24.0,
            child: Icon(
              icon,
              size: 18.0,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}
