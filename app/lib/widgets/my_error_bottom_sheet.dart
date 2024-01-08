import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

errorBottomSheet(
    {required context, required String data, required int statusCode}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: backgroundColor,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    routeSettings: ModalRoute.of(context)!.settings,
    builder: ((builder) => SizedBox(
          width: maxWidth(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              sizedBox32(),
              Stack(
                children: [
                  SizedBox(
                    width: maxWidth(context),
                    height: maxHeight(context) / 4,
                    child: Image.asset(
                      'assets/error/error.png',
                    ),
                  ),
                  Positioned(
                    left: 1,
                    right: 1,
                    bottom: (maxHeight(context) / 3.5) / 2,
                    child: Text(
                      statusCode.toString(),
                      textAlign: TextAlign.center,
                      style: kStyle18B.copyWith(fontSize: 40.0),
                    ),
                  ),
                ],
              ),
              sizedBox32(),
              Text(
                data,
                style: kStyle12B.copyWith(
                  color: kRed,
                  fontSize: 16.0,
                ),
              ),
              sizedBox32(),
            ],
          ),
        )),
  );
}
