class PostLoginAccountReq {
  String? email;
  String? password;
  bool? rememberMe;

  PostLoginAccountReq({this.email, this.password, this.rememberMe});

  PostLoginAccountReq.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    rememberMe = json['rememberMe'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (email != null) {
      data['email'] = email;
    }
    if (password != null) {
      data['password'] = password;
    }
    if (rememberMe != null) {
      data['rememberMe'] = rememberMe;
    }
    return data;
  }
}
