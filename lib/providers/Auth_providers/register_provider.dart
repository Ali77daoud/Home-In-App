import 'package:dartz/dartz.dart';
import '../../models/Auth/register_model.dart';
import '../../models/Auth/user_data_model.dart';
import '../../repositories/auth_repository.dart';
import '../../shared/errors/failures.dart';

class RegisterProvider {
  final AuthRepository authRepository;

  RegisterProvider(this.authRepository);

  Future<Either<Failure, UserModel>> call(RegisterModel registerModel) async {
    return await authRepository.postRegister(registerModel);
  }
}
