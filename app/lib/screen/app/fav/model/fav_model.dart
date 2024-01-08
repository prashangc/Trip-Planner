import 'package:app/screen/dashboard/room/model/hotel_model.dart';

class FavouriteModel {
  String? sId;
  String? userId;
  HotelModel? hotel;
  int? iV;

  FavouriteModel({this.sId, this.userId, this.hotel, this.iV});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    hotel = json['hotel'] != null ? HotelModel.fromJson(json['hotel']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_id'] = userId;
    if (hotel != null) {
      data['hotel'] = hotel!.toJson();
    }
    data['__v'] = iV;
    return data;
  }
}
