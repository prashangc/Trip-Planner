import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/app/home/cards/category.dart';
import 'package:app/screen/app/home/cards/explore.dart';
import 'package:app/screen/app/home/cards/hotel.dart';
import 'package:app/screen/app/home/cards/review.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  MainGetBloc categoryBloc = MainGetBloc();
  MainGetBloc hotelBloc = MainGetBloc();
  MainGetBloc reviewBloc = MainGetBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimary,
        automaticallyImplyLeading: false,
        toolbarHeight: 0.0,
      ),
      body: SizedBox(
        width: maxWidth(context),
        height: maxHeight(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            exploreCard(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    sizedBox16(),
                    categoryCard(context, categoryBloc),
                    sizedBox16(),
                    hotelCard(context, hotelBloc),
                    sizedBox16(),
                    reviews(context, reviewBloc),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
