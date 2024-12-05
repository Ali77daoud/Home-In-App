class OfflineException implements Exception {
  final String message;

  OfflineException(this.message);

  @override
  String toString() {
    return message;
  }
}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() {
    return message;
  }
}

class UnAuthorizedException implements Exception {
  final String message;

  UnAuthorizedException(this.message);

  @override
  String toString() {
    return message;
  }
}

class WrongDataException implements Exception {
  final String message;

  WrongDataException(this.message);

  @override
  String toString() {
    return message;
  }
}

class LocalStorageEmptyException implements Exception {
  final String message;

  LocalStorageEmptyException(this.message);

  @override
  String toString() {
    return message;
  }
}

class RequestTimeOutException implements Exception {
  final String message;

  RequestTimeOutException(this.message);

  @override
  String toString() {
    return message;
  }
}
