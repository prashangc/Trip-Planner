import 'package:app/utils/my_colors.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget myExpansionTile(
    {required BuildContext context,
    required Widget title,
    required Widget children}) {
  return Theme(
    data: Theme.of(context).copyWith(
      unselectedWidgetColor: kPrimary,
      primaryColor: kPrimary,
      dividerColor: Colors.transparent,
    ),
    child: ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      dense: true,
      horizontalTitleGap: 0.0,
      minLeadingWidth: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 11),
        child: ExpansionTile(
            initiallyExpanded: true,
            iconColor: kPrimary,
            maintainState: true,
            tilePadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: maxWidth(context),
              child: title,
            ),
            children: <Widget>[children]),
      ),
    ),
  );
}
