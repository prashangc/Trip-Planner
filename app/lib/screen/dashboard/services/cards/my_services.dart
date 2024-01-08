import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/dashboard/room/model/hotel_model.dart';
import 'package:app/screen/dashboard/services/cards/delete_service_pop_up.dart';
import 'package:app/screen/dashboard/services/cards/edit_service_pop_up.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_bloc_builder.dart';
import 'package:app/widgets/my_container.dart';
import 'package:app/widgets/my_empty_card.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget myServices(context) {
  MainGetBloc listOfServiceBloc = MainGetBloc();
  return myBlocBuilder(
    subtitle: 'Please add services',
    mainGetBloc: listOfServiceBloc,
    endpoint: getDotEnvValue('HOTEL'),
    emptyMsg: 'No any services',
    card: (resp) {
      List<HotelModel> hotelModel =
          List<HotelModel>.from(resp.map((i) => HotelModel.fromJson(i)));
      return hotelModel[0].service!.isEmpty
          ? myEmptyCard(
              context: context,
              emptyMsg: 'No any services added',
              subTitle: 'Please add services.')
          : myContainer(
              widget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 1, child: Text('S.N.', style: kStyle12B)),
                        Expanded(
                            flex: 1,
                            child: Text('Service Name.', style: kStyle12B)),
                        Expanded(
                            flex: 1,
                            child: Text('Service Price', style: kStyle12B)),
                        Expanded(
                            flex: 2, child: Text('Actions', style: kStyle12B)),
                      ],
                    ),
                    const Divider(),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: hotelModel[0].service!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (c, i) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${i + 1}.',
                                    style: kStyle12B,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    hotelModel[0]
                                        .service![i]
                                        .serviceName
                                        .toString(),
                                    style: kStyle12B,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Rs. ${hotelModel[0].service![i].price!.numberDecimal}',
                                    style: kStyle12B,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      myActionsButton(
                                        bgColor: kOrange,
                                        context: context,
                                        icon: Icons.edit,
                                        onTap: () {
                                          editServiceAlertDialog(
                                              context,
                                              hotelModel[0].service![i],
                                              listOfServiceBloc);
                                        },
                                      ),
                                      sizedBox12(),
                                      myActionsButton(
                                        bgColor: kRed,
                                        context: context,
                                        icon: Icons.delete,
                                        onTap: () {
                                          deleteServiceAlertDialog(
                                              context,
                                              hotelModel[0].service![i],
                                              listOfServiceBloc);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
    },
    context: context,
  );
}

Widget myActionsButton(
    {required context,
    required Color bgColor,
    required IconData icon,
    required Function onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: CircleAvatar(
      backgroundColor: bgColor,
      radius: 12.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          icon,
          color: kWhite,
          size: 14.0,
        ),
      ),
    ),
  );
}
