class UpdateAddressReqEntity {
  final String address;
  final String userId;
  final String alternateMobileNo;
  final String pincode;

  UpdateAddressReqEntity({
    required this.address,
    required this.userId,
    required this.alternateMobileNo,
    required this.pincode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["address"] = address;
    data["userId"] = userId;
    data["alternateMobileNo"] = alternateMobileNo;
    data["pincode"] = pincode;

    return data;
  }
}
