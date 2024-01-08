class TokenState {
  String? status;
  String? message;
  int? role;
  String? token;
  ProfileModel? profile;
  TokenState({this.status, this.message, this.role, this.token, this.profile});

  TokenState.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    role = json['role'];
    token = json['token'];
    profile =
        json['profile'] != null ? ProfileModel.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['role'] = role;
    data['token'] = token;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class ProfileModel {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? latitude;
  String? longitude;
  int? role;
  List<String>? gallery;

  ProfileModel(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.latitude,
      this.longitude,
      this.role,
      this.gallery});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
