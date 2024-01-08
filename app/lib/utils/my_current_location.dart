import 'package:app/model/pop/navigator_pop_model.dart';
import 'package:geolocator/geolocator.dart';

getCurrentLocation({required context}) async {
  NavigatorPopModel popModel = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
      .then((Position position) {
    return NavigatorPopModel(
        latitude: position.latitude, longitude: position.longitude);
  });
  return popModel;
}
