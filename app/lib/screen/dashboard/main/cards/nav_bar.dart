import 'package:app/screen/dashboard/main/cards/notification.dart';
import 'package:app/screen/dashboard/main/cards/search.dart';
import 'package:app/screen/dashboard/main/model/side_nav_model.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_current_date_time.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget navBarCard(context, SideNavModel data) {
  return SizedBox(
    width: maxWidth(context),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: kStyle18B,
                  ),
                  sizedBox8(),
                  Text(
                    currentDate,
                    style: kStyle12.copyWith(color: kGrey),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: searchCard(context)),
                  sizedBox12(),
                  notificationCard(),
                ],
              ),
            ),
          ],
        ),
        sizedBox32(),
        SizedBox(
          width: maxWidth(context) - (maxWidth(context) / 5),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 1.5,
                  color: kGrey,
                ),
              ),
              Expanded(
                flex: 1,
                child: DefaultTabController(
                  length: data.secondTabText == null ? 1 : 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBar(
                      dividerColor: kTransparent,
                      labelColor: kGreen,
                      onTap: (i) => data.bloc != null
                          ? data.bloc!.storeData(data: i)
                          : null,
                      unselectedLabelColor: kAmber,
                      indicatorColor: kTransparent,
                      indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(width: 5.0, color: kBlack),
                          insets: EdgeInsets.symmetric(horizontal: 16.0)),
                      tabs: data.secondTabText == null
                          ? [
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.visibility,
                                      size: 14.0,
                                      color: kBlack,
                                    ),
                                    sizedBox8(),
                                    Text(
                                      data.firstTabText,
                                      style: kStyle14,
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          : [
                              Tab(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.visibility,
                                      size: 14.0,
                                      color: kBlack,
                                    ),
                                    sizedBox8(),
                                    Text(
                                      data.firstTabText,
                                      style: kStyle14,
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      color: kBlack,
                                      size: 14.0,
                                    ),
                                    sizedBox8(),
                                    Text(
                                      data.secondTabText!,
                                      style: kStyle14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        sizedBox32(),
      ],
    ),
  );
}
