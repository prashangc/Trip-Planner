import 'package:app/screen/dashboard/room/model/hotel_model.dart';

class BookingModel {
  Room? room;
  String? sId;
  String? userId;
  HotelModel? hotel;
  int? status;
  int? iV;

  BookingModel(
      {this.room, this.sId, this.userId, this.hotel, this.status, this.iV});

  BookingModel.fromJson(Map<String, dynamic> json) {
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    sId = json['_id'];
    userId = json['user_id'];
    hotel = json['hotel'] != null ? HotelModel.fromJson(json['hotel']) : null;
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (room != null) {
      data['room'] = room!.toJson();
    }
    data['_id'] = sId;
    data['user_id'] = userId;
    if (hotel != null) {
      data['hotel'] = hotel!.toJson();
    }
    data['status'] = status;
    data['__v'] = iV;
    return data;
  }
}
