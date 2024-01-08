class HotelModel {
  String? sId;
  Profile? profile;
  List<Room>? room;
  List<Service>? service;

  HotelModel({this.sId, this.profile, this.room, this.service});

  HotelModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    if (json['room'] != null) {
      room = <Room>[];
      json['room'].forEach((v) {
        room!.add(Room.fromJson(v));
      });
    }
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (room != null) {
      data['room'] = room!.map((v) => v.toJson()).toList();
    }
    if (service != null) {
      data['service'] = service!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? latitude;
  String? longitude;
  int? role;
  List<String>? gallery;

  Profile(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.latitude,
      this.longitude,
      this.role,
      this.gallery});

  Profile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    role = json['role'];
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['role'] = role;
    data['gallery'] = gallery;
    return data;
  }
}

class Room {
  int? roomNumber;
  Price? price;
  String? sId;

  Room({this.roomNumber, this.price, this.sId});

  Room.fromJson(Map<String, dynamic> json) {
    roomNumber = json['room_number'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room_number'] = roomNumber;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['_id'] = sId;
    return data;
  }
}

class Price {
  String? numberDecimal;

  Price({this.numberDecimal});

  Price.fromJson(Map<String, dynamic> json) {
    numberDecimal = json['\$numberDecimal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$numberDecimal'] = numberDecimal;
    return data;
  }
}

class Service {
  String? serviceName;
  Price? price;
  String? sId;
  String? imagePath;

  Service({this.serviceName, this.price, this.sId, this.imagePath});

  Service.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    sId = json['_id'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_name'] = serviceName;
    data['imagePath'] = imagePath;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['_id'] = sId;
    return data;
  }
}
