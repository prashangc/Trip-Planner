import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/app/home/model/review_model.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_rating_bar.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_bloc_builder.dart';
import 'package:app/widgets/my_cached_network_image.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget reviews(context, MainGetBloc reviewBloc) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews :',
          style: kStyle14B,
        ),
        sizedBox16(),
        myBlocBuilder(
          endpoint: getDotEnvValue('REVIEW'),
          mainGetBloc: reviewBloc,
          emptyMsg: 'No any reviews',
          subtitle: '',
          card: (resp) {
            List<ReviewModel> reviewModel = List<ReviewModel>.from(
                resp.map((i) => ReviewModel.fromJson(i)));
            return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: reviewModel.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      width: maxWidth(context),
                      decoration: BoxDecoration(
                          color: kWhite,
                          boxShadow: const [
                            BoxShadow(color: kGrey, offset: Offset(3, 3))
                          ],
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Row(
                        children: [
                          myCachedNetworkImageCircle(
                              myWidth: 50.0, myHeight: 50.0, myImage: ''),
                          sizedBox16(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      reviewModel[i].user!.name!,
                                      style: kStyle14B,
                                    ),
                                    myRatingBar(
                                      reviewModel[i].rating!,
                                    ),
                                  ],
                                ),
                                sizedBox8(),
                                Text(
                                  reviewModel[i].review!,
                                  style: kStyle14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
                });
          },
          context: context,
        ),
      ],
    ),
  );
}
