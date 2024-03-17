class PostLoginAccountResp {
  String? token;
  String? expiration;

  PostLoginAccountResp({this.token, this.expiration});

  PostLoginAccountResp.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (token != null) {
      data['token'] = token;
    }
    if (expiration != null) {
      data['expiration'] = expiration;
    }
    return data;
  }
}
