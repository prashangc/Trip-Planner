class RegisterState {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? passwordConfirmation;
  int? role;
  String? address;
  String? latitude;
  String? longitude;

  RegisterState({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.role,
    this.address,
    this.latitude,
    this.longitude,
    this.passwordConfirmation,
  });

  RegisterState.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    return data;
  }
}
