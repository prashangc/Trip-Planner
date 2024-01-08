import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_focus_remover.dart';
import 'package:app/utils/my_scroll_to_textform.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_loading_animation.dart';
import 'package:flutter/material.dart';

Widget myButton({
  required BuildContext context,
  required double width,
  required double height,
  required String text,
  bool? isBold,
  StateHandlerBloc? bloc,
  Color? color,
  required Function myTap,
  Function? extraValidation,
  validateKeys,
}) {
  return GestureDetector(
    onTap: () {
      myFocusRemover(context);
      if (validateKeys != null) {
        bool? isFormValid;
        List<int> listOfInvalidIndex = [];
        listOfInvalidIndex.clear();
        for (int i = 0; i < validateKeys.length; i++) {
          isFormValid = validateKeys[i].currentState?.validate();
          if (extraValidation != null) {
            extraValidation();
          }
          if (isFormValid == false) {
            listOfInvalidIndex.add(i);
            if (listOfInvalidIndex.isNotEmpty) {
              scrollToWidget(validateKeys[i]);
            }
          }
        }
        if (listOfInvalidIndex.isEmpty) {
          myTap();
        }
      } else {
        myTap();
      }
    },
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: color ?? kPrimary,
      ),
      alignment: Alignment.center,
      child: StreamBuilder<dynamic>(
          initialData: 0,
          stream: bloc?.stateStream,
          builder: (c, s) {
            return s.data == 1
                ? const AnimatedLoading()
                : Text(
                    text,
                    style: kStyle18B.copyWith(color: kWhite, letterSpacing: 1),
                  );
          }),
    ),
  );
}
