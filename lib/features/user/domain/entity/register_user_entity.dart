class RegisterUserEntity {
  final String email;
  final String password;
  final String fullName;
  final String phoneNo;

  RegisterUserEntity({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNo,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["email"] = email;
    data["password"] = password;
    data["phoneNo"] = phoneNo;
    data["fullName"] = fullName;

    return data;
  }
}
