class LoginState {
  String? email;
  String? password;
  String? platform;

  LoginState({
    this.email,
    this.password,
    this.platform,
  });

  LoginState.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['platform'] = platform;
    return data;
  }
}
