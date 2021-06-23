import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/security/domain/entity/login_command.dart';
import 'package:lz_flutter_app/security/domain/entity/register_command.dart';
import 'package:lz_flutter_app/security/types/domain_primitive/session.dart';
import 'package:lz_flutter_app/security/external/local_auth_service.dart';
import 'package:lz_flutter_app/security/external/social_login_service.dart';
import 'package:lz_flutter_app/security/repositories/security_repository.dart';

@injectable
class SecurityApplication {

  LocalAuthService _localAuthService;
  SocialLoginService _socialLoginService;
  SecurityRepository _securityRepository;

  SecurityApplication(this._securityRepository,this._localAuthService,this._socialLoginService);

  //账号密码登录
  Future<void> login(LoginCommand loginCommand) async {
    loginCommand.checkValid();
    final loginResponse = await _securityRepository.login(loginCommand);
    loginResponse.toSession().save();
  }

  //注册
  Future<void> register(RegisterCommand registerCommand) async {
    registerCommand.checkValid();
    final loginResponse = await _securityRepository.register(registerCommand);
    loginResponse.toSession().save();
  }

  //Google登录
  Future loginWithGoogle() async {
    final googleId = await _socialLoginService.signInWithGoogle();
    final loginResponse = await _securityRepository.googleSignIn(googleId);
    loginResponse.toSession().save();
  }

  //关联Google
  Future bindGoogleAccount() async {
    final googleId = await _socialLoginService.signInWithGoogle();
    await _securityRepository.bindGoogleAccount(googleId);
  }

  //登出
  Future<void> logout() async {
    await SpUtil.putObject('user','');
  }

  //指纹/脸部识别
  Future<bool> loginWithLocalAuth(BiometricType biometricType,String localizedReason) async => _localAuthService.loginWithLocalAuth(biometricType, localizedReason);

  //刷新token
  Future refreshToken() async {
    final Session session = Session.fromJson(SpUtil.getObject('user') as Map<String, dynamic> );
    await _securityRepository.refreshAccessToken(session);
  }

  Session? getSession(){
    if(SpUtil.getObject('user') == null){
      return null;
    }
    final Session session = Session.fromJson(SpUtil.getObject('user') as Map<String, dynamic> );
    return session;
  }

}
