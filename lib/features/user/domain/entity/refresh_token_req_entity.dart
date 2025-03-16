class RefreshTokenReqEntity {
  final String refreshToken;
  final String email;

  RefreshTokenReqEntity({required this.refreshToken, required this.email});

  Map toJson() {
    Map<String, dynamic> data = {};
    data["refreshToken"] = refreshToken;
    data["email"] = email;
    return data;
  }
}
