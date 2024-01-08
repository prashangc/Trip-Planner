import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget myTextFormField({
  required BuildContext context,
  required String labelText,
  required String errorMessage,
  ValueChanged<String>? onValueChanged,
  String? title,
  bool? isNumber,
  bool? isEmail,
  bool? isTextArea,
  StateHandlerBloc? visibilityIconBloc,
  required form,
  IconData? prefixIcon,
  List<String>? passwordList,
  bool? readOnly,
}) {
  StateHandlerBloc errorColorBloc = StateHandlerBloc();
  // String? pw, cpw;
  // if (passwordList != null) {
  //   pw = passwordList[0];
  //   cpw = passwordList[1];
  // }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title == null
          ? Container()
          : Text(
              title,
              style: kStyle14B,
            ),
      title == null ? Container() : sizedBox16(),
      Form(
        key: form,
        child: StreamBuilder<dynamic>(
            initialData: visibilityIconBloc != null ? true : false,
            stream: visibilityIconBloc?.stateStream,
            builder: (pwContext, pwSnapshot) {
              return StreamBuilder<dynamic>(
                  initialData: false,
                  stream: errorColorBloc.stateStream,
                  builder: (context, errorColorSnapshot) {
                    return TextFormField(
                      maxLines: isTextArea != null ? 5 : 1,
                      readOnly: readOnly ?? false,
                      obscureText: pwSnapshot.data,
                      cursorColor: kBlack,
                      style: kStyle12,
                      keyboardType:
                          isNumber == true ? TextInputType.number : null,
                      onChanged: (String value) {
                        if (value.isEmpty) {
                          errorColorBloc.storeData(data: true);
                        } else {
                          errorColorBloc.storeData(data: false);
                        }
                        onValueChanged!(value);
                        form.currentState?.validate();
                      },
                      decoration: InputDecoration(
                        prefixIcon: prefixIcon == null
                            ? null
                            : Icon(
                                prefixIcon,
                                size: 16,
                                color: kBlack,
                              ),
                        suffixIcon: visibilityIconBloc == null
                            ? null
                            : GestureDetector(
                                onTap: () {
                                  visibilityIconBloc.storeData(
                                      data: !pwSnapshot.data!);
                                },
                                child: Icon(
                                  pwSnapshot.data == false
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 16,
                                  color: kBlack,
                                ),
                              ),
                        errorMaxLines: 2,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 16.0),
                        filled: true,
                        fillColor: kWhite.withOpacity(0.6),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(24.0),
                          ),
                          borderSide:
                              BorderSide(color: kTransparent, width: 0.0),
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
                        hintStyle: kStyle12.copyWith(
                            color: errorColorSnapshot.data == false
                                ? kBlack
                                : kRed),
                      ),
                      validator: (v) {
                        if (isEmail == true && v!.isNotEmpty) {
                          if (!RegExp(r'^[a-zA-Z0-9.@-]+$').hasMatch(v)) {
                            errorColorBloc.storeData(data: true);
                            return '* Sorry, only letters (a-z), numbers (0-9), and periods(.) are allowed.';
                          }
                        }
                        if (visibilityIconBloc != null &&
                            v!.isNotEmpty &&
                            title != 'Confirm Password') {
                          // if (pw != cpw && title == 'Confirm Password') {
                          //   errorColorBloc.storeData(data: true);
                          //   return 'Password doesn\'t match.';
                          // }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[$@!#&]).{8,}$')
                              .hasMatch(v)) {
                            return '* Required: atleast one Uppercase and lowercase letters (A,z), numbers(0-9) and special characters(!, %, @, #, etc.)';
                          }
                        }
                        if (v!.isEmpty) {
                          errorColorBloc.storeData(data: true);
                          return errorMessage;
                        }

                        return null;
                      },
                    );
                  });
            }),
      ),
      sizedBox16(),
    ],
  );
}
