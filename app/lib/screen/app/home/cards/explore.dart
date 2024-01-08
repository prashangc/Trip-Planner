import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_cached_network_image.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget exploreCard(context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    decoration: const BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        )),
    child: Column(
      children: [
        sizedBox16(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trip',
                  style: kStyle18B.copyWith(
                    color: kWhite,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  'Planner',
                  style: kStyle18B.copyWith(
                    color: kWhite,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            myCachedNetworkImageCircle(
              myWidth: 40.0,
              myHeight: 40.0,
              myImage: '',
            ),
          ],
        ),
        sizedBox16(),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                size: 16,
                color: kBlack,
              ),
              sizedBox16(),
              Text(
                'Search here',
                style: kStyle12,
              ),
              sizedBox12(),
            ],
          ),
        ),
        sizedBox16(),
      ],
    ),
  );
}
