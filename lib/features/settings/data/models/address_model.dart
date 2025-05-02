class AddressModel {
  String? id;
  String address;
  String? pincode;
  String? alternateMobileNo;

  AddressModel({
    this.id,
    required this.address,
    required this.pincode,
    required this.alternateMobileNo,
  });

  // Factory method to create an Address instance from a JSON map
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      address: json['address'],
      pincode: json['pincode']?.toString(),
      alternateMobileNo: json['alternateMobileNo']?.toString(),
    );
  }

  // Method to convert an Address instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'address': address,
      'pincode': pincode,
      'alternateMobileNo': alternateMobileNo,
    };
  }
}
