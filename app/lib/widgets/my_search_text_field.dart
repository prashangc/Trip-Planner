import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:flutter/material.dart';

Widget mySearchTextFormField({
  required BuildContext context,
  required String labelText,
  ValueChanged<String>? onValueChanged,
}) {
  return Column(
    children: [
      TextFormField(
        maxLines: 1,
        cursorColor: kBlack,
        style: kStyle12,
        onChanged: (String value) {
          onValueChanged!(value);
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          filled: true,
          fillColor: kWhite.withOpacity(0.6),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24.0),
            ),
            borderSide: BorderSide(color: kTransparent, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24.0),
            ),
            borderSide: BorderSide(color: kPrimary, width: 1.5),
          ),
          errorStyle: kStyle12.copyWith(color: kRed),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24.0),
            ),
            borderSide: BorderSide(color: kBlack, width: 1.5),
          ),
          hintText: labelText,
          hintStyle: kStyle12.copyWith(color: kBlack),
        ),
      ),
    ],
  );
}
