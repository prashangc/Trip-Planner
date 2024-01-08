import 'dart:math';

import 'package:app/utils/my_colors.dart';
import 'package:flutter/material.dart';

class CircleLoading extends StatefulWidget {
  const CircleLoading({Key? key}) : super(key: key);

  @override
  State<CircleLoading> createState() => _CircleLoadingState();
}

class _CircleLoadingState extends State<CircleLoading>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? animationRotation;
  Animation<double>? animationRadiusIn;
  Animation<double>? animationRadiusOut;
  double initialRadius = 30.0;
  double radius = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animationRotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    animationRadiusIn = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _controller!,
            curve: const Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animationRadiusOut = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller!,
            curve: const Interval(0.0, 0.25, curve: Curves.elasticOut)));

    _controller!.addListener(() {
      setState(() {
        if (_controller!.value >= 0.75 && _controller!.value <= 1.0) {
          radius = animationRadiusIn!.value * initialRadius;
        } else if (_controller!.value >= 0.0 && _controller!.value <= 0.25) {
          radius = animationRadiusOut!.value * initialRadius;
        }
      });
    });
    _controller!.repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50.0,
          height: 50,
          child: Center(
            child: RotationTransition(
              turns: animationRotation!,
              child: Stack(
                children: [
                  const Dot(
                    radius: 30.0,
                    color: Color.fromARGB(31, 160, 160, 160),
                  ),
                  Transform.translate(
                    offset: Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
                    child: const Dot(
                      radius: 5.0,
                      color: kRed,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
                    child: const Dot(
                      radius: 5.0,
                      color: kAmber,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
                    child: const Dot(
                      radius: 5.0,
                      color: kPurple,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
                    child: const Dot(
                      radius: 5.0,
                      color: kGreen,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
                    child: const Dot(
                      radius: 5.0,
                      color: kAmber,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
                    child: const Dot(
                      radius: 5.0,
                      color: kBlack,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
                    child: const Dot(
                      radius: 5.0,
                      color: kOrange,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
                    child: const Dot(
                      radius: 5.0,
                      color: kGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  const Dot({Key? key, required this.radius, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          )),
    );
  }
}
