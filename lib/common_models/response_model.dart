class ResponseModel {
  final String message;
  final int status;
  final dynamic data;

  ResponseModel({
    required this.message,
    required this.status,
    required this.data,
  });

  // Factory constructor to create an instance from JSON
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
      data: json['data'], // Kept as dynamic
    );
  }

  // Converts the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data, // No transformation since it's dynamic
    };
  }
}
