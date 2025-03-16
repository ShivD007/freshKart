abstract class Failure implements Exception {
  final _message;
  final _prefix;
  final Map<String, dynamic>? response;
  Failure([this._message, this._prefix, this.response]);

  String toString() {
    return "$_prefix$_message";
  }

  Map<String, dynamic>? getData() {
    return response;
  }
}

class FetchDataException extends Failure {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends Failure {
  BadRequestException([message, response]) : super(message, "", response);
}

class UnauthorisedException extends Failure {
  UnauthorisedException([message, response]) : super(message, "", response);
}

class InvalidInputException extends Failure {
  InvalidInputException([String? message]) : super(message, "");
}

class LimitExceededException extends Failure {
  LimitExceededException([String? message]) : super(message, "");
}

class NotFoundException extends Failure {
  NotFoundException([String? message]) : super(message, "");
}
