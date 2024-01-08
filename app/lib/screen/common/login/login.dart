import 'package:app/screen/common/login/bloc/login_bloc.dart';
import 'package:app/screen/common/login/bloc/login_state.dart';
import 'package:app/screen/common/login/cards/form_card.dart';
import 'package:app/screen/common/login/cards/title_card.dart';

import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_focus_remover.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKeys = List.generate(2, (index) => GlobalKey<FormState>());
  @override
  Widget build(BuildContext context) {
    LoginState model = BlocProvider.of<LoginBloc>(context).state;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () => myFocusRemover(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          width: maxWidth(context),
          height: maxHeight(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                kIsWeb
                    ? "assets/web/login_bg.png"
                    : "assets/mobile/login_bg.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width:
                    maxWidth(context) > 600.0 ? 600.0 : maxWidth(context) * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    titleCard(context,
                        title:
                            kIsWeb ? 'Hotel Dashboard' : 'GET READY TO TRAVEL'),
                    sizedBox12(),
                    formCard(context, model, formKeys),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
