import 'dart:async';
import 'package:dartz/dartz.dart';
import '../models/Auth/login_model.dart';
import '../models/Auth/register_model.dart';
import '../models/Auth/user_data_model.dart';
import '../services/networking/auth_api_service.dart';
import '../shared/errors/failures.dart';
import '../shared/network_info/network_info.dart';
import 'repo_network_request.dart';

class AuthRepository {
  final AuthApiService authApiService;
  final NetworkInfo networkInfo;

  AuthRepository({
    required this.authApiService,
    required this.networkInfo,
  });

  Future<Either<Failure, UserModel>> postLogin(LoginModel loginModel) async {
    return RepoNetworkRequest.makeNetworkRequest<UserModel>(
      networkInfo: networkInfo,
      request: () => authApiService.postLoginApi(loginModel),
    );
  }

  Future<Either<Failure, UserModel>> postRegister(
      RegisterModel registerModel) async {
    return RepoNetworkRequest.makeNetworkRequest<UserModel>(
      networkInfo: networkInfo,
      request: () => authApiService.postRegisterApi(registerModel),
    );
  }
}
