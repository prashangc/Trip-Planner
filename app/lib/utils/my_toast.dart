import 'package:app/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToast {
  Future<dynamic> toast({required String msg, required BuildContext context}) {
    return Fluttertoast.showToast(
      textColor: kWhite,
      backgroundColor: kBlack,
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}

final myToast = MyToast();
