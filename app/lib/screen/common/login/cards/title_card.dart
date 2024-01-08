import 'package:app/screen/dashboard/main/base.dart';
import 'package:app/utils/my_navigations.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:flutter/material.dart';

Widget titleCard(context, {required String title}) {
  return GestureDetector(
    onTap: () => go(context: context, screen: const BasePageDashboard()),
    child: Text(
      title,
      style: kStyle18B,
    ),
  );
}
