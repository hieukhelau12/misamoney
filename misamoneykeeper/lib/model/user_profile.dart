class UserProfile {
  int? userId;
  int? userDetailsId;
  String? email;
  String? mobile;
  String? firstName;
  String? lastName;
  String? uImage;
  int? uGender;
  String? uBirthday;
  String? uAddress;
  String? uJob;

  UserProfile(
      {userId,
      userDetailsId,
      email,
      mobile,
      firstName,
      lastName,
      uImage,
      uGender,
      uBirthday,
      uAddress,
      uJob});

  UserProfile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userDetailsId = json['user_details_id'];
    email = json['email'];
    mobile = json['mobile'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    uImage = json['u_image'];
    uGender = json['u_gender'];
    uBirthday = json['u_birthday'];
    uAddress = json['u_address'];
    uJob = json['u_job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = userId;
    data['user_details_id'] = userDetailsId;
    data['email'] = email;
    data['mobile'] = mobile;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['u_image'] = uImage;
    data['u_gender'] = uGender;
    data['u_birthday'] = uBirthday;
    data['u_address'] = uAddress;
    data['u_job'] = uJob;
    return data;
  }
}
