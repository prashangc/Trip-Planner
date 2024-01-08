import 'dart:convert';

import 'package:app/bloc/getApi/main_get_bloc.dart';
import 'package:app/bloc/getApi/main_get_event.dart';
import 'package:app/screen/app/fav/model/fav_model.dart';
import 'package:app/screen/app/home/model/booking_post_model.dart';
import 'package:app/screen/app/home/model/review_model.dart';
import 'package:app/screen/dashboard/room/model/hotel_model.dart';
import 'package:app/services/api/api.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_rating_bar.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_bloc_builder.dart';
import 'package:app/widgets/my_button.dart';
import 'package:app/widgets/my_cached_network_image.dart';
import 'package:app/widgets/my_empty_card.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:app/widgets/my_text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HotelDetails extends StatefulWidget {
  final HotelModel hotelModel;
  const HotelDetails({super.key, required this.hotelModel});

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails>
    with TickerProviderStateMixin {
  PageController pageController = PageController();
  PageController verticalPageController = PageController();
  ScrollController scrollController = ScrollController();
  int activeIndex = 0;
  ScrollController? _scrollController;
  int selectedIndexs = -1;
  StateHandlerBloc addReviewBtnBloc = StateHandlerBloc();
  StateHandlerBloc checkoutBtnBloc = StateHandlerBloc();
  StateHandlerBloc likeButtonBloc = StateHandlerBloc();
  StateHandlerBloc roomInfoBloc = StateHandlerBloc();
  int ratingValue = 5;
  String? reviewValue;
  final formKeys = List.generate(1, (index) => GlobalKey<FormState>());
  MainGetBloc reviewBloc = MainGetBloc();
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    tabController = TabController(length: 3, vsync: this);
    checkIfHotelIsLiked();
  }

  checkIfHotelIsLiked() async {
    Response? favRes = await API()
        .getData(endpoint: getDotEnvValue('FAVOURITES'), context: context);
    if (favRes != null) {
      var finalResp = json.decode(favRes.body.toString());
      List<FavouriteModel> favModel = List<FavouriteModel>.from(
          finalResp.map((i) => FavouriteModel.fromJson(i)));
      List<bool> list = [];
      for (var element in favModel) {
        if (widget.hotelModel.sId == element.hotel!.sId) {
          list.add(true);
        }
      }
      if (list.isEmpty) {
        likeButtonBloc.storeData(data: false);
      } else {
        likeButtonBloc.storeData(data: true);
      }
    } else {
      likeButtonBloc.storeData(data: false);
    }
  }

  likeBtn() async {
    likeButtonBloc.storeData(data: true);
    Response resp = await API().postData(
        context: context,
        model: ReviewModel(hotelID: widget.hotelModel.sId),
        endpoint: getDotEnvValue('FAVOURITES'),
        bloc: StateHandlerBloc(),
        func: (resp) {});
    if (resp.statusCode != 200) {
      likeButtonBloc.storeData(data: false);
    }
  }

  unLikeBtn() async {
    likeButtonBloc.storeData(data: false);
    Response resp = await API().deleteData(
        context: context,
        model: ReviewModel(hotelID: widget.hotelModel.sId),
        endpoint: getDotEnvValue('FAVOURITES'),
        bloc: StateHandlerBloc(),
        func: (resp) {});
    if (resp.statusCode != 200) {
      likeButtonBloc.storeData(data: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 80.0,
        width: maxWidth(context),
        child: Row(
          children: [
            Expanded(
              child: StreamBuilder<dynamic>(
                  initialData: widget.hotelModel.room![0],
                  stream: roomInfoBloc.stateStream,
                  builder: (c, s) {
                    Room room = s.data;
                    return myButton(
                      context: context,
                      color: kOrange,
                      width: maxWidth(context),
                      height: 50.0,
                      text: 'Book',
                      myTap: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: backgroundColor,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            routeSettings: ModalRoute.of(context)!.settings,
                            builder: ((builder) => checkOutBottomSheet(room)));
                      },
                    );
                  }),
            ),
            sizedBox12(),
            CircleAvatar(
              backgroundColor: kOrange,
              radius: 25.0,
              child: StreamBuilder<dynamic>(
                  initialData: null,
                  stream: likeButtonBloc.stateStream,
                  builder: (c, s) {
                    return s.data == null
                        ? const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: CircularProgressIndicator(
                              color: kBlack,
                              backgroundColor: kWhite,
                              strokeWidth: 1,
                            ),
                          )
                        : LikeButton(
                            onTap: (isLiked) async {
                              if (s.data == true) {
                                unLikeBtn();
                              } else if (s.data == false) {
                                likeBtn();
                              }
                              return null;
                            },
                            countBuilder: (likeCount, isLiked, text) =>
                                Container(),
                            circleColor:
                                const CircleColor(start: kWhite, end: kWhite),
                            likeBuilder: (bool isLiked) {
                              return s.data == true
                                  ? const Icon(
                                      Icons.favorite,
                                      color: kWhite,
                                      size: 20.0,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                      color: kWhite,
                                      size: 20.0,
                                    );
                            },
                            likeCount: 665,
                          );
                  }),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: maxWidth(context),
        height: maxHeight(context),
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  double maxScroll = maxHeight(context) - 220.0;
                  if (_scrollController!.offset > maxScroll) {
                    _scrollController!.jumpTo(maxScroll);
                  }
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    imageSlider(),
                    hotelDetails(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30.0,
              left: 12.0,
              child: backBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageSlider() {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                  height: maxHeight(context),
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 400),
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                    pageController = PageController(initialPage: activeIndex);
                  }),
              itemCount: widget.hotelModel.profile!.gallery!.length,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  children: [
                    myCachedNetworkImage(
                      myWidth: maxWidth(context),
                      myHeight: maxHeight(context),
                      myImage:
                          widget.hotelModel.profile!.gallery![index].toString(),
                      borderRadius: const BorderRadius.all(Radius.circular(0)),
                    ),
                    Positioned(
                        child: Container(
                      height: maxHeight(context),
                      width: maxWidth(context),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.3, 1],
                          colors: [
                            kTransparent,
                            kBlack.withOpacity(1),
                          ],
                        ),
                      ),
                      child: const Text(''),
                    ))
                  ],
                );
              },
            ),
            Positioned(
              right: 12.0,
              top: 50.0,
              child: SmoothPageIndicator(
                controller: pageController,
                count: widget.hotelModel.profile!.gallery!.length,
                effect: const ExpandingDotsEffect(
                  dotWidth: 6,
                  dotHeight: 6,
                  activeDotColor: kOrange,
                  spacing: 8,
                  dotColor: backgroundColor,
                ),
              ),
            ),
            Positioned(
                right: 12.0,
                left: 12.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox16(),
                    Text(
                      widget.hotelModel.profile!.name!,
                      style: kStyle18B.copyWith(
                        color: kWhite,
                        fontSize: 25.0,
                      ),
                    ),
                    sizedBox2(),
                    myRatingBar(3),
                    sizedBox8(),
                    const SizedBox(height: 50.0),
                  ],
                ))
          ],
        ),
      ],
    );
  }

  Widget backBtn() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kWhite.withOpacity(0.8),
        ),
        child: const Icon(
          Icons.arrow_back,
          color: kBlack,
          size: 20.0,
        ),
      ),
    );
  }

  Widget hotelDetails() {
    return SafeArea(
      child: Container(
        width: maxWidth(context),
        height: maxHeight(context),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Expanded(
          child: Column(
            children: [
              DefaultTabController(
                length: 3,
                child: TabBar(
                  controller: tabController,
                  padding: EdgeInsets.zero,
                  labelColor: kOrange,
                  indicatorColor: kOrange,
                  enableFeedback: true,
                  physics: const BouncingScrollPhysics(),
                  tabs: [
                    Tab(
                      child: Text(
                        'Rooms',
                        style: kStyle14B,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Services',
                        style: kStyle14B,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Menu',
                        style: kStyle14B,
                      ),
                    ),
                  ],
                ),
              ),
              sizedBox16(),
              SizedBox(
                width: maxWidth(context),
                height: 60,
                child: TabBarView(
                  controller: tabController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    rooms(),
                    services(),
                    Text(
                      'Not available right now',
                      style: kStyle12B,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              reviews(),
              roomPrice(),
            ],
          ),
        ),
      ),
    );
  }

  Widget rooms() {
    StateHandlerBloc roomSelectionBloc = StateHandlerBloc();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.hotelModel.room!.isEmpty
            ? myEmptyCard(
                context: context, emptyMsg: 'No rooms available', subTitle: '')
            : SizedBox(
                height: 40.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.hotelModel.room!.length,
                  itemBuilder: (c, i) {
                    return StreamBuilder<dynamic>(
                        initialData: widget.hotelModel.room!.isEmpty
                            ? 0
                            : widget.hotelModel.room![0].sId,
                        stream: roomSelectionBloc.stateStream,
                        builder: (c, s) {
                          return GestureDetector(
                            onTap: () {
                              roomInfoBloc.storeData(
                                  data: widget.hotelModel.room![i]);
                              roomSelectionBloc.storeData(
                                  data: widget.hotelModel.room![i].sId);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: s.data == widget.hotelModel.room![i].sId
                                    ? kOrange
                                    : kWhite,
                                boxShadow: const [
                                  BoxShadow(color: kGrey, offset: Offset(3, 3))
                                ],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Room no. ${widget.hotelModel.room![i].roomNumber}',
                                style: kStyle12B.copyWith(
                                  color:
                                      s.data == widget.hotelModel.room![i].sId
                                          ? kWhite
                                          : kPrimary,
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
        sizedBox16(),
      ],
    );
  }

  Widget services() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.hotelModel.room!.isEmpty
            ? myEmptyCard(
                context: context,
                emptyMsg: 'No services available',
                subTitle: '')
            : SizedBox(
                height: 40.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.hotelModel.service!.length,
                  itemBuilder: (c, i) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: const BoxDecoration(
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(color: kGrey, offset: Offset(3, 3))
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          myCachedNetworkImage(
                            myWidth: 30.0,
                            myHeight: 30.0,
                            myImage: widget.hotelModel.service![i].imagePath
                                .toString(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0)),
                          ),
                          sizedBox16(),
                          Text(
                            widget.hotelModel.service![i].serviceName!,
                            style: kStyle12B,
                          ),
                          sizedBox12(),
                        ],
                      ),
                    );
                  },
                ),
              ),
        sizedBox16(),
      ],
    );
  }

  Widget reviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '   Reviews :',
              style: kStyle14B,
            ),
            Text(
              'View all',
              style: kStyle14B.copyWith(color: kOrange),
            )
          ],
        ),
        sizedBox16(),
        myBlocBuilder(
          endpoint: '${getDotEnvValue('REVIEW')}/${widget.hotelModel.sId!}',
          mainGetBloc: reviewBloc,
          emptyMsg: 'No any reviews',
          subtitle: '',
          card: (resp) {
            List<ReviewModel> reviewModel = List<ReviewModel>.from(
                resp.map((i) => ReviewModel.fromJson(i)));
            return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: reviewModel.length > 2 ? 3 : reviewModel.length,
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
        sizedBox12(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: backgroundColor,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    routeSettings: ModalRoute.of(context)!.settings,
                    builder: ((builder) => reviewBottomSheet()));
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: kOrange,
                    size: 16.0,
                  ),
                  sizedBox2(),
                  sizedBox2(),
                  Text(
                    'Add a review',
                    style: kStyle14B.copyWith(color: kOrange),
                  ),
                ],
              ),
            ),
          ],
        ),
        sizedBox16(),
      ],
    );
  }

  Widget roomPrice() {
    return StreamBuilder<dynamic>(
        initialData: widget.hotelModel.room![0],
        stream: roomInfoBloc.stateStream,
        builder: (c, s) {
          Room room = s.data;
          return Container(
            margin: const EdgeInsets.only(right: 8.0),
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            decoration: const BoxDecoration(
              color: kWhite,
              boxShadow: [BoxShadow(color: kGrey, offset: Offset(3, 3))],
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Selected room: ', style: kStyle14B),
                    Text('Room no. ${room.roomNumber}', style: kStyle14B),
                  ],
                ),
                sizedBox2(),
                sizedBox2(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price: ', style: kStyle14B),
                    Text('Rs. ${room.price!.numberDecimal}',
                        style: kStyle18B.copyWith(color: kOrange)),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget reviewBottomSheet() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          12.0, 0.0, 12.0, MediaQuery.of(context).viewInsets.bottom),
      width: maxWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          sizedBox32(),
          Text(
            'Add Reviews ',
            style: kStyle14B,
          ),
          sizedBox16(),
          myRatingBar(5, onValueChanged: (v) {
            ratingValue = v;
          }),
          sizedBox16(),
          myTextFormField(
              isTextArea: true,
              context: context,
              labelText:
                  'Write something about ${widget.hotelModel.profile!.name} ...',
              errorMessage: '',
              form: formKeys[0],
              onValueChanged: (v) {
                reviewValue = v;
              }),
          Center(
            child: myButton(
              context: context,
              width: maxWidth(context) / 2,
              height: 50.0,
              text: 'Add Review',
              color: kOrange,
              validateKeys: formKeys,
              myTap: () async {
                await API().postData(
                  context: context,
                  model: ReviewModel(
                    hotelID: widget.hotelModel.sId,
                    rating: ratingValue,
                    review: reviewValue,
                  ),
                  endpoint: '${getDotEnvValue('REVIEW')}/add',
                  bloc: addReviewBtnBloc,
                  func: (resp) {
                    Navigator.pop(context);
                    reviewBloc.add(MainGetRefreshEvent());
                  },
                );
              },
              bloc: addReviewBtnBloc,
            ),
          ),
          sizedBox16(),
        ],
      ),
    );
  }

  Widget checkOutBottomSheet(Room room) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          12.0, 0.0, 12.0, MediaQuery.of(context).viewInsets.bottom),
      width: maxWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          sizedBox16(),
          roomPrice(),
          sizedBox16(),
          Center(
            child: myButton(
              context: context,
              width: maxWidth(context) / 2,
              height: 50.0,
              text: 'Checkout',
              color: kOrange,
              myTap: () async {
                await API().postData(
                  context: context,
                  model: BookingPostModel(
                    hotelId: widget.hotelModel.sId,
                    roomId: room.sId,
                  ),
                  endpoint: getDotEnvValue('BOOKING'),
                  bloc: checkoutBtnBloc,
                  func: (resp) {
                    Navigator.pop(context);
                  },
                );
              },
              bloc: checkoutBtnBloc,
            ),
          ),
          sizedBox16(),
        ],
      ),
    );
  }
}
