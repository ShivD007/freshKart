class LoginReqEntity {
  final String email;
  final String password;

  LoginReqEntity({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["email"] = email;
    data["password"] = password;

    return data;
  }
}
