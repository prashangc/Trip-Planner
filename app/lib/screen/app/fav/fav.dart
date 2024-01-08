import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/app/fav/model/fav_model.dart';
import 'package:app/screen/app/home/cards/hotel_details.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_navigations.dart';
import 'package:app/utils/my_rating_bar.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_app_bar.dart';
import 'package:app/widgets/my_bloc_builder.dart';
import 'package:app/widgets/my_cached_network_image.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

class AppFavouritesPage extends StatelessWidget {
  const AppFavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    StateHandlerBloc lengthBloc = StateHandlerBloc();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimary,
        automaticallyImplyLeading: false,
        toolbarHeight: 0.0,
      ),
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: maxWidth(context),
        height: maxHeight(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myAppBar('Hotels', 'You Liked', lengthBloc),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: kPrimary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            )),
                        width: maxWidth(context),
                        height: 50.0,
                      ),
                      Expanded(
                        child: Container(
                          width: maxWidth(context),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 25.0,
                    bottom: 25.0,
                    left: 20.0,
                    right: 20.0,
                    child: Column(
                      children: [
                        menu(context, lengthBloc),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menu(context, StateHandlerBloc lengthBloc) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(
          color: kWhite,
          boxShadow: [BoxShadow(color: kGrey, offset: Offset(3, 3))],
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Expanded(
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              physics: const BouncingScrollPhysics(),
              child: myBlocBuilder(
                  endpoint: getDotEnvValue('FAVOURITES'),
                  mainGetBloc: MainGetBloc(),
                  emptyMsg: 'No any favourites.',
                  subtitle: '',
                  card: (resp) {
                    List<FavouriteModel> favModel = List<FavouriteModel>.from(
                        resp.map((i) => FavouriteModel.fromJson(i)));
                    lengthBloc.storeData(data: favModel.length);
                    return ListView.builder(
                        itemCount: favModel.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 12.0),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (ctx, i) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                go(
                                    context: context,
                                    screen: HotelDetails(
                                      hotelModel: favModel[i].hotel!,
                                    ));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      myCachedNetworkImage(
                                        myWidth: maxWidth(context) / 3,
                                        myHeight: maxHeight(context) / 8,
                                        myImage: favModel[i]
                                            .hotel!
                                            .profile!
                                            .gallery![0],
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                favModel[i]
                                                    .hotel!
                                                    .profile!
                                                    .name
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: kStyle14B,
                                              ),
                                              sizedBox2(),
                                              myRatingBar(4),
                                              sizedBox2(),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    size: 14.0,
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      favModel[i]
                                                          .hotel!
                                                          .profile!
                                                          .address
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: kStyle12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  i == favModel.length - 1
                                      ? Container()
                                      : const Divider(),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  context: context)),
        ),
      ),
    );
  }
}
