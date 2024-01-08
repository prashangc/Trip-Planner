import 'package:app/screen/common/splash/bloc/splash_bloc.dart';
import 'package:app/screen/common/splash/bloc/splash_event.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context)
        .add(CloseSplashScreenEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: Center(
        child: FlutterLogo(
          size: maxWidth(context) / 4,
        ),
      ),
    );
  }
}
