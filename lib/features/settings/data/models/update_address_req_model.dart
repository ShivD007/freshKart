import 'package:fresh_kart/features/settings/domain/entity/update_address_req_entity.dart';

class UpdateAddressReqModel {
  final String address;
  final String userId;
  final String alternateMobileNo;
  final String pincode;

  UpdateAddressReqModel({
    required this.address,
    required this.userId,
    required this.alternateMobileNo,
    required this.pincode,
  });

  factory UpdateAddressReqModel.fromMap(Map<String, dynamic> map) {
    return UpdateAddressReqModel(
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      alternateMobileNo: map['alternateMobileNo'] ?? '',
      pincode: map['pincode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'userId': userId,
      'pincode': pincode,
      'alternateMobileNo': alternateMobileNo,
    };
  }

  factory UpdateAddressReqModel.fromEntity(UpdateAddressReqEntity entity) {
    return UpdateAddressReqModel(
      address: entity.address,
      userId: entity.userId,
      pincode: entity.pincode,
      alternateMobileNo: entity.alternateMobileNo,
    );
  }

  UpdateAddressReqEntity toEntity() {
    return UpdateAddressReqEntity(
      address: address,
      userId: userId,
      pincode: pincode,
      alternateMobileNo: alternateMobileNo,
    );
  }
}
