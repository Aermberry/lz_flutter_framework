import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lz_flutter_app/security/exception/local_auth_exception.dart';

/// 需要参考 https://pub.dev/packages/local_auth
/// 配置Android iOS

@injectable
class LocalAuthService {
  LocalAuthentication localAuth = LocalAuthentication();

  Future<bool> loginWithLocalAuth(BiometricType biometricType, String localizedReason) async {
    final List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();
    if (!await localAuth.canCheckBiometrics) {
      throw LocalAuthException(LocalAuthExceptionCode.cantSupportBiometrics, 'the device can not support biometrics');
    }
    if (!availableBiometrics.contains(biometricType)) {
      throw LocalAuthException(LocalAuthExceptionCode.noAvailableBiometrics, 'the biometricType no available');
    }
    return localAuth.authenticate(localizedReason: localizedReason, biometricOnly: true);
  }

}
