abstract class Failure {
  final String message;

  Failure({required this.message});
}

//if data error from server
class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

//if no internet
class OfflineFailure extends Failure {
  OfflineFailure({required super.message});
}

// user insert wrong data in auth methods login or signup
class WrongDataFailure extends Failure {
  WrongDataFailure({required super.message});
}

class EmptyLocalStorageFailure extends Failure {
  EmptyLocalStorageFailure({required super.message});
}

class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure({required super.message});
}

class UnExpectedFailure extends Failure {
  UnExpectedFailure({required super.message});
}

class ClientCloseFailure extends Failure {
  ClientCloseFailure({required super.message});
}
