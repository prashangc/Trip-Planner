class BookingPostModel {
  String? hotelId;
  String? roomId;

  BookingPostModel({this.hotelId, this.roomId});

  BookingPostModel.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotel_id'];
    roomId = json['room_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotel_id'] = hotelId;
    data['room_id'] = roomId;
    return data;
  }
}
