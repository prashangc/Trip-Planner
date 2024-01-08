class RoomState {
  String? roomId;
  String? price;
  int? roomNo;

  RoomState({this.roomId, this.roomNo, this.price});

  RoomState.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    price = json['price'];
    roomNo = json['room_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room_id'] = roomId;
    data['price'] = price;
    data['room_no'] = roomNo;
    return data;
  }
}
