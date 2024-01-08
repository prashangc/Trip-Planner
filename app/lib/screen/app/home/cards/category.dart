import 'package:app/screen/app/home/model/category_model.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_bloc_builder.dart';
import 'package:app/widgets/my_cached_network_image.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget categoryCard(context, categoryBloc) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: myBlocBuilder(
      mainGetBloc: categoryBloc,
      endpoint: getDotEnvValue('CATEGORY'),
      subtitle: '',
      emptyMsg: 'No any categories',
      card: (resp) {
        List<CategoryModel> categoryModel = List<CategoryModel>.from(
            resp.map((i) => CategoryModel.fromJson(i)));
        return SizedBox(
          height: 40.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: categoryModel.length,
            itemBuilder: (c, i) {
              return Container(
                margin: const EdgeInsets.only(right: 8.0),
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: kWhite,
                  boxShadow: [BoxShadow(color: kGrey, offset: Offset(3, 3))],
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                child: Row(
                  children: [
                    myCachedNetworkImage(
                      myWidth: 30.0,
                      myHeight: 30.0,
                      myImage: categoryModel[i].imagePath.toString(),
                      borderRadius: const BorderRadius.all(Radius.circular(0)),
                    ),
                    sizedBox8(),
                    Text(
                      categoryModel[i].category.toString(),
                      style: kStyle12B,
                    ),
                    sizedBox12(),
                  ],
                ),
              );
            },
          ),
        );
      },
      context: context,
    ),
  );
}
