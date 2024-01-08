import 'package:app/model/pop/map/map_auto_complete_predictions_model.dart';
import 'package:app/model/pop/navigator_pop_model.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_focus_remover.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/map/my_map_controller.dart';
import 'package:app/widgets/my_expansion_tile.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String addressName;
  const MyMap({
    required this.latitude,
    required this.longitude,
    required this.addressName,
    Key? key,
  }) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    mapController.animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    mapController.animation = Tween<double>(begin: 0.0, end: 3.0).animate(
      CurvedAnimation(
          parent: mapController.animationController!, curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mapController.animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => myFocusRemover(context),
      child: Scaffold(
        body: Stack(
          children: [
            googleMapCard(),
            animatedMarkerWidget(),
            Positioned(
              top: 0,
              child: searchCard(),
            ),
            Positioned(
              bottom: 0.0,
              child: selectedLocationCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget googleMapCard() {
    return StreamBuilder<dynamic>(
        initialData: NavigatorPopModel(
          latitude: widget.latitude,
          longitude: widget.longitude,
        ),
        stream: mapController.mapBloc.stateStream,
        builder: (c, s) {
          return GoogleMap(
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
                zoom: 16, target: LatLng(s.data.latitude, s.data.longitude)),
            onCameraMoveStarted: () =>
                mapController.onCameraMoveStarted(context),
            onCameraMove: (position) =>
                mapController.onCameraMove(context, position),
            onCameraIdle: () => mapController.onCameraIdle(context, s.data),
            onMapCreated: (GoogleMapController controller) async {
              mapController.googleMapController.complete(controller);
            },
          );
        });
  }

  Widget animatedMarkerWidget() {
    return AnimatedBuilder(
      animation: mapController.animationController!,
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    bottom: 52,
                  ),
                  child: Image.asset(
                    "assets/mobile/marker.png",
                    height: mapController.animationController!.value + 55,
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: mapController.animationController!.value * 1),
                  child: Container(
                    height: mapController.animationController!.value * 1.9,
                    width: mapController.animationController!.value * 4,
                    transform: Matrix4.translationValues(0, -45, 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kBlack.withOpacity(0.4),
                      boxShadow: const [
                        BoxShadow(
                          spreadRadius: 3,
                          blurRadius: 8,
                          color: kBlack,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget searchCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      width: maxWidth(context),
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26.0),
          bottomRight: Radius.circular(26.0),
        ),
      ),
      child: Column(
        children: [
          sizedBox32(),
          sizedBox24(),
          mapTextForm(context),
          placeSuggestionCard(context),
        ],
      ),
    );
  }

  Widget placeSuggestionCard(context) {
    return StreamBuilder<dynamic>(
        initialData: null,
        stream: mapController.suggestionBloc.stateStream,
        builder: (cc, ss) {
          return ss.data == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: myExpansionTile(
                    context: context,
                    title: Text(
                      'Results:',
                      style: kStyle14B,
                    ),
                    children: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ss.data.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (c, i) {
                          List<Predictions> placeSuggestion = ss.data;
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: i == placeSuggestion.length - 1
                                    ? 0.0
                                    : 12.0),
                            child: GestureDetector(
                              onTap: () =>
                                  mapController.onSuggestedPlaceClicked(context,
                                      placeSuggestion[i].placeId.toString()),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: kRed,
                                    size: 25.0,
                                  ),
                                  sizedBox12(),
                                  Expanded(
                                    child: Text(
                                      placeSuggestion[i].description.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: kStyle14B,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                );
        });
  }

  Widget mapTextForm(context) {
    return Column(
      children: [
        TextFormField(
          cursorColor: kBlack,
          style: kStyle12,
          controller: mapController.searchTextCtrl,
          textInputAction: TextInputAction.go,
          onFieldSubmitted: (value) =>
              mapController.searchBtnClicked(value, context),
          decoration: InputDecoration(
            suffixIcon: StreamBuilder<dynamic>(
                initialData: 1,
                stream: mapController.loadingBloc.stateStream,
                builder: (c, s) {
                  return GestureDetector(
                      onTap: () {
                        if (s.data == 1) {
                          myFocusRemover(context);
                          mapController.searchTextCtrl.clear();
                        }
                      },
                      child: s.data == 1
                          ? const Icon(
                              Icons.cancel,
                              size: 24,
                              color: kPrimary,
                            )
                          : Container(
                              margin: const EdgeInsets.all(15.0),
                              width: 15.0,
                              height: 15.0,
                              child: const CircularProgressIndicator(
                                color: kWhite,
                                backgroundColor: kGreen,
                                strokeWidth: 1.0,
                              ),
                            ));
                }),
            errorMaxLines: 2,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
            filled: true,
            fillColor: backgroundColor,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(26.0),
              ),
              borderSide: BorderSide(color: kTransparent, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(26.0),
              ),
              borderSide: BorderSide(color: kPrimary, width: 1.5),
            ),
            errorStyle: kStyle12.copyWith(color: kRed),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(26.0),
              ),
              borderSide: BorderSide(color: kBlack, width: 1.5),
            ),
            hintText: 'Search places...',
            hintStyle: kStyle12,
          ),
        ),
      ],
    );
  }

  Widget selectedLocationCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: maxWidth(context),
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
        ),
      ),
      child: StreamBuilder<dynamic>(
          initialData: NavigatorPopModel(
            latitude: widget.latitude,
            longitude: widget.longitude,
            name: widget.addressName,
          ),
          stream: mapController.btnBloc.stateStream,
          builder: (c, s) {
            return Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: kRed,
                  size: 30.0,
                ),
                sizedBox12(),
                Expanded(
                  child: Text(
                    s.data == null ? 'Locating...' : s.data.name,
                    style: kStyle14B,
                  ),
                ),
                sizedBox12(),
                GestureDetector(
                  onTap: () {
                    mapController.searchTextCtrl.clear();
                    Navigator.pop(context, s.data);
                  },
                  child: const CircleAvatar(
                    backgroundColor: kPrimary,
                    child: Icon(
                      Icons.check,
                      color: kWhite,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
