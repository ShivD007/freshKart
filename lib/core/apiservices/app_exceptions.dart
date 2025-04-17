abstract class Failure implements Exception {
  final _message;
  final Map<String, dynamic>? response;
  Failure([this._message, this.response]);

  String toString() {
    return "$_message";
  }

  Map<String, dynamic>? getData() {
    return response;
  }
}

class FetchDataException extends Failure {
  FetchDataException([String? message]) : super(message);
}

class BadRequestException extends Failure {
  BadRequestException([message, response]) : super(message, response);
}

class UnauthorisedException extends Failure {
  UnauthorisedException([message, response]) : super(message, response);
}

class InvalidInputException extends Failure {
  InvalidInputException([String? message]) : super(message);
}

class LimitExceededException extends Failure {
  LimitExceededException([String? message]) : super(message);
}

class NotFoundException extends Failure {
  NotFoundException([String? message, dynamic response])
      : super(message, response);
}

class CommonFailureException extends Failure {
  CommonFailureException([String? message]) : super(message);
}

class TypeErrorException extends Failure {
  TypeErrorException([String? message]) : super(message);
}
