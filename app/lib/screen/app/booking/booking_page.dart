import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/screen/app/booking/model/booking_model.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_current_date_time.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_app_bar.dart';
import 'package:app/widgets/my_bloc_builder.dart';
import 'package:app/widgets/my_cached_network_image.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

class AppBookingPage extends StatelessWidget {
  const AppBookingPage({super.key});

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
            myAppBar('Hotels', 'You Booked', lengthBloc),
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
                  endpoint: getDotEnvValue('BOOKING'),
                  mainGetBloc: MainGetBloc(),
                  emptyMsg: 'No any hotel booked.',
                  subtitle: '',
                  card: (resp) {
                    List<BookingModel> bookingModel = List<BookingModel>.from(
                        resp.map((i) => BookingModel.fromJson(i)));
                    lengthBloc.storeData(data: bookingModel.length);
                    return ListView.builder(
                        itemCount: bookingModel.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 12.0),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (ctx, i) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12.0),
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color: kGrey, offset: Offset(3, 3))
                                ],
                                color: kWhite,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              width: maxWidth(context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  sizedBox8(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Booking Date',
                                              style: kStyle14,
                                            ),
                                            Text(
                                              currentDate,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: kStyle14B,
                                            ),
                                          ],
                                        ),
                                        sizedBox2(),
                                      ],
                                    ),
                                  ),
                                  sizedBox2(),
                                  sizedBox2(),
                                  const Divider(
                                    color: backgroundColor,
                                  ),
                                  sizedBox2(),
                                  sizedBox2(),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 12.0),
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        myCachedNetworkImageCircle(
                                          myHeight: 60.0,
                                          myWidth: 60.0,
                                          myImage: bookingModel[i]
                                              .hotel!
                                              .profile!
                                              .gallery![0]
                                              .toString(),
                                        ),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  bookingModel[i]
                                                      .hotel!
                                                      .profile!
                                                      .name
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: kStyle14B),
                                              sizedBox2(),
                                              sizedBox2(),
                                              Text(
                                                bookingModel[i]
                                                    .hotel!
                                                    .profile!
                                                    .phone
                                                    .toString(),
                                                style: kStyle12.copyWith(
                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: 11.0,
                                                ),
                                              ),
                                              sizedBox2(),
                                              sizedBox2(),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Payment status:',
                                                    style: kStyle12,
                                                  ),
                                                  Text(
                                                    ' Paid',
                                                    style: kStyle12B.copyWith(
                                                        color: kGreen),
                                                  ),
                                                ],
                                              ),
                                              sizedBox2(),
                                              sizedBox2(),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12.0),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 0.0, 8.0, 0.0),
                                    child: Column(
                                      children: [
                                        sizedBox2(),
                                        const Divider(
                                          color: backgroundColor,
                                        ),
                                        sizedBox2(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Status: ',
                                                  style: kStyle12B,
                                                ),
                                                Text(
                                                  bookingModel[i].status == 0
                                                      ? 'Waiting for approval'
                                                      : bookingModel[i]
                                                                  .status ==
                                                              1
                                                          ? 'Booked'
                                                          : bookingModel[i]
                                                                      .status ==
                                                                  2
                                                              ? 'Rejected'
                                                              : bookingModel[i]
                                                                          .status ==
                                                                      3
                                                                  ? 'Cancelled'
                                                                  : 'Completed',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: kStyle12B.copyWith(
                                                    color: bookingModel[i]
                                                                .status ==
                                                            0
                                                        ? kBlue
                                                        : bookingModel[i]
                                                                    .status ==
                                                                1
                                                            ? kGreen
                                                            : bookingModel[i]
                                                                        .status ==
                                                                    2
                                                                ? kRed
                                                                : bookingModel[i]
                                                                            .status ==
                                                                        3
                                                                    ? kRed
                                                                    : kGreen,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            bookingModel[i].status == 0
                                                ? GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4.0,
                                                          horizontal: 6.0),
                                                      decoration: BoxDecoration(
                                                        color: kRed
                                                            .withOpacity(0.9),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(5.0),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Cancel Booking',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            kStyle12.copyWith(
                                                          color: kWhite,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                        sizedBox12(),
                                      ],
                                    ),
                                  ),
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
