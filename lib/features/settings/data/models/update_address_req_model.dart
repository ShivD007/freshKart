import 'package:fresh_kart/features/settings/domain/entity/update_address_req_entity.dart';

class UpdateAddressReqModel {
  final String address;
  final String userId;

  UpdateAddressReqModel({required this.address, required this.userId});

  factory UpdateAddressReqModel.fromMap(Map<String, dynamic> map) {
    return UpdateAddressReqModel(
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'userId': userId,
    };
  }

  factory UpdateAddressReqModel.fromEntity(UpdateAddressReqEntity entity) {
    return UpdateAddressReqModel(
      address: entity.address,
      userId: entity.userId,
    );
  }

  UpdateAddressReqEntity toEntity() {
    return UpdateAddressReqEntity(
      address: address,
      userId: userId,
    );
  }
}
