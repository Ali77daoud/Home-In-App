import 'package:dartz/dartz.dart';
import '../../models/Settings/get_config_model.dart';
import '../../repositories/settings_repository.dart';
import '../../shared/errors/failures.dart';

class GetConfigProvider {
  final SettingsRepository settingsRepository;

  GetConfigProvider(this.settingsRepository);

  Future<Either<Failure, GetConfigModel>> call({
    required String token,
  }) async {
    return await settingsRepository.getConfig(token: token);
  }
}
