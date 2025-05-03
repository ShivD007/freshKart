import 'package:fresh_kart/features/settings/data/models/address_model.dart';

class UserEntity {
  final String fullName;
  final String email;
  final String phoneNo;
  final AddressModel? address;
  final String? accessToken;
  final String? refreshToken;
  final String id;

  UserEntity({
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      address:
          map['address'] == null ? null : AddressModel.fromJson(map['address']),
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNo': phoneNo,
      'address': address?.toJson(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      "id": id,
    };
  }

  UserEntity copyWith({
    String? fullName,
    String? email,
    String? phoneNo,
    AddressModel? address,
    String? accessToken,
    String? refreshToken,
    String? id,
  }) {
    return UserEntity(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      address: address ?? this.address,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      id: id ?? this.id,
    );
  }
}
