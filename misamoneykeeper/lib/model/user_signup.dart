// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserSignUp {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String password;

  UserSignUp({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.password,
  });

  factory UserSignUp.fromJson(Map<String, dynamic> json) {
    return UserSignUp(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
    );
  }
}
