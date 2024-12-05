import 'package:dartz/dartz.dart';
import '../../models/Settings/set_config_model.dart';
import '../../repositories/settings_repository.dart';
import '../../shared/errors/failures.dart';

class SetConfigProvider {
  final SettingsRepository settingsRepository;

  SetConfigProvider(this.settingsRepository);

  Future<Either<Failure, SetConfigResponseModel>> call({
    required String token,
    required SetConfigModel setConfigData,
  }) async {
    return await settingsRepository.setConfig(
      token: token,
      setConfigData: setConfigData,
    );
  }
}
