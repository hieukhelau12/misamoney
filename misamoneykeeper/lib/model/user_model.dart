class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  int? type;
  String? email;
  String? mobile;
  String? mobileCode;
  String? accessToken;
  String? refreshToken;
  String? accessTokenExpiration;
  String? refreshTokenExpiration;
  String? resetCode;
  int? numberCoins;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.type,
      this.email,
      this.mobile,
      this.mobileCode,
      this.accessToken,
      this.refreshToken,
      this.accessTokenExpiration,
      this.refreshTokenExpiration,
      this.resetCode,
      this.numberCoins});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    type = json['type'];
    email = json['email'];
    mobile = json['mobile'];
    mobileCode = json['mobile_code'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    accessTokenExpiration = json['access_token_expiration'];
    refreshTokenExpiration = json['refresh_token_expiration'];
    resetCode = json['reset_code'];
    numberCoins = json['number_coins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['type'] = type;
    data['email'] = email;
    data['mobile'] = mobile;
    data['mobile_code'] = mobileCode;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['access_token_expiration'] = accessTokenExpiration;
    data['refresh_token_expiration'] = refreshTokenExpiration;
    data['reset_code'] = resetCode;
    data['number_coins'] = numberCoins;
    return data;
  }
}