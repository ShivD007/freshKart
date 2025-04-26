class UpdateAddressReqEntity {
  final String address;
  final String userId;

  UpdateAddressReqEntity({required this.address, required this.userId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["address"] = address;
    data["userId"] = userId;

    return data;
  }
}
