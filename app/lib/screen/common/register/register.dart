import 'package:app/screen/common/register/bloc/register_bloc.dart';
import 'package:app/screen/common/register/bloc/register_state.dart';
import 'package:app/screen/common/register/cards/main_card.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_focus_remover.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKeys = List.generate(5, (index) => GlobalKey<FormState>());
  @override
  Widget build(BuildContext context) {
    RegisterState model = BlocProvider.of<RegisterBloc>(context).state;
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
                    ? "assets/web/register_bg.jpg"
                    : "assets/mobile/register_bg.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: mainForm(context, formKeys, model)),
          ),
        ),
      ),
    );
  }
}
