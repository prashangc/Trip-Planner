import 'package:flutter/material.dart';

go({required BuildContext? context, required Widget? screen}) =>
    Navigator.push(context!, MaterialPageRoute(builder: (c) => screen!));
