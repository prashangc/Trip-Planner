class ReviewModel {
  String? sId;
  String? hotelID;
  User? user;
  String? hotel;
  int? rating;
  String? review;
  int? iV;

  ReviewModel(
      {this.sId,
      this.user,
      this.hotelID,
      this.hotel,
      this.rating,
      this.review,
      this.iV});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    hotel = json['hotel'];
    hotelID = json['hotel_id'];
    rating = json['rating'];
    review = json['review'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['hotel_id'] = hotelID;
    data['hotel'] = hotel;
    data['rating'] = rating;
    data['review'] = review;
    data['__v'] = iV;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? latitude;
  String? longitude;
  int? role;
  List<String>? gallery;

  User(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.latitude,
      this.longitude,
      this.role,
      this.gallery});

  User.fromJson(Map<String, dynamic> json) {
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
