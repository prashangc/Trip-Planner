import 'dart:async';
import 'dart:io';

import 'package:app/model/map/map_get_place_details_model.dart';
import 'package:app/model/pop/map/map_auto_complete_predictions_model.dart';
import 'package:app/model/pop/navigator_pop_model.dart';
import 'package:app/services/api/api.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_focus_remover.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

class MapController {
  AnimationController? animationController;
  Animation<double>? animation;
  TextEditingController searchTextCtrl = TextEditingController();
  StateHandlerBloc mapBloc = StateHandlerBloc();
  StateHandlerBloc btnBloc = StateHandlerBloc();
  StateHandlerBloc suggestionBloc = StateHandlerBloc();
  StateHandlerBloc loadingBloc = StateHandlerBloc();
  final Completer<GoogleMapController> googleMapController = Completer();
  String baseUrl = getDotEnvValue('GOOGLE_MAP_BASE_URL');
  String autoCompleteEndpoint =
      getDotEnvValue('GOOGLE_MAP_AUTO_COMPLETE_ENDPOINT');
  String apiKey = getDotEnvValue('GOOGLE_MAP_API_KEY');
  String placeDetailsEndpoint = getDotEnvValue('GOOGLE_MAP_GET_PLACE_ENDPOINT');

  onCameraMoveStarted(context) {
    myFocusRemover(context);
  }

  onCameraMove(context, CameraPosition position) {
    myFocusRemover(context);
    animationController!.repeat(reverse: true);
    // searchTextCtrl.clear();
    btnBloc.storeData(data: null);
    mapBloc.storeData(
      data: NavigatorPopModel(
        latitude: position.target.latitude,
        longitude: position.target.longitude,
      ),
    );
  }

  onCameraIdle(context, NavigatorPopModel data) async {
    myFocusRemover(context);
    // searchTextCtrl.clear();
    String placeName = await getPlaceNameFromLatLng(context, data);
    btnBloc.storeData(
      data: NavigatorPopModel(
        latitude: data.latitude,
        longitude: data.longitude,
        name: placeName,
      ),
    );
  }

  searchBtnClicked(String value, context) async {
    loadingBloc.storeData(data: 0);
    try {
      Response response = await api.getData(
        context: context,
        googleMapBaseURL: baseUrl,
        endpoint:
            '$autoCompleteEndpoint?input=$value&key=$apiKey&components=country:NP',
      );
      if (response.statusCode == 200) {
        var resp = convert.jsonDecode(response.body.toString())['predictions'];
        List<Predictions> placeSuggestion =
            List<Predictions>.from(resp.map((i) => Predictions.fromJson(i)));
        suggestionBloc.storeData(data: placeSuggestion);
        loadingBloc.storeData(data: 1);
      } else {
        loadingBloc.storeData(data: 1);
      }
    } on SocketException {
      loadingBloc.storeData(data: 1);
      if (kDebugMode) {
        print('no internet connection');
      }
    }
  }

  onSuggestedPlaceClicked(context, String placeId) async {
    NavigatorPopModel? pop = await getLatLngFromPlaceName(context, placeId);
    if (pop != null) {
      GoogleMapController controller = await googleMapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(pop.latitude!, pop.longitude!),
            zoom: 16,
          ),
        ),
      );
    }
  }

  Future<String> getPlaceNameFromLatLng(context, NavigatorPopModel data) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(data.latitude!, data.longitude!);
    Placemark place = placemark[0];
    String mainAddress = place.thoroughfare.toString();
    String area = place.subLocality.toString();
    String subArea = place.locality.toString();
    String district = place.subAdministrativeArea.toString();
    String country = place.country.toString();
    String street = place.street.toString();
    String address;
    if (mainAddress == '') {
      address = '$street, $subArea, $district, $country';
    } else {
      address = '$street, $mainAddress, $district, $country';
    }

    if (subArea == district) {
      address = '$street, $mainAddress, $area, $district, $country';
    }
    return address;
  }

  getLatLngFromPlaceName(context, String placeId) async {
    loadingBloc.storeData(data: 0);
    try {
      Response response = await api.getData(
        context: context,
        googleMapBaseURL: baseUrl,
        endpoint:
            '$placeDetailsEndpoint?place_id=$placeId&key=$apiKey&components=country:NP',
      );
      if (response.statusCode == 200) {
        var resp = convert.jsonDecode(response.body.toString());
        MapGetPlaceDetailsModel placeData =
            MapGetPlaceDetailsModel.fromJson(resp);
        loadingBloc.storeData(data: 1);
        return NavigatorPopModel(
          latitude: placeData.result!.geometry!.location!.lat,
          longitude: placeData.result!.geometry!.location!.lng,
          name: placeData.result!.formattedAddress,
        );
      } else {
        loadingBloc.storeData(data: 1);
      }
    } on SocketException {
      loadingBloc.storeData(data: 1);
      if (kDebugMode) {
        print('no internet connection');
      }
    }
  }
}

MapController mapController = MapController();
