import 'package:app/screen/app/home/cards/hotel_details.dart';
import 'package:app/screen/dashboard/room/model/hotel_model.dart';
import 'package:app/utils/grid_view_delegate.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_navigations.dart';
import 'package:app/utils/my_rating_bar.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_bloc_builder.dart';
import 'package:app/widgets/my_cached_network_image.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget hotelCard(context, hotelBloc) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find Hotels',
          style: kStyle14B,
        ),
        sizedBox16(),
        myBlocBuilder(
          endpoint: getDotEnvValue('HOTEL'),
          subtitle: '',
          mainGetBloc: hotelBloc,
          emptyMsg: 'No any hotels found',
          card: (resp) {
            List<HotelModel> hotelModel =
                List<HotelModel>.from(resp.map((i) => HotelModel.fromJson(i)));
            return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 2,
                        height: 200,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                itemCount: hotelModel.length < 4 ? hotelModel.length : 4,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      go(
                          context: context,
                          screen: HotelDetails(
                            hotelModel: hotelModel[index],
                          ));
                    },
                    child: Container(
                      width: maxWidth(context),
                      decoration: BoxDecoration(
                          color: kWhite,
                          boxShadow: const [
                            BoxShadow(color: kGrey, offset: Offset(3, 3))
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: myCachedNetworkImage(
                              myWidth: maxWidth(context),
                              myHeight: maxHeight(context),
                              myImage: hotelModel[index].profile!.gallery![0],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotelModel[index].profile!.name.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: kStyle14B,
                                ),
                                myRatingBar(3, size: 12.0),
                                sizedBox2(),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 12.0,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Flexible(
                                      child: Text(
                                        hotelModel[index]
                                            .profile!
                                            .address
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: kStyle12B.copyWith(
                                          color: kBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          context: context,
        ),
      ],
    ),
  );
}
